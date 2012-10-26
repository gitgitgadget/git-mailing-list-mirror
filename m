From: Jeremy Morton <admin@game-point.net>
Subject: Bizarre problem cloning repo from Codeplex
Date: Fri, 26 Oct 2012 23:48:29 +0100
Message-ID: <508B133D.3090300@game-point.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 27 00:46:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRsg2-0004km-1P
	for gcvg-git-2@plane.gmane.org; Sat, 27 Oct 2012 00:46:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934137Ab2JZWql (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2012 18:46:41 -0400
Received: from ip.game-point.net ([208.100.1.149]:55474 "EHLO
	ip.game-point.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932188Ab2JZWqk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2012 18:46:40 -0400
Received: from 87-194-212-214.bethere.co.uk ([87.194.212.214]:3509 helo=[192.168.0.101])
	by ip.game-point.net with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.80)
	(envelope-from <admin@game-point.net>)
	id 1TRsfq-0004rQ-I6
	for git@vger.kernel.org; Fri, 26 Oct 2012 23:46:42 +0100
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ip.game-point.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - game-point.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208495>

I'm trying to clone the following repository from Codeplex:

https://git01.codeplex.com/entityframework.git

git downloads all the objects, creates the directory "entityframework", 
then displays "error: RPC failed; result=56, HTTP code = 200" and 
immediately deletes the directory.

I can clone other HTTPS repos with this git installation, for example 
from Bitbucket and Github.  It's git 1.7.10.4 on Debian.  I can also 
clone this codeplex repo OK on my windows git installation 
(1.7.11.msysgit.1).  I'm totally perplexed; anyone have any idea what is 
going wrong with the Debian git installation here?

-- 
Best regards,
Jeremy Morton (Jez)
