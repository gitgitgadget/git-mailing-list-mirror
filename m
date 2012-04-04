From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: Git push to samba/cifs share fails
Date: Wed, 4 Apr 2012 14:50:10 +0200
Message-ID: <CAHGBnuNMg8mVPegrC6L38msXomhhGWGGBUFriL8JDmi0qXMrVg@mail.gmail.com>
References: <4F75DDF9.8060305@gmail.com>
	<4F77514C.10205@gmail.com>
	<4F7C07C4.4010601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Emanuel Rietveld <codehotter@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 04 14:50:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFPfG-0004bd-E6
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 14:50:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756228Ab2DDMuM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Apr 2012 08:50:12 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:65177 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756141Ab2DDMuL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2012 08:50:11 -0400
Received: by obbtb18 with SMTP id tb18so278361obb.19
        for <git@vger.kernel.org>; Wed, 04 Apr 2012 05:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=aHVXXdlCQRe0CHXOEXftfzi+OCueEXjvoIpf4xb9NGU=;
        b=w67P1XB1lqILQYy2UR5fwS58JKxkOprHJqtg+8Dla0CKE43prnaovFEa7jo3wD4Saa
         raY8PuYbbLIL6opfYtknpS+VQnKPBeE7K/yuHAE/KdR+Oh0KXmeJ6CDMPB1GqgPjdhc/
         oVsIRIgig5e/VhtQ1E69SAC/aVI2Aa5QhDEoQKzAlhHrgbPWsyMx5lw+3aCzGCAKh8Tt
         /H22Xp3h8HApBI7xB8TcHO6ZTKCJphnf1B0QtezMqUMkGv1XxIW/Jk/KjKdIizcgyOxd
         j9FmxZxt1kaixoIFAAq8BR/LrKwOT6vGQ9EHAL60uw9fTapXdSmEpd58LheUd30m0hN2
         g0ww==
Received: by 10.182.77.167 with SMTP id t7mr24683717obw.10.1333543810586; Wed,
 04 Apr 2012 05:50:10 -0700 (PDT)
Received: by 10.182.72.195 with HTTP; Wed, 4 Apr 2012 05:50:10 -0700 (PDT)
In-Reply-To: <4F7C07C4.4010601@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194697>

On Wed, Apr 4, 2012 at 10:35, Emanuel Rietveld <codehotter@gmail.com> wrote:

> I am not using msysgit. My client is Fedora Linux 16 using git version
> 1.7.7.6. What excuse can I use to post to the msysgit mailing list for this
> non-msys git problem?

Well, I was thinking that if there's a problem with a Linux server and
Windows client, a similar issue might exist when using a Windows
server and Linux client. You could just ask on the msysgit mailing
list whether someone has problems using Windows shares exported by a
Windows Server 2003 installation.

> samba shares, not on windows shares. The ticket says it was eventually fixed
> on the server side. Is windows 2003 broken? Do I need to upgrade to windows
> 2008 to use git over cifs shares?

I have no idea, sorry, other that just trying to use Windows Server
2008 (e.g. in a VM) to see if that solves the problem, and if so,
upgrade your installation.

-- 
Sebastian Schuberth
