From: "Sylvain Bertrand" <sylvain.bertrand@gmail.com>
Subject: perl should be optional like tcl
Date: Sat, 22 Mar 2008 14:44:06 +0100
Message-ID: <d512a4f30803220644j1c74642fne709e27da792850@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 22 14:44:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jd41i-0005w7-CF
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 14:44:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753498AbYCVNoK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2008 09:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753367AbYCVNoJ
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Mar 2008 09:44:09 -0400
Received: from wx-out-0506.google.com ([66.249.82.233]:13622 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606AbYCVNoH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2008 09:44:07 -0400
Received: by wx-out-0506.google.com with SMTP id h31so2130808wxd.4
        for <git@vger.kernel.org>; Sat, 22 Mar 2008 06:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=ooMF5/GmFGKhO7PjuhGIzyGIbjXSi5xvlrA2OHQcg2Q=;
        b=OtYY/cTv74xbwP6w29eSWAxhFfKHIKIinHt4Ihg/MfL7IjQjBv3WiZILSrqdMcDlsCY0E9q3miBOtYu9hIACQkCbyVYQFOUQOmVCWhSHfSh03j8CURIU/d/wtbbjNjhWE+/YBkJRVprFFoX82FSwVYlH3s/fmBeIifhkyVw8zr4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=qUK3IyssZ3Qjjp/6O+cdSwBYRm2qMRyvKLFX9PZCU6LiwY9sZ09UFXjdF7w+YQRKbD7X4DFqhv2ZsYB29itCZ3nbj5l5E+ygIpMO6Ts4QQo0nMjJ9uORK3PTFD/D5BQJKRgMv17NlxcAdHFbqgZA9r4NycOYJ6uBeTDuDfCxb38=
Received: by 10.151.156.1 with SMTP id i1mr2151763ybo.163.1206193446221;
        Sat, 22 Mar 2008 06:44:06 -0700 (PDT)
Received: by 10.66.216.10 with HTTP; Sat, 22 Mar 2008 06:44:06 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77804>

Hi,
I'm a gentoo user and since a long time I have been able to disable
the perl sweet thanks to the gentoo "-perl" use flag. Recently I
realized that was not possible anymore (I have *tons* of perl
dependencies pulled on my system because of this).
That's about perl, but it would be similar with all the
others:python,ruby,lua,ocaml,vala,webscript,D,foo and foofoo++.
tcl stays optional for the users who accept to have the tcl sweet
installed, and perl should be treated the same way. Namely in the
build system, perl should be made optional like tcl. The idea is to
resist the temptation to favor one by making a hard dependency on it.
Since git is getting more and more popular (it's the best :) ), more
and more "high level language" developers will be interested to
interoperate with it. In order to *fairly* and *cleanly* integrate any
bindings/sweet from those "high level languages", the idea would be to
put their bindings/sweet in their repective directory, and to make the
build system have toggles for them.
My intend is not to favor any of them, nor to be naughty with any of them.
For instance, regarding the web interfaces we have:
 gitweb (perl)
 wit (python)
 gitarella (ruby)
 git-php (php)
 cgit (C)
(We may have a C++ one, a lua one, ocaml one, a D one and, of course,
the foofoo++ one...)

Best regards,

  Sylvain BERTRAND


P.S. Yes, I dislike the fact that emerge is python and paludis is C++.
Indeed, I dislike the use of automake for a build system. The idea is
not make it worse than it is already, a command shell and gmake is
almost too much already.
-- 
use single GPL licensed software, use Linux and secure your digital freedom!
