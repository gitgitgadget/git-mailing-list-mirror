From: Andy Lester <andy@petdance.com>
Subject: C internals cleanup
Date: Sun, 12 Apr 2009 22:15:05 -0500
Message-ID: <22578EEA-DB8B-4DAF-B217-FF13DC8A3EC7@petdance.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 13 05:16:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtCf4-0006Rg-C0
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 05:16:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754010AbZDMDPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Apr 2009 23:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753693AbZDMDPH
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Apr 2009 23:15:07 -0400
Received: from huggy.petdance.com ([72.14.176.61]:46821 "EHLO
	huggy.petdance.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753619AbZDMDPG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Apr 2009 23:15:06 -0400
Received: from mel.petdance.com (uniqua.petdance.com [64.81.227.163])
	by huggy.petdance.com (Postfix) with ESMTP id F12F51BE579
	for <git@vger.kernel.org>; Sun, 12 Apr 2009 23:15:05 -0400 (EDT)
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116406>

I've been poking around in the source for git, and wanted to pitch in  
and clean some things up.

Two biggies that tend to get overlooked: Applying the const keyword  
where possible, and localizing variables to innermost blocks.

Also, want to to get a target going in the Makefile for running under  
splint.

Just want to make sure my internal cleanups are not going to be seen  
as a nuisance.

xoxo,
Andy

--
Andy Lester => andy@petdance.com => www.petdance.com => AIM:petdance
