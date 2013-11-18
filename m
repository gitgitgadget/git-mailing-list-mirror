From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: Git clone from ftp issue
Date: Mon, 18 Nov 2013 12:43:50 +0400
Message-ID: <20131118124350.446cc52f4cf688f41820f0c4@domain007.com>
References: <CAFVLdUm=Jz5t=f+tZvDKGWAFoGi40oV_aLb_qoxrsreTrGTK=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Zachary Rodriguez <zmrodriguez91@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 18 09:44:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ViKR5-0005gJ-N7
	for gcvg-git-2@plane.gmane.org; Mon, 18 Nov 2013 09:44:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157Ab3KRIn4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Nov 2013 03:43:56 -0500
Received: from mailhub.007spb.ru ([84.204.203.130]:49304 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735Ab3KRInz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Nov 2013 03:43:55 -0500
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id rAI8hoef014069;
	Mon, 18 Nov 2013 12:43:51 +0400
In-Reply-To: <CAFVLdUm=Jz5t=f+tZvDKGWAFoGi40oV_aLb_qoxrsreTrGTK=w@mail.gmail.com>
X-Mailer: Sylpheed 3.3.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237979>

On Sun, 17 Nov 2013 13:22:40 -0700
Zachary Rodriguez <zmrodriguez91@gmail.com> wrote:

> Hello. I am having trouble setting up a git repository on an ftp
> server. The repository is bare and has had several commits made before
> being moved to the ftp server. I am attempting to clone from my ftp
> server, but git fails with the ftp error code 550. Inspection of the
> ftp packets via wireshark reveals that git is successfully changing to
> its desired working directory on the ftp server, but then it attempts
> to execute the 'size' command on the refs directory which generates
> the error code 550. Is this normal behavior or is it a bug?

http://thread.gmane.org/gmane.comp.version-control.git.user/3469/
