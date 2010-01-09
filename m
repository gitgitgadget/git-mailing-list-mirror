From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: How to push changes from clone back to master
Date: Sat, 09 Jan 2010 02:00:26 +0100
Message-ID: <4B47D52A.1050608@dbservice.com>
References: <1262986087967-4275010.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Simon C <simonchu.web@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 09 02:00:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTPgy-0007YN-A7
	for gcvg-git-2@lo.gmane.org; Sat, 09 Jan 2010 02:00:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753413Ab0AIBAa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 20:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753409Ab0AIBAa
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 20:00:30 -0500
Received: from office.neopsis.com ([78.46.209.98]:58068 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869Ab0AIBAa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2010 20:00:30 -0500
Received: from calvin.caurea.org ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	(using TLSv1/SSLv3 with cipher AES256-SHA (256 bits));
	Sat, 9 Jan 2010 02:00:26 +0100
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.3a1pre) Gecko/20100108 Lightning/1.1a1pre Shredder/3.2a1pre
In-Reply-To: <1262986087967-4275010.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136504>

On 1/8/10 10:28 PM, Simon C wrote:
 >
 >
 > I created master branch in git:
 >
 > mkdir git_master;
 > cd git_master
 > git init
 > git add .
 > git commit
 >
 > create a clone
 > git clone . ../git_clone1
 > create newfile
 > git add newfile
 > git commit .
 >
 > then try to propagate changes to master
 > git push
 >
 > it gave me some warning, and subsequent git push says everything is up to
 > date.
 > but I do not see the new file under git_master

If you asked that question in the official IRC channel, the answer would 
be 'faq non-bare', which would cause the bot to send you a link to this 
entry in the Git FAQ:
http://git.or.cz/gitwiki/GitFaq#Whywon.27tIseechangesintheremoterepoafter.22gitpush.22.3F

tom
