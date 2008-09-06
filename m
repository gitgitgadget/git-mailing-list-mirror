From: Eric Gerlach <egerlach@feds.uwaterloo.ca>
Subject: Is "show-ref -h" a good test for an empty repository?
Date: Fri, 05 Sep 2008 20:45:34 -0400
Message-ID: <48C1D2AE.3010001@feds.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 06 03:17:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbmPw-0005RN-D7
	for gcvg-git-2@gmane.org; Sat, 06 Sep 2008 03:16:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751764AbYIFBOu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2008 21:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751647AbYIFBOu
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Sep 2008 21:14:50 -0400
Received: from mail.feds.uwaterloo.ca ([129.97.194.182]:2731 "EHLO
	mail.feds.uwaterloo.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751514AbYIFBOu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2008 21:14:50 -0400
X-Greylist: delayed 1754 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Sep 2008 21:14:49 EDT
Received: from [129.97.194.93] (wks0003.feds_dom [129.97.194.93])
	by mail.feds.uwaterloo.ca (Postfix) with ESMTP id 333699F1D
	for <git@vger.kernel.org>; Fri,  5 Sep 2008 20:45:35 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95054>

Hi,

I'm trying to test to see if "git diff --cached" will fail because there 
are no existing commits.  I've come up with running "git show-ref -h -q" 
and testing its return value.  My hypothesis is: If and only if 
git-show-ref succeeds then git-diff will succeed.

Are my logic and assumptions sound?  I'm a bit out of my git comfort 
zone here, so I'd like to get some validation from some people who know 
better.

Thanks in advance for the help!

Cheers,

-- 
Eric Gerlach, Network Administrator
Federation of Students
University of Waterloo
p: (519) 888-4567 x36329
e: egerlach@feds.uwaterloo.ca
