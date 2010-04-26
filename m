From: Jeremiah Foster <jeremiah.foster@pelagicore.com>
Subject: Re: Unable to coax hooks into working
Date: Mon, 26 Apr 2010 20:04:51 +0200
Message-ID: <B65E8227-B3C0-4AB8-A225-4A5661523CAD@pelagicore.com>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 26 20:05:34 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6SgV-0000CI-So
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 20:05:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752726Ab0DZSFW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Apr 2010 14:05:22 -0400
Received: from av9-2-sn2.hy.skanova.net ([81.228.8.180]:35070 "EHLO
	av9-2-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751918Ab0DZSFV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Apr 2010 14:05:21 -0400
Received: by av9-2-sn2.hy.skanova.net (Postfix, from userid 502)
	id 98A4D38793; Mon, 26 Apr 2010 20:05:17 +0200 (CEST)
Received: from smtp4-1-sn2.hy.skanova.net (smtp4-1-sn2.hy.skanova.net [81.228.8.92])
	by av9-2-sn2.hy.skanova.net (Postfix) with ESMTP id 199F038957
	for <git@vger.kernel.org>; Mon, 26 Apr 2010 20:04:52 +0200 (CEST)
Received: from [10.8.36.139] (194-237-7-146.customer.telia.com [194.237.7.146])
	by smtp4-1-sn2.hy.skanova.net (Postfix) with ESMTP id 0ECB937E46
	for <git@vger.kernel.org>; Mon, 26 Apr 2010 20:04:52 +0200 (CEST)
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145838>



>> 	We're using debian testing and git 1.7.0.2 with the http-smart backend.
>> 
>> 	What should I do to get hooks working?
> 
> Use the right hook.
> 
I followed that document I listed explicitly. After lining up the right command, the right hook, and the right location, including correct executable bits as well as script ownership, a functioning script was built. Yet when the corresponding git command was called, the command failed to send data to the client which leads me to believe that the hooks wasn't called.

Here is so more information on the http backend I was referring to: progit.org/2010/03/04/smart-http.html
And the manual page: www.kernel.org/pub/software/scm/git/docs/git-http-backend.html

Can I confirm that hooks work with this type of transport? 

Jeremiah
