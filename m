From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: Git on MSys (or how to make it easy for Windows users to compile git)
Date: Fri, 3 Aug 2007 08:14:01 -0400
Message-ID: <fcaeb9bf0708030514n7f1c4fecqf7c850d216d0583@mail.gmail.com>
References: <Pine.LNX.4.64.0708022206130.14781@racer.site>
	 <46B2D547.6050406@trolltech.com>
	 <fcaeb9bf0708030417y39f84db2lb0b202af57d8fccb@mail.gmail.com>
	 <46B31181.5020007@trolltech.com>
	 <fcaeb9bf0708030436q50322fbbne3a793d693e9f0e3@mail.gmail.com>
	 <46B314E6.8030806@trolltech.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_68038_25031250.1186143241731"
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Marius Storm-Olsen" <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 14:14:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGw2v-0000W1-7X
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 14:14:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755068AbXHCMOF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 08:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753026AbXHCMOE
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 08:14:04 -0400
Received: from an-out-0708.google.com ([209.85.132.240]:47888 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755007AbXHCMOD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 08:14:03 -0400
Received: by an-out-0708.google.com with SMTP id d31so155352and
        for <git@vger.kernel.org>; Fri, 03 Aug 2007 05:14:01 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=VOSrWtvZC3QjE78LeSyuFnPrWHQQr4o88D9FN/WQ9kd1XYauu0JzyQE8Aa7bUvT4jD6prXCrLqsKpZ2bZbRLPQ/SFmd24KIOhtLDuOdF3S6xyJE09BPVUbjYzHPcqm+GPWWhijYx+fn/o0gXq8woTdgwrCmIAVsgoLd71EQWUu4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=c4qQVVunu1E9xJ8fLe7CrBhRki7anRrt2lqVjl2BD/dDRkkNehq0aZq/4/h8uFMlvLYpCtIpHutMb9xMHsZeMHsSu7n/c2nsPc3q5/YF4doQoGnPoWVej0J2jOSPTjVkE9jBR4VrAqwzcqwDOfqmarLLMYzB1J50Tc3DOm0rqDs=
Received: by 10.100.44.13 with SMTP id r13mr1678611anr.1186143241791;
        Fri, 03 Aug 2007 05:14:01 -0700 (PDT)
Received: by 10.100.198.17 with HTTP; Fri, 3 Aug 2007 05:14:01 -0700 (PDT)
In-Reply-To: <46B314E6.8030806@trolltech.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54712>

------=_Part_68038_25031250.1186143241731
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

[CC'd to git ML so that if anyone needs it again, google might help]

On 8/3/07, Marius Storm-Olsen <marius@trolltech.com> wrote:
> >>> Even if it installs ok under Wine, git may not work properly
> >>> because a bug in dup2() not duplicating to 0-2 and some others
> >>> that I think only affect tests. So get XP if you can or prepare
> >>> to fix Wine along the way.
> >> Yeah, I wasn't going to use it under Wine actually. Just wanted
> >> to see if I could get it building there, to ease automated
> >> packaging later. However, I've given up on it, due to a perl
> >> issue, which might be caused by the issue you describe.
> >
> > You could cross-compile it. You'll need a cross toolchain, zlib
> > stuff and a good config.mak (I can send you one if you have trouble
> > with it).
>
> I would definitely be interested in your config.mak file!

Rename the attached file config.mak and you can "make" right away
without running configure. You still need to set CFLAGS and LDFLAGS to
specify location of zlib.h and libz.a though.

> Thanks!
>
> --
> .marius
>
>
>


-- 
Duy

------=_Part_68038_25031250.1186143241731
Content-Type: application/octet-stream; name=config.mak
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f4wn0rcg
Content-Disposition: attachment; filename="config.mak"

IyBnaXQgTWFrZWZpbGUgY29uZmlndXJhdGlvbiwgaW5jbHVkZWQgaW4gbWFpbiBNYWtlZmlsZQoj
IGNvbmZpZy5tYWsuYXV0b2dlbi4gIEdlbmVyYXRlZCBmcm9tIGNvbmZpZy5tYWsuaW4gY29uZmln
Lm1hay5hcHBlbmQgYnkgY29uZmlndXJlLgoKQ0MgPSBtaW5ndzMyLWdjYwpDRkxBR1MgPSAtZyAt
TzIKQVIgPSBtaW5ndzMyLWFyClRBUiA9IHRhcgojSU5TVEFMTCA9IEBJTlNUQUxMQAkJIyBuZWVk
cyBpbnN0YWxsLXNoIG9yIGluc3RhbGwuc2ggaW4gc291cmNlcwpUQ0xUS19QQVRIID0gd2lzaAoK
cHJlZml4ID0gL3Vzci9sb2NhbApleGVjX3ByZWZpeCA9ICR7cHJlZml4fQpiaW5kaXIgPSAke2V4
ZWNfcHJlZml4fS9iaW4KI2dpdGV4ZWNkaXIgPSAke2V4ZWNfcHJlZml4fS9saWJleGVjL2dpdC1j
b3JlLwpkYXRhcm9vdGRpciA9ICR7cHJlZml4fS9zaGFyZQp0ZW1wbGF0ZV9kaXIgPSAke2RhdGFy
b290ZGlyfS9naXQtY29yZS90ZW1wbGF0ZXMvCgptYW5kaXI9JHtkYXRhcm9vdGRpcn0vbWFuCgpz
cmNkaXIgPSAuCgoKZXhwb3J0IGV4ZWNfcHJlZml4IG1hbmRpcgpleHBvcnQgc3JjZGlyIFZQQVRI
CgpOT19NTUFQPVllc1BsZWFzZQpOT19QUkVBRD1ZZXNQbGVhc2UKTk9fT1BFTlNTTD1ZZXNQbGVh
c2UKTk9fQ1VSTD1ZZXNQbGVhc2UKTk9fU1lNTElOS19IRUFEPVllc1BsZWFzZQpOT19JUFY2PVll
c1BsZWFzZQpOT19FVENfUEFTU1dEPVllc1BsZWFzZQpOT19TRVRFTlY9WWVzUGxlYXNlCk5PX1VO
U0VURU5WPVllc1BsZWFzZQpOT19TVFJDQVNFU1RSPVllc1BsZWFzZQpOT19TVFJMQ1BZPVllc1Bs
ZWFzZQpOT19JQ09OVj1ZZXNQbGVhc2UKTk9fQzk5X0ZPUk1BVCA9IFllc1BsZWFzZQpOT19TVFJU
T1VNQVggPSBZZXNQbGVhc2UKTk9fU1lNTElOS1M9WWVzUGxlYXNlCk5PX1NWTl9URVNUUz1ZZXNQ
bGVhc2UKCkNPTVBBVF9DRkxBR1MgKz0gLUROT19FVENfUEFTU1dEIC1ETk9fU1RfQkxPQ0tTIC1E
U1RSSVBfRVhURU5TSU9OPVwiLmV4ZVwiIC1JIGNvbXBhdApDT01QQVRfT0JKUyArPSBjb21wYXQv
bWluZ3cubyBjb21wYXQvZm5tYXRjaC5vIGNvbXBhdC9yZWdleC5vCkVYVExJQlMgKz0gLWx3czJf
MzIKWCA9IC5leGUKTk9FWEVDVEVNUEwgPSAubm9leGVjCnRlbXBsYXRlX2RpciA9IC4uL3NoYXJl
L2dpdC1jb3JlL3RlbXBsYXRlcy8KRVRDX0dJVENPTkZJRyA9IC4uL2V0Yy9naXRjb25maWcKU0NS
SVBUX1NIICs9IGNwaW8uc2gKTkVFRFNfU1NMX1dJVEhfQ1JZUFRPPQpOT19PUEVOU1NMPVllc1Bs
ZWFzZQpOT19DVVJMPVllc1BsZWFzZQpOT19FWFBBVD1ZZXNQbGVhc2UKTkVFRFNfTElCSUNPTlY9
Ck5FRURTX1NPQ0tFVD0KU0hFTExfUEFUSD0vYmluL3NoCk5PX1BFUkxfTUFLRU1BS0VSPQpOT19E
X0lOT19JTl9ESVJFTlQ9Ck5PX0RfVFlQRV9JTl9ESVJFTlQ9WWVzUGxlYXNlCk5PX1NPQ0tBRERS
X1NUT1JBR0U9Ck5PX0lQVjY9WWVzUGxlYXNlCk5PX0M5OV9GT1JNQVQ9WWVzUGxlYXNlCk5PX1NU
UkNBU0VTVFI9WWVzUGxlYXNlCk5PX1NUUkxDUFk9WWVzUGxlYXNlCk5PX1NFVEVOVj1ZZXNQbGVh
c2UKTk9fSUNPTlY9WWVzUGxlYXNlCgojIGNvbmZpZy5tYWsuYXBwZW5kLiAgR2VuZXJhdGVkIGJ5
IGNvbmZpZ3VyZS4K
------=_Part_68038_25031250.1186143241731--
