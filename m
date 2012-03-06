From: Jerome Yanga <jerome.yanga@gmail.com>
Subject: git push from client is not updating files on server
Date: Tue, 6 Mar 2012 08:52:11 -0800
Message-ID: <CAC0z1F-bGikXZtLnd8d=3G+4okvNqZaxyrLjh4G3YzPpmqyxQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 06 17:52:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4xcY-0004mh-Rg
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 17:52:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755647Ab2CFQwN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 11:52:13 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:64658 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755206Ab2CFQwM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 11:52:12 -0500
Received: by vbbff1 with SMTP id ff1so4625882vbb.19
        for <git@vger.kernel.org>; Tue, 06 Mar 2012 08:52:11 -0800 (PST)
Received-SPF: pass (google.com: domain of jerome.yanga@gmail.com designates 10.220.151.67 as permitted sender) client-ip=10.220.151.67;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jerome.yanga@gmail.com designates 10.220.151.67 as permitted sender) smtp.mail=jerome.yanga@gmail.com; dkim=pass header.i=jerome.yanga@gmail.com
Received: from mr.google.com ([10.220.151.67])
        by 10.220.151.67 with SMTP id b3mr3393391vcw.51.1331052731706 (num_hops = 1);
        Tue, 06 Mar 2012 08:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=e4njxjE0ONSo6ZID2m1hjE9peZTB4EEBx/tEJ2/9/ek=;
        b=eAlB5m9cGTQYcHE4kyY0f36YPiujqYqqnynSXwiKS7VNqpBPnUsoEm4ZVCyNW47aUU
         yh8ekaXdliWaWdE2iIa7WbV11LVEdjx0bhwzs1F+VVlOHgzt8NCmuiXlsOsVnwdUbNgo
         Ac3uCDoQSDmz69UG6nY2QvRQjRa7YTSKXdgoN1DMVTR/EuH/m/NXfzFxKTCVD2vchwhb
         crVMt6ZjKvxvuReXMPllUCNk947eWAZ6xqFc1Or2In5mf5XEV1Vszdvm7MRsbZDQkpAT
         qWSskz2P40wNWl4sjYSYF5+eatN2x/SoBtOYful2ovPhqxIDxmC7lPODZyK/iSBZRnGy
         6sAw==
Received: by 10.220.151.67 with SMTP id b3mr2936990vcw.51.1331052731256; Tue,
 06 Mar 2012 08:52:11 -0800 (PST)
Received: by 10.220.5.210 with HTTP; Tue, 6 Mar 2012 08:52:11 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192365>

My main objective is to create a central public Git server.  I had
followed the instructions in the URL below to make it public.

http://book.git-scm.com/4_setting_up_a_public_repository.html

>From the git client server, I can successfully clone projects in from
the central public Git server using the command below.

git clone http://<hostname_of_central_public_git_server>/<Project_name>.git

My push seems to be successful too using the command below as I get
the message "Everything up-to-date".

git push

However, when I log into the central public Git server and look at the
files in the project, none of them have change.  I can only see the
changes from the client via Gitweb.

Help.

Regards,
j
