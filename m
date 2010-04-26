From: Jeremiah Foster <jeremiah.foster@pelagicore.com>
Subject: Re: Unable to coax hooks into working
Date: Mon, 26 Apr 2010 19:59:30 +0200
Message-ID: <E89E12CE-5BD7-4661-9A2D-91602F0F64FA@pelagicore.com>
References: <4C764DDD-420E-40C6-9848-96E2197BE70D@pelagicore.com> <4BD58D35.1010307@drmicha.warpmail.net>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 26 19:59:38 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6San-0005zs-O9
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 19:59:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753644Ab0DZR7c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Apr 2010 13:59:32 -0400
Received: from av6-1-sn3.vrr.skanova.net ([81.228.9.179]:36155 "EHLO
	av6-1-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752486Ab0DZR7b convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Apr 2010 13:59:31 -0400
Received: by av6-1-sn3.vrr.skanova.net (Postfix, from userid 502)
	id A17FC38B5D; Mon, 26 Apr 2010 19:59:30 +0200 (CEST)
Received: from smtp3-1-sn3.vrr.skanova.net (smtp3-1-sn3.vrr.skanova.net [81.228.9.101])
	by av6-1-sn3.vrr.skanova.net (Postfix) with ESMTP id 7092F38B5B
	for <git@vger.kernel.org>; Mon, 26 Apr 2010 19:59:30 +0200 (CEST)
Received: from [10.8.36.139] (194-237-7-146.customer.telia.com [194.237.7.146])
	by smtp3-1-sn3.vrr.skanova.net (Postfix) with ESMTP id 6300537E46
	for <git@vger.kernel.org>; Mon, 26 Apr 2010 19:59:30 +0200 (CEST)
In-Reply-To: <4BD58D35.1010307@drmicha.warpmail.net>
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145834>


On Apr 26, 2010, at 2:55 PM, Michael J Gruber wrote:

> Jeremiah Foster venit, vidit, dixit 26.04.2010 14:32:
>> Hello,
>> 
>> 	After reading this page: http://book.git-scm.com/5_git_hooks.html on git hooks and doing a test implementation, I cannot seem to coax my git hooks into working.
>> 
>> 	My understanding is that the hook is in the right location, in the git repository on the remote server, when doing a hook based on a post-commit update. I have down chown and chmod, the code executes, it just doesn't execute when I update the git repo and push. I have also tested this on the local machine with a different hook for the client also without success. 
>> 
>> 	We're using debian testing and git 1.7.0.2 with the http-smart backend.
>> 
>> 	What should I do to get hooks working?
> 
> Use the right hook.

I followed that document I listed explicitly. After lining up the right command, the right hook, and the right location, including correct executable bits as well as script ownership, a functioning script was built. Yet when the corresponding git command was called, the command failed to send data to the client which leads me to believe that the hooks wasn't called.

Can I confirm that hooks work with this type of transport, that is to say with the hook invoked by git-receive-pack and the newer http-smart backend?

Thanks,

Jeremiah
