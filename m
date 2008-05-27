From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Invalid path on new Git installation
Date: Tue, 27 May 2008 17:51:58 +0200
Message-ID: <483C2E1E.3040302@viscovery.net>
References: <8345bd80805270758j1315234bwf3b16607c95c9620@mail.gmail.com>	 <20080527151406.GA16378@bit.office.eurotux.com> <8345bd80805270842y5e495109x350ef378795ada27@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marcus <prima@wordit.com>
X-From: git-owner@vger.kernel.org Tue May 27 17:53:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K11Tt-000495-5N
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 17:52:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757314AbYE0PwF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 11:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757076AbYE0PwD
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 11:52:03 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:8840 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756888AbYE0PwD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 11:52:03 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1K11Sw-0002so-44; Tue, 27 May 2008 17:52:00 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id DBD1B546; Tue, 27 May 2008 17:51:57 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <8345bd80805270842y5e495109x350ef378795ada27@mail.gmail.com>
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83028>

Marcus schrieb:
> On Tue, May 27, 2008 at 4:14 PM, Luciano Rocha <luciano@eurotux.com> wrote:
>> What is the correct path on the remote?
> 
> The full path to the Git repo is:
> /home/admin/mydomain.com/git/projectname.git
> 
> I tried:
> git clone ssh://admin@mydomain.com/~/git/projectname.git
> 
> It gives the same error.

Try

git clone admin@mydomain.com:/home/admin/mydomain.com/git/projectname.git

or (assuming /home/admin is your home directory)

git clone admin@mydomain.com:mydomain.com/git/projectname.git

or (if you can't live without the ssh: protocol specifier)

git clone \
  ssh://admin@mydomain.com/home/admin/mydomain.com/git/projectname.git

-- Hannes
