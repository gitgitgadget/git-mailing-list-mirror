From: Alexander Litvinov <litvinov2004@gmail.com>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Tue, 13 Feb 2007 09:32:51 +0600
Message-ID: <200702130932.51601.litvinov2004@gmail.com>
References: <45CFA30C.6030202@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Mark Levedahl <mlevedahl@verizon.net>
X-From: git-owner@vger.kernel.org Tue Feb 13 04:33:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGoPp-0001xJ-AB
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 04:33:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030640AbXBMDdB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 12 Feb 2007 22:33:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030641AbXBMDdB
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 22:33:01 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:41157 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030640AbXBMDdA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Feb 2007 22:33:00 -0500
Received: by ug-out-1314.google.com with SMTP id 44so76701uga
        for <git@vger.kernel.org>; Mon, 12 Feb 2007 19:32:58 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Whnh5TOSe+8s1tigqXHrUWR+YunqgPZ0hrZg9SJTMYGt+QM8sGYL4CXqEtdKsXUZPb3gPwkRRXq0krqJSN+PQWrpZ7TlyGiNsZWezHQedUsPahc7bmd7qAUWXvk8jToQnaekK1NoBbOBdiaXoiKAcojZGgbtEEfenp22RKQGss4=
Received: by 10.66.232.11 with SMTP id e11mr15927858ugh.1171337578508;
        Mon, 12 Feb 2007 19:32:58 -0800 (PST)
Received: from lan.ac-sw.lcl ( [81.1.223.2])
        by mx.google.com with ESMTP id y1sm9635164uge.2007.02.12.19.32.57;
        Mon, 12 Feb 2007 19:32:57 -0800 (PST)
User-Agent: KMail/1.8
In-Reply-To: <45CFA30C.6030202@verizon.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39487>

=D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=D1=
=82 Monday 12 February 2007 05:13 Mark Levedahl =D0=BD=D0=B0=D0=BF=D0=B8=
=D1=81=D0=B0=D0=BB(a):
> 1) git is a POSIX only tool (i.e., there will be no \r\n munging), or
> 2) a Windows port of git will handle and mung \r\n and \n line ending=
s.
>
> If the answer is 1, the mingw port is a waste of time as it simply wo=
n't
> be usable by its target audience. If the answer is 2, then I think a
> very careful design of this capability is in order.

I am strongly object this statement. I develop one project under Window=
s and=20
use Cygwin git for this. Yes, I have a problem with git's thinking line=
=20
ending is a \n but most of troubles are diff and rebase. In general git=
 works=20
well with \r\n line endings.

When I have file that was converted from dos to unix format (or from un=
ix to=20
dos) git genereta big diff. But anyway, c++ compiler works well with bo=
th=20
formats and in this case I simply convert file to dos format and git sh=
ows=20
again nice diff. If unix format was commited to git I simply change the=
=20
format and commit that file again.

The only trouble is the rebase, it does not like \r\n ending and othen =
produce=20
unexpected merge conflict. But I don't use rebse to othen to realy=20
investigate and try to solve the problem.
