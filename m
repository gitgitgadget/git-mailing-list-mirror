From: "Paulo J. Matos" <pocm@soton.ac.uk>
Subject: Fetch pack fails
Date: Tue, 6 May 2008 12:55:44 +0100
Message-ID: <11b141710805060455r74676fbau94ec3e329dd3a135@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 06 13:56:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtLme-00062U-QQ
	for gcvg-git-2@gmane.org; Tue, 06 May 2008 13:56:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756643AbYEFLzt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2008 07:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757294AbYEFLzt
	(ORCPT <rfc822;git-outgoing>); Tue, 6 May 2008 07:55:49 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:40866 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756643AbYEFLzr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2008 07:55:47 -0400
Received: by yw-out-2324.google.com with SMTP id 9so695860ywe.1
        for <git@vger.kernel.org>; Tue, 06 May 2008 04:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        bh=b9lrXmY4KeKbKW82AhtChpxZ8mE1x8UiGYsdpww5rqY=;
        b=EyhsNUYXHSmWxwUvH1PTQvNJQNLbdOyOemaF1eDDWHhJ8OmB6q8WQSJNjm5VTENt/ouYuPrBFbZfC0z4XyqZj8tqwBXygVUKGdggBrhyn/X90sg+SQwOi+YoNJK4XdliTyflJDQuCrjpo6An8KL1+sG7KvLJqgvm5f+yZIGdmZA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=E8cjJm/x2yc3poFW9NEvU9JUtRvx+kXXHjshPwdcJ+DjNMUzcEYOyYjIIhOY/tm0UiXS0x2p/Jg0GmhUdteJ8VXFRC5/KyVY3Y9XOJf7rWKQqkjAM9tLPwQb40e/SFO0tndMjT3YGpXZGNf4VllG8MltKvAK/76cYkMZ5J3L03Q=
Received: by 10.150.191.15 with SMTP id o15mr562129ybf.54.1210074944318;
        Tue, 06 May 2008 04:55:44 -0700 (PDT)
Received: by 10.151.102.8 with HTTP; Tue, 6 May 2008 04:55:44 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: f10002073fd6312c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81354>

Hello all,

I am trying to set up my git server using git-daemon, unfortunately
the simple config is not working. I have ran git-daemon by hand using:
git-daemon --syslog --export-all --base-path=/data/git&

In /data/git/pocm/ I have test.git/

I do:
$ git clone git://localhost/pocm/test.git test
Initialized empty Git repository in /home/pocm06r/test/.git/
fatal: The remote end hung up unexpectedly
fetch-pack from 'git://localhost/pocm/test.git' failed.

I don't understand what's the problem with fetch-pack. Nothing shows
up on /var/log/messages.
Anyway to get more information from git to know what the problem git is having?

Cheers,

-- 
Paulo Jorge Matos - pocm at soton.ac.uk
http://www.personal.soton.ac.uk/pocm
PhD Student @ ECS
University of Southampton, UK
Sponsor ECS runners - Action against Hunger:
http://www.justgiving.com/ecsrunslikethewind
