From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [ANNOUNCE] tig-0.14
Date: Tue, 10 Feb 2009 21:41:21 +0100
Message-ID: <2c6b72b30902101241p67a0e1e9u60c8033c4a03260c@mail.gmail.com>
References: <20090205204436.GA6072@diku.dk> <4991814A.6050803@tedpavlic.com>
	 <2c6b72b30902101029s72628a88n16473ee30f853198@mail.gmail.com>
	 <6BA2725C-2127-48BE-871E-7449A507CCD8@silverinsanity.com>
	 <d4bc1a2a0902101129y22224c89y144b223e7d7dd463@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001636c5b7e491734004629682a1
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	Ted Pavlic <ted@tedpavlic.com>, git <git@vger.kernel.org>
To: Stefan Karpinski <stefan.karpinski@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 21:43:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWzRX-0002ez-5F
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 21:42:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755767AbZBJUl2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 15:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755634AbZBJUl1
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 15:41:27 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:38966 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755509AbZBJUl0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 15:41:26 -0500
Received: by fxm13 with SMTP id 13so106682fxm.13
        for <git@vger.kernel.org>; Tue, 10 Feb 2009 12:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type;
        bh=1ZpJoUhaQy7jY3j8nmDxK0iS6TuClVmjExJNADjcVK0=;
        b=RJIpEQhJdq45p6UjQhIIYhV++3bMqGoy7rtM27C9t7BAxQuSg5qYr+eyfFQ96kMk7m
         UEVP9akrHrCi/scSfHZny0YWSjVOxsdeEPm4Y+yIH0JICPyMZnhZqetSCwr7sRNa4jDN
         P6KthgYs8SNE4Z5KwE3Z9W2VigCoIuiXs3kZQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=DVK0Q5RbI2bpHfKB7np0IRF21ndMK3JBPCcKV1QVcLHJNRFRiWxweMoSect/1AlPMo
         GDvuNYhPv1EJitC6h7OhPHLmEIN4D6bUn3gWvAB8foXbhbrzI2kkge0m21kt3U3ct684
         bSX/Wd+7BXwJSUSlqHtK5631fsFoeUuojENzI=
Received: by 10.180.252.8 with SMTP id z8mr1767948bkh.158.1234298482029; Tue, 
	10 Feb 2009 12:41:22 -0800 (PST)
In-Reply-To: <d4bc1a2a0902101129y22224c89y144b223e7d7dd463@mail.gmail.com>
X-Google-Sender-Auth: 485c8b0222c626d0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109305>

--001636c5b7e491734004629682a1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On Tue, Feb 10, 2009 at 20:29, Stefan Karpinski
<stefan.karpinski@gmail.com> wrote:
> On Tue, Feb 10, 2009 at 11:07 AM, Brian Gernhardt
> <benji@silverinsanity.com> wrote:
>>
>> OS 10.5.6's Terminal.app, with TERM=xterm-color
>> I have no .tigrc
>
> Ditto. Same bug. Completely vanilla tig setup. OS X Leopard,
> tig-0.14-9-gd06137e, TERM=xterm-color.

Looks like there might be a pattern and I might have an excuse to go
knock on the door of one of my "Mac" friends. ;) However, first I
would kindly ask if one of you have time to test the attached patch.

Thanks both of you and sorry for the inconvenience.

-- 
Jonas Fonseca

--001636c5b7e491734004629682a1
Content-Type: text/x-diff; charset=US-ASCII; 
	name="0001-Fix-regression-where-a-line-was-not-cleared-when-not.patch"
Content-Disposition: attachment; 
	filename="0001-Fix-regression-where-a-line-was-not-cleared-when-not.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fr11e2br0

RnJvbSAzNjcwYjlmMjBjNDljNDZjNjQxOGQ3ZGJjY2U4MjY1YjJmZThhODUzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb25hcyBGb25zZWNhIDxmb25zZWNhQGRpa3UuZGs+CkRhdGU6
IFR1ZSwgMTAgRmViIDIwMDkgMjE6MzM6MTggKzAxMDAKU3ViamVjdDogW1BBVENIXSBGaXggcmVn
cmVzc2lvbiB3aGVyZSBhIGxpbmUgd2FzIG5vdCBjbGVhcmVkIHdoZW4gbm90IHNlbGVjdGVkIGFu
eW1vcmUKCkludHJvZHVjZWQgaW4gMjczYzI4ZGYyYWE1Y2MwZDEyMmIxYTBmM2MwMDE0YTU2YWI4
YzM5MiAoVHJlZSB2aWV3OiBtYWtlCmRyYXdpbmcgbW9yZSBzbW9vdGggYnkgdXNpbmcgdGhlIGRp
cnR5IGZsYWcpLgotLS0KIHRpZy5jIHwgICAgMiArLQogMSBmaWxlcyBjaGFuZ2VkLCAxIGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGlnLmMgYi90aWcuYwppbmRl
eCA3MDcyMDk0Li4wMmY0YmQ4IDEwMDY0NAotLS0gYS90aWcuYworKysgYi90aWcuYwpAQCAtMjA1
NSw3ICsyMDU1LDcgQEAgZHJhd192aWV3X2xpbmUoc3RydWN0IHZpZXcgKnZpZXcsIHVuc2lnbmVk
IGludCBsaW5lbm8pCiAJbGluZSA9ICZ2aWV3LT5saW5lW3ZpZXctPm9mZnNldCArIGxpbmVub107
CiAKIAl3bW92ZSh2aWV3LT53aW4sIGxpbmVubywgMCk7Ci0JaWYgKGxpbmUtPmNsZWFyZW9sKQor
CWlmIChsaW5lLT5jbGVhcmVvbCB8fCAobGluZS0+c2VsZWN0ZWQgJiYgIXNlbGVjdGVkKSkKIAkJ
d2NscnRvZW9sKHZpZXctPndpbik7CiAJdmlldy0+Y29sID0gMDsKIAl2aWV3LT5jdXJsaW5lID0g
bGluZTsKLS0gCjEuNi4xLjEuMzQ3LmczZjgxZAoK
--001636c5b7e491734004629682a1--
