From: slipstream180 <ivan.barrios@gmail.com>
Subject: How do you add an external directory to repository?
Date: Sun, 7 Mar 2010 12:03:49 -0800 (PST)
Message-ID: <1267992229319-4691734.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 07 21:04:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoMhi-0003RA-4P
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 21:03:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754751Ab0CGUDv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Mar 2010 15:03:51 -0500
Received: from kuber.nabble.com ([216.139.236.158]:52534 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754643Ab0CGUDu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Mar 2010 15:03:50 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <ivan.barrios@gmail.com>)
	id 1NoMhZ-0007qB-AX
	for git@vger.kernel.org; Sun, 07 Mar 2010 12:03:49 -0800
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141725>


I want to add an external directory to an existing repository.

External Dir: /home/some/directory

Working Dir: /htdocs/.git

If I attempt the following command from the /htdocs dir:

git add /home/some/directory

I get an error: fatal: '/home/some/directory' is outside repository

I understand that I can add a symbolic link to /home/some/directory, but I
believe that only track the link. How do I track all files under the
directory as well?

Thanks in advance!

-- 
View this message in context: http://n2.nabble.com/How-do-you-add-an-external-directory-to-repository-tp4691734p4691734.html
Sent from the git mailing list archive at Nabble.com.
