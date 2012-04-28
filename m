From: Eli Barzilay <eli-oSK4jVRJLyZg9hUCZPvPmw@public.gmane.org>
Subject: Re: Bug in git-stash(.sh) ?
Date: Sat, 28 Apr 2012 19:59:37 -0400
Message-ID: <20380.33897.666338.766096@winooski.ccs.neu.edu>
References: <20379.9312.943088.350379@winooski.ccs.neu.edu>
	<87wr4za9mr.fsf@gmail.com>
	<m2pqasb8mr.fsf@linux-m68k.org>
	<xmqqvckk93ta.fsf@junio.mtv.corp.google.com>
	<CALO-gut4csy5wef4iGPGD5jVPc1f0iFBfS3MUWrOwc2yczdviw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	 boundary="kZDbrusHsK"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>,
        Eli Barzilay <public-eli-oSK4jVRJLyZg9hUCZPvPmw-wOFGN7rlS/M9smdsby/KFg@public.gmane.org>,
        git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Eli Barzilay <public-eli-oSK4jVRJLyZg9hUCZPvPmw-wOFGN7rlS/M9smdsby/KFg@public.gmane.org>,
        magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
To: Yann Hodique <yann.hodique-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Andreas Schwab <schwab-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
X-From: magit+bncCOHCzKWgHRDtiPL8BBoEoIXelg-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Sun Apr 29 01:59:43 2012
Return-path: <magit+bncCOHCzKWgHRDtiPL8BBoEoIXelg-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvgm-magit-3@m.gmane.org
Received: from mail-vb0-f58.google.com ([209.85.212.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <magit+bncCOHCzKWgHRDtiPL8BBoEoIXelg-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>)
	id 1SOHYE-0002Mc-Ea
	for gcvgm-magit-3@m.gmane.org; Sun, 29 Apr 2012 01:59:42 +0200
Received: by vbal1 with SMTP id l1sf2040612vba.3
        for <gcvgm-magit-3@m.gmane.org>; Sat, 28 Apr 2012 16:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:from:mime-version:message-id:date:to:cc
         :subject:in-reply-to:references:x-mailer:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=N5lunijiIdPb4/z+CBP+G0zYAcuT5G52I+w0AN4OzIU=;
        b=b/DYzSIUtZA8BXM2frTvUZGl8jI/utOapqXJJANnY7efxlklS7U6C9MWrE5drzgOen
         CJWC4VRdgkCpAbljf51aW7q9ihq6kmmJCCUr765FefBBna0q4Rty0XP9c1+dOA9G9K2a
         fZskv35hCvwSifkcGNeedsjr45hzGnYYSsE/Q=
Received: by 10.50.47.163 with SMTP id e3mr648156ign.6.1335657581275;
        Sat, 28 Apr 2012 16:59:41 -0700 (PDT)
X-BeenThere: magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.231.50.74 with SMTP id y10ls2656985ibf.4.gmail; Sat, 28 Apr
 2012 16:59:40 -0700 (PDT)
Received: by 10.42.89.20 with SMTP id e20mr13094172icm.3.1335657580812;
        Sat, 28 Apr 2012 16:59:40 -0700 (PDT)
Received: by 10.42.89.20 with SMTP id e20mr13094171icm.3.1335657580793;
        Sat, 28 Apr 2012 16:59:40 -0700 (PDT)
Received: from winooski.ccs.neu.edu (winooski.ccs.neu.edu. [129.10.115.117])
        by gmr-mx.google.com with ESMTPS id eo1si3680302igc.0.2012.04.28.16.59.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 28 Apr 2012 16:59:40 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of eli-a5nvgYPMCZcx/1z6v04GWfZ8FUJU4vz8@public.gmane.org designates 129.10.115.117 as permitted sender) client-ip=129.10.115.117;
Received: from winooski.ccs.neu.edu (localhost.localdomain [127.0.0.1])
	by winooski.ccs.neu.edu (8.14.4/8.14.4) with ESMTP id q3SNxdcq004188;
	Sat, 28 Apr 2012 19:59:39 -0400
Received: (from eli@localhost)
	by winooski.ccs.neu.edu (8.14.4/8.14.4/Submit) id q3SNxb44004184;
	Sat, 28 Apr 2012 19:59:37 -0400
In-Reply-To: <CALO-gut4csy5wef4iGPGD5jVPc1f0iFBfS3MUWrOwc2yczdviw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>,
	<m2pqasb8mr.fsf-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	<87wr4za9mr.fsf-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
X-Mailer: VM 8.2.0a under 23.2.1 (x86_64-redhat-linux-gnu)
X-Original-Sender: eli-oSK4jVRJLyZg9hUCZPvPmw@public.gmane.org
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 best guess record for domain of eli-a5nvgYPMCZcx/1z6v04GWfZ8FUJU4vz8@public.gmane.org designates
 129.10.115.117 as permitted sender) smtp.mail=eli-a5nvgYPMCZcx/1z6v04GWfZ8FUJU4vz8@public.gmane.org
