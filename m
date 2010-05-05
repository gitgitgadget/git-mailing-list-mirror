From: Samir Faci <samir@esamir.com>
Subject: svn repo a submodule?
Date: Wed, 5 May 2010 09:43:20 -0500
Message-ID: <g2i9db93b0e1005050743q43d745ebod1aa13f98ab5a44c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 05 16:43:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9fov-0000AO-Ku
	for gcvg-git-2@lo.gmane.org; Wed, 05 May 2010 16:43:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933664Ab0EEOnY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 May 2010 10:43:24 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:54012 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932329Ab0EEOnX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 May 2010 10:43:23 -0400
Received: by bwz25 with SMTP id 25so3017176bwz.28
        for <git@vger.kernel.org>; Wed, 05 May 2010 07:43:21 -0700 (PDT)
Received: by 10.204.34.201 with SMTP id m9mr4438343bkd.127.1273070600811; Wed, 
	05 May 2010 07:43:20 -0700 (PDT)
Received: by 10.204.57.71 with HTTP; Wed, 5 May 2010 07:43:20 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146403>

I've been using git submodule to refer to external repos that I don't
maintain.  (which works great)

So far in order to use an svn repo as a submodule I end up doing a git
svn clone, and basically have a crontab job that pulls from svn and
pushes to git repo.  Then I end up using the git repo it creates as a
git submodule.

The workflow does work, though it is a bit tedious.   I was wondering
if there was any particular reason why having an svn repo as a
submodule isn't supported at this time.  Or if there was a better way
of accomplishing this that escapes me.


--
Samir Faci
*insert title*
fortune | cowsay -f /usr/share/cows/tux.cow
