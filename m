From: Marcus <prima@wordit.com>
Subject: Invalid path on new Git installation
Date: Tue, 27 May 2008 15:58:05 +0100
Message-ID: <8345bd80805270758j1315234bwf3b16607c95c9620@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 16:59:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K10dh-0008UZ-GX
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 16:59:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756088AbYE0O6K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 10:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755850AbYE0O6J
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 10:58:09 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:41079 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755790AbYE0O6G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 10:58:06 -0400
Received: by py-out-1112.google.com with SMTP id p76so2130956pyb.10
        for <git@vger.kernel.org>; Tue, 27 May 2008 07:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        bh=JudkThMGsz4Jgu5dPFr01DgrQPNEEvn9dYL7Kv+lY5Y=;
        b=Y5LemGUY+R16k+ssdY5h6rBvxJfJd7/Xd/N0DcF7ZMcq2bzY7sUi1x4iElUZRFN674eRM6CpNrqGmsD9lobWmYFon5jILY4HZUXPci8YY4FDJR22Fj/Ulyi066KtSsg6fTgHGtMY6VscTzJJ3MLhr87MUIM4AGSaTq2OXTyiU9k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=QuRKnp3VwmBU/M+kVeQfgI6ROBA4sALfBjtP72UMMZ0JeLaF5fCQxcEO2VElRuzIbxL4uvYkDLoGHh2Q6cO5nNxkfQJNbkWjA0prMIw2mN9LpP81NsF2P7dRrX3z6jBEGis6AlXN9wT8ovvUwyOzox9A8evl836D+oNnho5tFwY=
Received: by 10.140.201.15 with SMTP id y15mr598042rvf.33.1211900285185;
        Tue, 27 May 2008 07:58:05 -0700 (PDT)
Received: by 10.141.202.7 with HTTP; Tue, 27 May 2008 07:58:05 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: dc133e04569ea433
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83023>

Can anybody help me with defining a valid path to a Git repo on a new
installation?
I just built Git on a webserver (a VPS so I have root access). When I
try clone or push I get this error:

fatal: '/git/watchsite.git': unable to chdir or not a git archive
fatal: The remote end hung up unexpectedly
fetch-pack from 'ssh://me@mydomain.com/git/projectname.git' failed.

Why this when I can use wget on this path:
wget mydomain.com/git/projectname.git/file.html
The above successfully downloads the file, so the path is valid, right?
I also did "git init" on the remote repo (not sure if that's necessary?).

I tried the following commands locally and all fail with the error above:

git clone ssh://me@mydomain.com/git/projectname.git/

git clone http://mydomain.com/git/projectname.git/

git push ssh://me@mydomain.com/git/projectname.git/ master


Is there a syntax error or something I need to set up on the remote server?

Thanks,

Marcus