Precedence: list
Mailing-list: list magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org; contact magit+owners-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-ID: <magit.googlegroups.com>
X-Google-Group-Id: 752745291123
List-Post: <http://groups.google.com/group/magit/post?hl=en_US>, <mailto:magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:magit+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/magit?hl=en_US>
Sender: magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/magit/subscribe?hl=en_US>, <mailto:magit+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/magit/subscribe?hl=en_US>, <mailto:googlegroups-manage+752745291123+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196501>

--kZDbrusHsK
Content-Type: text/plain; charset=utf-8
Content-Description: message body text
Content-Transfer-Encoding: quoted-printable

Earlier today, Andreas Schwab wrote:
>=20
> FWIW, replacing the spaces by dots will avoid the bug.

(Yeah, but I don't see a quick way to do that replacement without
resorting to bashisms.)


Yesterday, Eli Barzilay wrote:
> I didn't like that either, and I think that it's possible to avoid
> it by dropping the --symbolic for that test, and re-parse if needed
> for an error messag.  I'll try that and send a patch.

I'm attaching a patch rather than including it inline since it's
bigger than I thought, and since I'm not sure that it should be used.
It makes the script use $REV for sha1 revisions, and $SREV for the
--symbolic versions that were used previously.  With this, date refs
work for "stash apply" but they *don't* work for "stash drop" -- looks
like a number is required for that.

However, I thought that a much better solution is to not show the
dates to begin with, since that would make things work as expected...
The fact that things seem to be working fine for the whole world
except for me made me look into my config file, and ...

Three hours ago, Yann Hodique wrote:
>=20
> How exactly do you make magit generate these calls=3F  AFAICT, Magit
> should operate on whatever "git stash list" outputs, meaning
> stash@{N}. So I guess I'm missing something.

