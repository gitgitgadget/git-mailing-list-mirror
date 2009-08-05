From: Ian Hobson <ian@ianhobson.co.uk>
Subject: Advice needed - handling configuration files
Date: Wed, 05 Aug 2009 12:35:38 +0100
Message-ID: <4A796E8A.70407@ianhobson.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 05 13:51:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYf1Y-0006fx-M5
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 13:51:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933452AbZHELvF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 07:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933321AbZHELvF
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 07:51:05 -0400
Received: from ianhobson.com ([212.13.194.210]:39074 "EHLO smtp.ianhobson.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933270AbZHELvE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 07:51:04 -0400
X-Greylist: delayed 926 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Aug 2009 07:51:04 EDT
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by smtp.ianhobson.com (Postfix) with ESMTP id 03DCD680AD
	for <git@vger.kernel.org>; Wed,  5 Aug 2009 12:35:37 +0100 (BST)
User-Agent: Thunderbird 2.0.0.22 (Windows/20090605)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124898>

Hi all,

Git newbie here, so please spell things out.  I've been reading the docs 
and got quite confused  :)

I have a web application that has been developed for one customer. It 
is  just about to go to three customers -each will need their own config 
file, css file and directory of images. Each customer may have a test 
and production version that differ only in the config file. The 
developer (me) also needs configuration files for various purposes 
(scripted testing and manual testing).

What is the best way of handling this situation, so that the config, css 
and image files are under version control, without having to repeat 
changes in  three branches?

If a patch set could be created that contained all but the changes to 
the configuration files, then that could be pulled up into the 
mothership, and each satellite can have its own configuration. I want to 
avoid renaming/copying files if possible because that is change that 
goes into production untested.

Regards

Ian
