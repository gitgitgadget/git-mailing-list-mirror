Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39A9F20248
	for <e@80x24.org>; Tue, 12 Mar 2019 01:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfCLBz4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 21:55:56 -0400
Received: from mail-io1-f53.google.com ([209.85.166.53]:44209 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfCLBz4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 21:55:56 -0400
Received: by mail-io1-f53.google.com with SMTP id u12so647385iop.11
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 18:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=8ViuRGyrHizOCqdsdELxxwB3ZgryUrfBz30sCsuRa24=;
        b=KQI4z9QA+lS8KsR2SnSM3QXJLptDQaPf1cTYXQq8qp0oeu8ZOtTf/+DJmleNjwxh2e
         fHxd/tG3N6jo/5keejUvQ4rfREWERVVPq+9xdJF78U/e7Q4RdABPE9kEfUGOpCoz01/T
         fwrqVY/fJjoVI0xYubABzt57+uEvtgbTxXWQLmlOWhWWS66o64NvwvMRGxcFjRkBKSm1
         dEFQ5NmBMd8QQSX10TyIE/MxWuutSFPUpkRDI4VswU+gYP/aaYmW/aRNGIYE4RkHAowV
         DSRRe7fW72mkMCn1mVZ7yE7W6UAaoaZN4HejEynunCSW3ikgeXtBuOTapFAeI33JgOLI
         BLJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=8ViuRGyrHizOCqdsdELxxwB3ZgryUrfBz30sCsuRa24=;
        b=mV9teIIud52DqkOapVeFf21B/wcI/v8bblok5h6DRI6L0IQ4zudVoV7WORUbthc40d
         RA6ueqYDUx5DkOhxC5v0o94EXtEe1rIbEWBwUjcb/X0OcuV4YxnFiFAr8uCw7/b+nMOV
         ft6BaixCvpkrn+I7BrCAkpvYF12RIJtw138rKnVDfk/d3VcL4x5SgPX2VFaghxrWH6v7
         yh8bFEv5EvrFk1zV2gAAZQFyc3Mj3PiRvvnwnyNZkAdpuj+Q2fgWzfe2D/9/F9VWJ8C3
         5UWtNdbd6Fso9IRK97sRV+Edg+U3sF8JPdQD9K6t1mEAndkYuCfA8ZOq0qSspu9VUGiJ
         S8mw==
X-Gm-Message-State: APjAAAVnnwmKnaINkpY49780N9FjeGOCrCS2OMvX/VNU1NqV3gOHknmm
        no2aqwb9NUKGiasdg8Sixbi/b0TDrxi9Tvmbgcc=
X-Google-Smtp-Source: APXvYqxL2Q5ujWA3HPAQwzYsa5uofSG3ZwgrNgtrezcWfaQeMk9uH0yq3UKnyUwXNwqFx7K3jaIG6FaA2d2gSiWMIqw=
X-Received: by 2002:a6b:8d87:: with SMTP id p129mr6134763iod.10.1552355755302;
 Mon, 11 Mar 2019 18:55:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAH8yC8nnFYt0raL+twrG_v8XZn_FDJWyM=tH=QL13Z70_bHRiQ@mail.gmail.com>
 <CAPig+cTCOfDCv=L3EWUqgVZx1VCdqt5ZjmSQMwHLX=R4C4hgTA@mail.gmail.com>
 <CAH8yC8=jtBURyr-mFJSe_cd4zNJfJDt672jZ+izo=z75ZBheug@mail.gmail.com>
 <20190311222805.GA6215@flurp.local> <CAH8yC8kHhhWA+ONv17LdLpvy6ubH3CTvJ6=ehP5MQLi_=n1=bQ@mail.gmail.com>
In-Reply-To: <CAH8yC8kHhhWA+ONv17LdLpvy6ubH3CTvJ6=ehP5MQLi_=n1=bQ@mail.gmail.com>
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Mon, 11 Mar 2019 21:55:23 -0400
Message-ID: <CAH8yC8=PKro1_WW=wJQoVHC88cziJPfgkHh6jNKOUxeFn3KVsQ@mail.gmail.com>
Subject: Re: Solaris and sed: Too many commands, last: s/\n//
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000005d143f0583dbfd42"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--0000000000005d143f0583dbfd42
Content-Type: text/plain; charset="UTF-8"

On Mon, Mar 11, 2019 at 9:07 PM Jeffrey Walton <noloader@gmail.com> wrote:
>
> On Mon, Mar 11, 2019 at 6:28 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> >
> > On Mon, Mar 11, 2019 at 05:43:55PM -0400, Jeffrey Walton wrote:
> > > On Mon, Mar 11, 2019 at 5:15 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > > > On Mon, Mar 11, 2019 at 4:32 PM Jeffrey Walton <noloader@gmail.com> wrote:
> > > > > I enabled self tests for Solaris. Solaris has some anemic utilities so
> > > > > I put /usr/gnu/bin first on-path.
> > > >
> > > > The first question is if you are really running GNU 'sed'? My guess is
> > > > "no, it's still picking up Solaris's 'sed'".
> > >
> > > I believe so. After modifying PATH, command -v returns:
> > >
> > >     Solaris tools:
> > >          sed: /usr/gnu/bin/sed
> > >          awk: /usr/gnu/bin/awk
> > >         grep: /usr/gnu/bin/grep
> > >
> > > (This was added to my scripts to confirm).
> > ...
> >
> > > Maybe Git would benefit from SED, AWK and GREP variables like PERL.
> >
> > Very possibly.
>
> Another potential workaround is to use Perl. Perl is already a
> prerequisite, it get passed to the test gear through PERL_PATH, and it
> avoids Solaris' anemic tools.
>
> Sadly my Perl sucks. You would be disappointed if I tried to whip up a patch.

Oh man, you're using GNU make. I thought Git was using that anemic
Posix Make. See attached.

I think Solaris provides an older gawk. Is this an easier problem:

    awk: chainlint.sed:88: :squash
    awk: chainlint.sed:88: ^ syntax error
    awk: chainlint.sed:91:  s/\\\n//
    awk: chainlint.sed:91:    ^ backslash not last character on line
    Usage: awk [POSIX or GNU style options] -f progfile [--] file ...
    Usage: awk [POSIX or GNU style options] [--] 'program' file ...

Jeff

--0000000000005d143f0583dbfd42
Content-Type: application/octet-stream; name="git2.patch"
Content-Disposition: attachment; filename="git2.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jt54gxkz0>
X-Attachment-Id: f_jt54gxkz0

LS0tIHQvTWFrZWZpbGUKKysrIHQvTWFrZWZpbGUKQEAgLTExLDExICsxMSwyNSBAQAogVEVTVF9T
SEVMTF9QQVRIID89ICQoU0hFTExfUEFUSCkKIFBFUkxfUEFUSCA/PSAvdXNyL2Jpbi9wZXJsCiBU
QVIgPz0gJChUQVIpCitBV0sgPz0gJChBV0spCitTRUQgPz0gJChTRUQpCitHUkVQID89ICQoR1JF
UCkKIFJNID89IHJtIC1mCiBQUk9WRSA/PSBwcm92ZQogREVGQVVMVF9URVNUX1RBUkdFVCA/PSB0
ZXN0CiBURVNUX0xJTlQgPz0gdGVzdC1saW50CiAKKyMgRml4IFNvbGFyaXMgdG9vbHMuIEdOVSB0
b29scyBhdCAvdXNyL2dudS9iaW4uIFBvc2l4IHRvb2xzIC91c3IveHBnNC9iaW4uCitpZm5lcSAo
JCh3aWxkY2FyZCAvdXNyL2dudS9iaW4vZ3JlcCksKQorICBHUkVQIDo9IC91c3IvZ251L2Jpbi9n
cmVwCitlbmRpZgoraWZuZXEgKCQod2lsZGNhcmQgL3Vzci9nbnUvYmluL3NlZCksKQorICBTRUQg
Oj0gL3Vzci9nbnUvYmluL3NlZAorZW5kaWYKK2lmbmVxICgkKHdpbGRjYXJkIC91c3IvZ251L2Jp
bi9hd2spLCkKKyAgU0VEIDo9IC91c3IvZ251L2Jpbi9hd2sKK2VuZGlmCisKIGlmZGVmIFRFU1Rf
T1VUUFVUX0RJUkVDVE9SWQogVEVTVF9SRVNVTFRTX0RJUkVDVE9SWSA9ICQoVEVTVF9PVVRQVVRf
RElSRUNUT1JZKS90ZXN0LXJlc3VsdHMKIENIQUlOTElOVFRNUCA9ICQoVEVTVF9PVVRQVVRfRElS
RUNUT1JZKS9jaGFpbmxpbnR0bXAKQEAgLTM1LDcgKzQ5LDcgQEAKIFRHSVRXRUIgPSAkKHNvcnQg
JCh3aWxkY2FyZCB0OTVbMC05XVswLTldLSouc2gpKQogVEhFTFBFUlMgPSAkKHNvcnQgJChmaWx0
ZXItb3V0ICQoVCksJCh3aWxkY2FyZCAqLnNoKSkpCiBDSEFJTkxJTlRURVNUUyA9ICQoc29ydCAk
KHBhdHN1YnN0IGNoYWlubGludC8lLnRlc3QsJSwkKHdpbGRjYXJkIGNoYWlubGludC8qLnRlc3Qp
KSkKLUNIQUlOTElOVCA9IHNlZCAtZiBjaGFpbmxpbnQuc2VkCitDSEFJTkxJTlQgPSAkKFNFRCkg
LWYgY2hhaW5saW50LnNlZAogCiBhbGw6ICQoREVGQVVMVF9URVNUX1RBUkdFVCkKIApAQCAtNDQs
OCArNTgsOCBAQAogCiBmYWlsZWQ6CiAJQGZhaWxlZD0kJChjZCAnJChURVNUX1JFU1VMVFNfRElS
RUNUT1JZX1NRKScgJiYgXAotCQlncmVwIC1sICdeZmFpbGVkIFsxLTldJyAqLmNvdW50cyB8IFwK
LQkJc2VkIC1uICdzL1wuY291bnRzJCQvLnNoL3AnKSAmJiBcCisJCSQoR1JFUCkgLWwgJ15mYWls
ZWQgWzEtOV0nICouY291bnRzIHwgXAorCQkkKFNFRCkgLW4gJ3MvXC5jb3VudHMkJC8uc2gvcCcp
ICYmIFwKIAl0ZXN0IC16ICIkJGZhaWxlZCIgfHwgJChNQUtFKSAkJGZhaWxlZAogCiBwcm92ZTog
cHJlLWNsZWFuIGNoZWNrLWNoYWlubGludCAkKFRFU1RfTElOVCkKQEAgLTczLDcgKzg3LDcgQEAK
IAllcnI9MCAmJiBcCiAJZm9yIGkgaW4gJChDSEFJTkxJTlRURVNUUyk7IGRvIFwKIAkJJChDSEFJ
TkxJTlQpIDxjaGFpbmxpbnQvJCRpLnRlc3QgfCBcCi0JCXNlZCAtZSAnL14jIExJTlQ6IC9kJyA+
JyQoQ0hBSU5MSU5UVE1QX1NRKScvJCRpLmFjdHVhbCAmJiBcCisJCSQoU0VEKSAtZSAnL14jIExJ
TlQ6IC9kJyA+JyQoQ0hBSU5MSU5UVE1QX1NRKScvJCRpLmFjdHVhbCAmJiBcCiAJCWRpZmYgLXUg
Y2hhaW5saW50LyQkaS5leHBlY3QgJyQoQ0hBSU5MSU5UVE1QX1NRKScvJCRpLmFjdHVhbCB8fCBl
cnI9MTsgXAogCWRvbmUgJiYgZXhpdCAkJGVycgogCkBAIC04MSw3ICs5NSw3IEBACiAJdGVzdC1s
aW50LWZpbGVuYW1lcwogCiB0ZXN0LWxpbnQtZHVwbGljYXRlczoKLQlAZHVwcz1gZWNobyAkKFQp
IHwgdHIgJyAnICdcbicgfCBzZWQgJ3MvLS4qLy8nIHwgc29ydCB8IHVuaXEgLWRgICYmIFwKKwlA
ZHVwcz1gZWNobyAkKFQpIHwgdHIgJyAnICdcbicgfCAkKFNFRCkgJ3MvLS4qLy8nIHwgc29ydCB8
IHVuaXEgLWRgICYmIFwKIAkJdGVzdCAteiAiJCRkdXBzIiB8fCB7IFwKIAkJZWNobyA+JjIgImR1
cGxpY2F0ZSB0ZXN0IG51bWJlcnM6IiAkJGR1cHM7IGV4aXQgMTsgfQogCkBAIC05Nyw3ICsxMTEs
NyBAQAogCUAjIFdlIGRvICpub3QqIHBhc3MgYSBnbG9iIHRvIGxzLWZpbGVzIGJ1dCB1c2UgZ3Jl
cCBpbnN0ZWFkLCB0byBjYXRjaAogCUAjIG5vbi1BU0NJSSBjaGFyYWN0ZXJzICh3aGljaCBhcmUg
cXVvdGVkIHdpdGhpbiBkb3VibGUtcXVvdGVzKQogCUBiYWQ9IiQkKGdpdCAtYyBjb3JlLnF1b3Rl
cGF0aD10cnVlIGxzLWZpbGVzIDI+L2Rldi9udWxsIHwgXAotCQkJZ3JlcCAnWyIqOjw+P1xcfF0n
KSI7IFwKKwkJCSQoR1JFUCkgJ1siKjo8Pj9cXHxdJykiOyBcCiAJCXRlc3QgLXogIiQkYmFkIiB8
fCB7IFwKIAkJZWNobyA+JjIgIm5vbi1wb3J0YWJsZSBmaWxlIG5hbWUocyk6ICQkYmFkIjsgZXhp
dCAxOyB9CiAK
--0000000000005d143f0583dbfd42--