... right: the offending configuration I had was log.date =3D iso.  Thi=
s
calls for a simple chane for git-stash.sh to use `--date default':

=09git log --date default --format=3D"%gd: %gs" -g "$@" $ref=5Fstash --=


which follows.  This is independent of the other patch.  In any case,
it is also questionable -- reading the documentation for %gd:

           =C2=B7    %gD: reflog selector, e.g., refs/stash@{1}
           =C2=B7    %gd: shortened reflog selector, e.g., stash@{1}

makes it look like the problem is there -- in get=5Freflog=5Fselector()=
 --
which has explicit code for showing the dates.  (This was done in
8f8f5476.)

Another point is being able to see these dates, eg, make "stash list"
show the stash{N} and also show the dates.  It looks to me like the
date code in get=5Freflog=5Fselector() should be *removed* since it can=
 be
printed with "%cd" or "%ad" in the log line.  And it might be nicer to
add the date to the "stash list" output, something like:

=09git log --date default --format=3D"%gd: %gs (%cd)" -g "$@" $ref=5Fst=
ash --


This is the patch mentioned in the beginning:


--kZDbrusHsK
Content-Type: text/plain; charset=us-ascii
Content-Description: .signature
Content-Transfer-Encoding: 7bit


-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!

--kZDbrusHsK
Content-Type: application/octet-stream;
	 name="srev-patch"
Content-Disposition: attachment;
	 filename="srev-patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2dpdC1zdGFzaC5zaCBiL2dpdC1zdGFzaC5zaApvbGQgbW9kZSAxMDA3NTUK
bmV3IG1vZGUgMTAwNjQ0CmluZGV4IDRlMmM3ZjguLmZkNTlmYTYKLS0tIGEvZ2l0LXN0YXNoLnNo
CisrKyBiL2dpdC1zdGFzaC5zaApAQCAtMjg1LDkgKzI4NSwxMCBAQCBzaG93X3N0YXNoICgpIHsK
ICMgc3Rhc2ggcmVjb3JkcyB0aGUgd29yayB0cmVlLCBhbmQgaXMgYSBtZXJnZSBiZXR3ZWVuIHRo
ZQogIyBiYXNlIGNvbW1pdCAoZmlyc3QgcGFyZW50KSBhbmQgdGhlIGluZGV4IHRyZWUgKHNlY29u
ZCBwYXJlbnQpLgogIwotIyAgIFJFViBpcyBzZXQgdG8gdGhlIHN5bWJvbGljIHZlcnNpb24gb2Yg
dGhlIHNwZWNpZmllZCBzdGFzaC1saWtlIGNvbW1pdAotIyAgIElTX1NUQVNIX0xJS0UgaXMgbm9u
LWJsYW5rIGlmICR7UkVWfSBsb29rcyBsaWtlIGEgc3Rhc2gKLSMgICBJU19TVEFTSF9SRUYgaXMg
bm9uLWJsYW5rIGlmIHRoZSAke1JFVn0gbG9va3MgbGlrZSBhIHN0YXNoIHJlZgorIyAgIFJFViBp
cyBzZXQgdG8gdGhlIHNoYTEgb2YgdGhlIHNwZWNpZmllZCBzdGFzaC1saWtlIGNvbW1pdAorIyAg
IFNSRVYgaXMgc2V0IHRvIHRoZSBpdHMgc3ltYm9saWMgdmVyc2lvbgorIyAgIElTX1NUQVNIX0xJ
S0UgaXMgbm9uLWJsYW5rIGlmICR7U1JFVn0gbG9va3MgbGlrZSBhIHN0YXNoCisjICAgSVNfU1RB
U0hfUkVGIGlzIG5vbi1ibGFuayBpZiB0aGUgJHtTUkVWfSBsb29rcyBsaWtlIGEgc3Rhc2ggcmVm
CiAjICAgcyBpcyBzZXQgdG8gdGhlIFNIQTEgb2YgdGhlIHN0YXNoIGNvbW1pdAogIyAgIHdfY29t
bWl0IGlzIHNldCB0byB0aGUgY29tbWl0IGNvbnRhaW5pbmcgdGhlIHdvcmtpbmcgdHJlZQogIyAg
IGJfY29tbWl0IGlzIHNldCB0byB0aGUgYmFzZSBjb21taXQKQEAgLTMyNyw4ICszMjgsNiBAQCBw
YXJzZV9mbGFnc19hbmRfcmV2KCkKIAlpX3RyZWU9CiAJdV90cmVlPQogCi0JUkVWPSQoZ2l0IHJl
di1wYXJzZSAtLW5vLWZsYWdzIC0tc3ltYm9saWMgIiRAIikgfHwgZXhpdCAxCi0KIAlGTEFHUz0K
IAlmb3Igb3B0CiAJZG8KQEAgLTM0NSw2ICszNDQsOSBAQCBwYXJzZV9mbGFnc19hbmRfcmV2KCkK
IAkJZXNhYwogCWRvbmUKIAorCVJFVj0kKGdpdCByZXYtcGFyc2UgLS1uby1mbGFncyAiJEAiKSB8
fCBleGl0IDEKKwlTUkVWPSQoZ2l0IHJldi1wYXJzZSAtLW5vLWZsYWdzIC0tc3ltYm9saWMgIiRA
IikgfHwgZXhpdCAxCisKIAlzZXQgLS0gJFJFVgogCiAJY2FzZSAkIyBpbgpAQCAtMzU2LDE3ICsz
NTgsMTcgQEAgcGFyc2VfZmxhZ3NfYW5kX3JldigpCiAJCQk6CiAJCTs7CiAJCSopCi0JCQlkaWUg
IiQoZXZhbF9nZXR0ZXh0ICJUb28gbWFueSByZXZpc2lvbnMgc3BlY2lmaWVkOiBcJFJFViIpIgor
CQkJZGllICIkKGV2YWxfZ2V0dGV4dCAiVG9vIG1hbnkgcmV2aXNpb25zIHNwZWNpZmllZDogXCRT
UkVWIikiCiAJCTs7CiAJZXNhYwogCi0JUkVWPSQoZ2l0IHJldi1wYXJzZSAtLXF1aWV0IC0tc3lt
Ym9saWMgLS12ZXJpZnkgJDEgMj4vZGV2L251bGwpIHx8IHsKLQkJcmVmZXJlbmNlPSIkMSIKKwly
ZWZlcmVuY2U9JFNSRVYKKwlTUkVWPSQoZ2l0IHJldi1wYXJzZSAtLXF1aWV0IC0tc3ltYm9saWMg
LS12ZXJpZnkgIiRTUkVWIiAyPi9kZXYvbnVsbCkgfHwgewogCQlkaWUgIiQoZXZhbF9nZXR0ZXh0
ICJcJHJlZmVyZW5jZSBpcyBub3QgdmFsaWQgcmVmZXJlbmNlIikiCiAJfQogCi0JaV9jb21taXQ9
JChnaXQgcmV2LXBhcnNlIC0tcXVpZXQgLS12ZXJpZnkgJFJFVl4yIDI+L2Rldi9udWxsKSAmJgot
CXNldCAtLSAkKGdpdCByZXYtcGFyc2UgJFJFViAkUkVWXjEgJFJFVjogJFJFVl4xOiAkUkVWXjI6
IDI+L2Rldi9udWxsKSAmJgorCWlfY29tbWl0PSQoZ2l0IHJldi1wYXJzZSAtLXF1aWV0IC0tdmVy
aWZ5ICIkUkVWXjIiIDI+L2Rldi9udWxsKSAmJgorCXNldCAtLSAkKGdpdCByZXYtcGFyc2UgIiRS
RVYiICIkUkVWXjEiICIkUkVWOiIgIiRSRVZeMToiICIkUkVWXjI6IiAyPi9kZXYvbnVsbCkgJiYK
IAlzPSQxICYmCiAJd19jb21taXQ9JDEgJiYKIAliX2NvbW1pdD0kMiAmJgpAQCAtMzc0LDExICsz
NzYsMTEgQEAgcGFyc2VfZmxhZ3NfYW5kX3JldigpCiAJYl90cmVlPSQ0ICYmCiAJaV90cmVlPSQ1
ICYmCiAJSVNfU1RBU0hfTElLRT10ICYmCi0JdGVzdCAiJHJlZl9zdGFzaCIgPSAiJChnaXQgcmV2
LXBhcnNlIC0tc3ltYm9saWMtZnVsbC1uYW1lICIke1JFViVAKn0iKSIgJiYKKwl0ZXN0ICIkcmVm
X3N0YXNoIiA9ICIkKGdpdCByZXYtcGFyc2UgLS1zeW1ib2xpYy1mdWxsLW5hbWUgIiR7U1JFViVA
Kn0iKSIgJiYKIAlJU19TVEFTSF9SRUY9dAogCi0JdV9jb21taXQ9JChnaXQgcmV2LXBhcnNlIC0t
cXVpZXQgLS12ZXJpZnkgJFJFVl4zIDI+L2Rldi9udWxsKSAmJgotCXVfdHJlZT0kKGdpdCByZXYt
cGFyc2UgJFJFVl4zOiAyPi9kZXYvbnVsbCkKKwl1X2NvbW1pdD0kKGdpdCByZXYtcGFyc2UgLS1x
dWlldCAtLXZlcmlmeSAiJFJFVl4zIiAyPi9kZXYvbnVsbCkgJiYKKwl1X3RyZWU9JChnaXQgcmV2
LXBhcnNlICIkUkVWXjM6IiAyPi9kZXYvbnVsbCkKIH0KIAogaXNfc3Rhc2hfbGlrZSgpCkBAIC00
ODcsOSArNDg5LDkgQEAgcG9wX3N0YXNoKCkgewogZHJvcF9zdGFzaCAoKSB7CiAJYXNzZXJ0X3N0
YXNoX3JlZiAiJEAiCiAKLQlnaXQgcmVmbG9nIGRlbGV0ZSAtLXVwZGF0ZXJlZiAtLXJld3JpdGUg
IiR7UkVWfSIgJiYKLQkJc2F5ICIkKGV2YWxfZ2V0dGV4dCAiRHJvcHBlZCBcJHtSRVZ9IChcJHMp
IikiIHx8Ci0JCWRpZSAiJChldmFsX2dldHRleHQgIlwke1JFVn06IENvdWxkIG5vdCBkcm9wIHN0
YXNoIGVudHJ5IikiCisJZ2l0IHJlZmxvZyBkZWxldGUgLS11cGRhdGVyZWYgLS1yZXdyaXRlICIk
e1NSRVZ9IiAmJgorCQlzYXkgIiQoZXZhbF9nZXR0ZXh0ICJEcm9wcGVkIFwke1NSRVZ9IChcJHMp
IikiIHx8CisJCWRpZSAiJChldmFsX2dldHRleHQgIlwke1NSRVZ9OiBDb3VsZCBub3QgZHJvcCBz
dGFzaCBlbnRyeSIpIgogCiAJIyBjbGVhcl9zdGFzaCBpZiB3ZSBqdXN0IGRyb3BwZWQgdGhlIGxh
c3Qgc3Rhc2ggZW50cnkKIAlnaXQgcmV2LXBhcnNlIC0tdmVyaWZ5ICIkcmVmX3N0YXNoQHswfSIg
Pi9kZXYvbnVsbCAyPiYxIHx8IGNsZWFyX3N0YXNoCkBAIC01MDMsNyArNTA1LDcgQEAgYXBwbHlf
dG9fYnJhbmNoICgpIHsKIAlzZXQgLS0gLS1pbmRleCAiJEAiCiAJYXNzZXJ0X3N0YXNoX2xpa2Ug
IiRAIgogCi0JZ2l0IGNoZWNrb3V0IC1iICRicmFuY2ggJFJFVl4gJiYKKwlnaXQgY2hlY2tvdXQg
LWIgIiRicmFuY2giICIkUkVWXiIgJiYKIAlhcHBseV9zdGFzaCAiJEAiICYmIHsKIAkJdGVzdCAt
eiAiJElTX1NUQVNIX1JFRiIgfHwgZHJvcF9zdGFzaCAiJEAiCiAJfQo=
--kZDbrusHsK--
