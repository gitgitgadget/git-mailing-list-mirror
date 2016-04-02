From: Todd Zullinger <tmz@pobox.com>
Subject: [PATCH] spec: Adjust README name
Date: Sat, 2 Apr 2016 12:14:28 -0400
Message-ID: <20160402161428.GC13271@zaya.teonanacatl.net>
References: <CAHHSH-JrPiXnkdpU0cP6KE46hUr3-ZiSjW5FDMpV2HGmSou8kA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?44Oe44OD44OB44On44Kz5aSq6YOO?= <mebius1080p@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 02 18:14:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amOC6-0005UD-K3
	for gcvg-git-2@plane.gmane.org; Sat, 02 Apr 2016 18:14:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751913AbcDBQOe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 Apr 2016 12:14:34 -0400
Received: from mail-qg0-f44.google.com ([209.85.192.44]:32935 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299AbcDBQOd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Apr 2016 12:14:33 -0400
Received: by mail-qg0-f44.google.com with SMTP id j35so119280914qge.0
        for <git@vger.kernel.org>; Sat, 02 Apr 2016 09:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=bzpq/BoBBT4AYTKxja/ZSa2gXndtB/Pbi1yqnnl9FMc=;
        b=C/KBekp8lX5HQbG8sOTdlnl9jJ2IdJkLj84A0ocg/4g/UOc5wnINwr4G8ervK8a32z
         V09pE1Me2xU7MufddlB4ZTZKmGgGSHyfntWciPiazN/KgS8wxPRsYT/XYWixqgV+S+4X
         eC9qwF57yfnpNZRptmv9tP42t+zOZ8Nn2mbtKwWGQMFc5rKOrV8shQXCVrV6mldmC1F2
         mshngVCwQPxnRzuJWSSfE/j/AGY1tJ8AEk1lCtYmP2Y8ukNXme9v6mNi+1Osn53fzZgY
         Mne4/bowMmc7u2m/31l3RQQZCJHyVbBkfos1LQWyunBLs1Jljpk31pgDTVTXhviFYkhB
         W2mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=bzpq/BoBBT4AYTKxja/ZSa2gXndtB/Pbi1yqnnl9FMc=;
        b=fuNegDMQGWWoK5AJJQmNBCLQ5CdE1KyiXAnTmC1p3dEFdZgG3UtF6tLI00ka+9IYMZ
         dZfCBq+6by9C8hLbMaqq/ZjegQ5S1l1l84SGxQ2LA/Df2ETJ4QxXhPNuXU39e9A/3R6e
         U+mqHCidC/CD99hu6AAowjO9dAzSaDJS3Zp6em/JMKob/VFHN7wH9IT8mHVTYSK8ZGv2
         NHOW7T26f4tIzwkTzv7FLUNlakZvyVrSoS6mBhfNdEdUq4x9zz6AfeVekNpvjNg+aVXf
         IFlR91jS/Cg0UtRBtX94tipswKxJ6dPQGKQetyjnAT5rp963w134uANWHHDe6kCUhKrF
         uciQ==
X-Gm-Message-State: AD7BkJLQa8Mtzl/23PnuG19hS2UmMUA1xrguRcAX6eRSR4oLbOBC/HUKvxVgPiDOXcxhmQ==
X-Received: by 10.141.4.69 with SMTP id g66mr9452661qhd.31.1459613672374;
        Sat, 02 Apr 2016 09:14:32 -0700 (PDT)
Received: from zaya.teonanacatl.net (zaya.teonanacatl.net. [2001:470:5:873:862b:2bff:fe5e:698b])
        by smtp.gmail.com with ESMTPSA id y206sm8512116qhc.0.2016.04.02.09.14.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 02 Apr 2016 09:14:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAHHSH-JrPiXnkdpU0cP6KE46hUr3-ZiSjW5FDMpV2HGmSou8kA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290593>

The README file moved to README.md in ad21f5 (README: use markdown
syntax, 2016-02-25).

Reported-by: =E3=83=9E=E3=83=83=E3=83=81=E3=83=A7=E3=82=B3=E5=A4=AA=E9=83=
=8E <mebius1080p@gmail.com>
Signed-off-by: Todd Zullinger <tmz@pobox.com>

---

Hi,

=E3=83=9E=E3=83=83=E3=83=81=E3=83=A7=E3=82=B3=E5=A4=AA=E9=83=8E wrote:
> hi=20
> I downloaded tarball (tar.gz) from git web site and tried to make rpm=
 file.=20
> But, when I run command "$rpmbuild -tb --clean git-2.8.0.tar.gz",=20
> error message is displayed and rpm file creation stopped.=20
> The error message is looks like this:
> cp -pr README ~/rpmbuild/BUILDROOT/git-2.8.0-1.el7.centos.x86_64/usr/=
share/doc/git-2.8.0=20
> cp: cannot stat 'README': No such file or directory
>
> It looks like README file does not exist on expected directory.
>
> Im using Centos 7.2.=20
> I hope this bug will fix soon.=20
> thank you

I haven't tested this, but I think it should resolve the README issue=20
in the spec file.  Confirmation from folks who regularly build from=20
this git spec file would be most welcome.

You could also rebuild the Fedora git packages for CentOS=C2=B9.  We tr=
y to=20
maintain compatibility as long as possible.  The Fedora git package=20
currently builds as far back as CentOS 5.  I am pretty sure that it=20
requires the EPEL repo to be enabled, but that might also be true of=20
the git.spec included in here.

=C2=B9 https://dl.fedoraproject.org/pub/fedora/linux/development/rawhid=
e/Everything/source/tree/Packages/g/git-2.8.0-1.fc25.src.rpm

 git.spec.in | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/git.spec.in b/git.spec.in
index d61d537..260022e 100644
--- a/git.spec.in
+++ b/git.spec.in
@@ -146,7 +146,7 @@ rm -rf $RPM_BUILD_ROOT
 %files -f bin-man-doc-files
 %defattr(-,root,root)
 %{_datadir}/git-core/
-%doc README COPYING Documentation/*.txt
+%doc README.md COPYING Documentation/*.txt
 %{!?_without_docs: %doc Documentation/*.html Documentation/howto}
 %{!?_without_docs: %doc Documentation/technical}
 %{_sysconfdir}/bash_completion.d
@@ -214,6 +214,9 @@ rm -rf $RPM_BUILD_ROOT
 # No files for you!
=20
 %changelog
+* Sat Apr 02 2016 Todd Zullinger <tmz@pobox.com>
+- Adjust README name
+
 * Sun Sep 18 2011 Jakub Narebski <jnareb@gmail.com>
 - Add gitweb manpages to 'gitweb' subpackage
=20
--=20
2.4.11

--=20
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Ambition is a poor excuse for not having enough sense to be lazy.
