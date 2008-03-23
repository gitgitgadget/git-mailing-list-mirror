From: =?ISO-8859-15?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
Subject: git-config: aliases with parameter expansion ($1 and such)
Date: Sun, 23 Mar 2008 14:28:21 +0100
Message-ID: <47E65AF5.4060708@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 23 14:29:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdQG3-0004d5-3v
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 14:29:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759371AbYCWN2Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 09:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756905AbYCWN2Z
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 09:28:25 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:54280 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755357AbYCWN2Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 09:28:25 -0400
Received: from [84.176.102.166] (helo=[192.168.2.100])
	by smtprelay01.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1JdQFL-0001oR-Lp
	for git@vger.kernel.org; Sun, 23 Mar 2008 14:28:23 +0100
User-Agent: Thunderbird 2.0.0.12 (Windows/20080213)
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77891>

Hi, I've a question concerning git config and the alias things.
I'd like to create an alias 'atag' that creates an annotated
tag with the message being the same as the tag. Usually I create
annotated tags like this:

$ git tag -a -m "mytag" mytag

(BTW: It's not documented, but I have the impression that
the '-a' switch is implicitely added when the '-m' switch
is present. Is that true?)

I'd like to have an alias like this:

[alias]
    atag = tag -a -m "$1"

So that I can simply call

$ git atag mytag

Is it possible to pass parameters to the alias definition?
With the definition above I got a tag with message "$1".

Thanks, Dirk
