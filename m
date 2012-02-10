From: supadhyay <supadhyay@imany.com>
Subject: Re: User authentication in GIT
Date: Fri, 10 Feb 2012 08:57:36 -0800 (PST)
Message-ID: <1328893056653-7273350.post@n2.nabble.com>
References: <1328595129258-7261349.post@n2.nabble.com> <1328615262741-7262113.post@n2.nabble.com> <CALKQrgdvOhfhTPg+g+LqCb6XOQczcz-nYC61B9x4W5dB4Up5oA@mail.gmail.com> <1328632848471-7262934.post@n2.nabble.com> <CAMK1S_i=QUxf1CPDwdDn0+2-7fL5xxMZ67rHvR63a-vU1uq39Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 10 17:57:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rvtn4-00036L-It
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 17:57:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758240Ab2BJQ5i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Feb 2012 11:57:38 -0500
Received: from sam.nabble.com ([216.139.236.26]:56158 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754076Ab2BJQ5h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 11:57:37 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <supadhyay@imany.com>)
	id 1Rvtmy-0001Tc-LT
	for git@vger.kernel.org; Fri, 10 Feb 2012 08:57:36 -0800
In-Reply-To: <CAMK1S_i=QUxf1CPDwdDn0+2-7fL5xxMZ67rHvR63a-vU1uq39Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190420>

Hi Sitaram,

Thanks for helping me by providing such a good link. Now, I am able to
understand how to manage the user in efficient way.

With that I have one question is-  in my GIT server we already migrated our
source code (pilot testing) from CVS to GIT. We used user "GITAdmin" for
migration and though its for pilot testing only we use the home directory
for source code repository is /home/GITAdmin/migration/VVD.git.

now the question is, I install gitolie using the same user "GITAdmin" and on
the same path i.e. /home/GITAdmin. And when add repository from my
workstation (git add conf/glitolite.conf) , this added repositories
directory on the GIT server path /home/GITAdmin/repositories/MRB.git

Now my confusion is my existing source code repository directory path during
migration /home/GITAdmin/migration/<repository.git> and now through gitolite
I want to manage both users and repositories  but through gitolite it add
repository in different path /home/GITAdmin/repositories/<repository.git>.


Can you please help how through gitolite I can add new repository on to the
same my exisitng migrated repository directory?




Thanks,
Suchi

--
View this message in context: http://git.661346.n2.nabble.com/User-authentication-in-GIT-tp7261349p7273350.html
Sent from the git mailing list archive at Nabble.com.
