From: Rudy YAYON <Rudy.YAYON.ext@boursorama.fr>
Subject: =?windows-1255?Q?Exclude_a_file_from_a_pull_request=FE?=
Date: Wed, 7 Oct 2015 15:55:18 +0000
Message-ID: <88A9B78851BE8145A87C05C88FC3ED840101DEB1@bsrspdag001.boursorama.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1255"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 07 18:14:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjrMT-0000qY-4L
	for gcvg-git-2@plane.gmane.org; Wed, 07 Oct 2015 18:14:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755074AbbJGQOc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Oct 2015 12:14:32 -0400
Received: from mail-out-001.boursorama.fr ([62.23.145.195]:52308 "EHLO
	mail.boursorama.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755060AbbJGQOb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Oct 2015 12:14:31 -0400
X-Greylist: delayed 1149 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Oct 2015 12:14:31 EDT
Received: from bsrspcas006.boulogne.boursorama.fr ([10.2.243.6] helo=exsmtp.boursorama.fr)
	by mail.boursorama.fr with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.69)
	(envelope-from <Rudy.YAYON.ext@boursorama.fr>)
	id 1Zjr3o-0006HQ-6U
	for git@vger.kernel.org; Wed, 07 Oct 2015 17:55:20 +0200
Thread-Topic: =?windows-1255?Q?Exclude_a_file_from_a_pull_request=FE?=
Thread-Index: AdEBGJCAWI+EJxB5TfCuNHoWqPtXSg==
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.3.153.105]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279181>

Hi all,
 
  I have a concern with r10k used by Puppet.
  r10k is a Puppet tool based on the git workflow.
 
  My concern is that one important file (Puppetfile) needs to be pushed to my remote repository so I can check the changes I commited.
  To do that, I need to commit changes (included to the Puppetfile) then I need to push it to the remote repository.
 
  Once I want to merge these changes from a specific branch to the master branch, I do NOT want to include this file. In other words, I want to merge all files except the Puppetfile file.
 
  What is the best way for you to do that?
 
Reminder: I can't ignore the file as I have to push it to the remote repository (origin) 

Regards,
Rudy YAYON
