From: Richard Hartmann <richih.mailinglist@gmail.com>
Subject: Re: Cloning into an existing, non-empty directory?
Date: Mon, 25 Apr 2011 16:08:06 +0200
Message-ID: <BANLkTimi8Q+2bK3QdWdJdX1V-WbrU+AbdA@mail.gmail.com>
References: <BANLkTi=VwiqN99AMEJb6jb1uFya2Hipibw@mail.gmail.com>
 <20110421220327.GA3396@elie> <BANLkTikY7c7rP+yv5vt2vxw5nu84k_H=Xw@mail.gmail.com>
 <20110423101500.GB1500@elie> <BANLkTinV4cFC5vzr25V-D3PMwWx284zgoQ@mail.gmail.com>
 <20110425075750.GA28172@elie>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=20cf303bfdfcbf8b7104a1bebd31
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 16:08:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEMSm-0001Xm-EU
	for gcvg-git-2@lo.gmane.org; Mon, 25 Apr 2011 16:08:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758137Ab1DYOI1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2011 10:08:27 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:56109 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756608Ab1DYOI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2011 10:08:26 -0400
Received: by ywj3 with SMTP id 3so620208ywj.19
        for <git@vger.kernel.org>; Mon, 25 Apr 2011 07:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=OMtlptpSRLkjmU9/hLhNEW2R5qlM/6S4mYLq547U5Rs=;
        b=kKAMbW8M9gYM2pBb0XRd1FtYQ3zP38U54AKx7mwTGTzlUDHpSmpD6J+NdKyS3izsUe
         9/mzt1uvMVqgK9sxF6l42kpZ4BJUHFv1G3+aZLqYccQSJ/bP5/OlfEyUrjOvnFlbChNp
         gXfbtCCLxY0z0aAV+06SEMpKEUKsA3VW/R6cI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=CiFICqgiuRgi609JNt6x7Wgp7QfIAxUx3TlLC1y5XTA7tsNxnEoRvA7kiP+BZqQF+y
         B+Ze0T4sMkB3iGzoKb2Idj6D8NwsJt8D/HbxNT2E4f+nzMzL7ipSp9tR1b6lHhgGQT40
         JxfmtpSLqu5Y3+GxPbMJneaoqGfbneDEd3IxU=
Received: by 10.236.139.230 with SMTP id c66mr3480583yhj.526.1303740506147;
 Mon, 25 Apr 2011 07:08:26 -0700 (PDT)
Received: by 10.236.110.9 with HTTP; Mon, 25 Apr 2011 07:08:06 -0700 (PDT)
In-Reply-To: <20110425075750.GA28172@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172028>

--20cf303bfdfcbf8b7104a1bebd31
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

2011/4/25 Jonathan Nieder <jrnieder@gmail.com>:

> Is this what you mean? =C2=A0"git merge" is not advertised as taking the
> name of a remote repository as a parameter. =C2=A0The usual usage is
> instead to pass a commit, as in "git merge origin/master".

Ugh. I must have copied the wrong command into my script and then ran
with it, trying to fix the error I was getting in the wrong place.
Sorry for that.
I am running with environment variables and without any explicit
--work-tree --git-dir as well and everything works just fine.

In case anyone is interested, I attached the working version.


Thanks a lot for your help, I really appreciate it!
Richard

--20cf303bfdfcbf8b7104a1bebd31
Content-Type: application/x-sh; name="init_vcsh.sh"
Content-Disposition: attachment; filename="init_vcsh.sh"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gmxbe7cb0

IyEvYmluL3pzaAoKW1sgJCMgLWx0IDIgXV0gJiYgZWNobyAibm90IGVub3VnaCBhcmd1bWVudHMi
ICYmIGV4aXQgMQpbWyAkIyAtZXEgMiBdXSAmJiBHSVRfV09SS19UUkVFPSIkSE9NRSIKW1sgJCMg
LWVxIDMgXV0gJiYgR0lUX1dPUktfVFJFRT0iJDMiCltbICQjIC1ndCAzIF1dICYmIGVjaG8gInRv
byBtYW55IGFyZ3VtZW50cyIgJiYgZXhpdCAyCgpHSVRfUkVNT1RFPSIkMSIKR0lUX0RJUj0iJDIi
CmV4cG9ydCBHSVRfUkVNT1RFIEdJVF9ESVIgR0lUX1dPUktfVFJFRQpta2RpciAtcCAkR0lUX1dP
UktfVFJFRQpjZCAkR0lUX1dPUktfVFJFRSB8fCAKICAoZWNobyAiJChiYXNlbmFtZSAkMCk6IGZh
dGFsOiBjb3VsZCBub3QgZW50ZXIgJEdJVF9XT1JLX1RSRUUiICYmCiAgIGV4aXQgMjApIHx8IGV4
aXQgMjAKZ2l0IGluaXQKZ2l0IHJlbW90ZSBhZGQgb3JpZ2luICRHSVRfUkVNT1RFCmdpdCBjb25m
aWcgYnJhbmNoLm1hc3Rlci5yZW1vdGUgb3JpZ2luCmdpdCBjb25maWcgYnJhbmNoLm1hc3Rlci5t
ZXJnZSAgcmVmcy9oZWFkcy9tYXN0ZXIKZ2l0IGZldGNoCmZvciBpIGluICQoZ2l0IGxzLXRyZWUg
LXIgb3JpZ2luL21hc3RlciB8IGF3ayAne3ByaW50ICQ0fScpOyBkbwoJW1sgLWUgJGkgXV0gJiYK
CSAgZWNobyAiJChiYXNlbmFtZSAkMCk6IGVycm9yOiAkaSBleGlzdHMuIiAmJgoJICBDT05GTElD
VD0xOwpkb25lCgpbWyAtbiAkQ09ORkxJQ1QgXV0gJiYKICBlY2hvICIkKGJhc2VuYW1lICQwKTog
V2lsbCBzdG9wIGFmdGVyIGZldGNoaW5nIGFuZCBub3QgdHJ5IHRvIG1lcmdlIVxuIiAmJgogIGV4
aXQgMwoKZ2l0IG1lcmdlIG9yaWdpbi9tYXN0ZXIK
--20cf303bfdfcbf8b7104a1bebd31--
