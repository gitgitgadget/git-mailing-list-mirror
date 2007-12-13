From: Michael Dressel <MichaelTiloDressel@t-online.de>
Subject: git merge --no-commit <branch>; does commit
Date: Thu, 13 Dec 2007 22:01:41 +0100 (CET)
Message-ID: <alpine.LSU.0.99999.0712132151080.5326@castor.milkiway.cos>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 13 22:02:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2vCb-0002mG-Gc
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 22:02:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763033AbXLMVCH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 16:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759911AbXLMVCG
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 16:02:06 -0500
Received: from mailout08.sul.t-online.de ([194.25.134.20]:40114 "EHLO
	mailout08.sul.t-online.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762052AbXLMVCF (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Dec 2007 16:02:05 -0500
Received: from fwd26.aul.t-online.de 
	by mailout08.sul.t-online.com with smtp 
	id 1J2vBy-0003SK-00; Thu, 13 Dec 2007 22:02:02 +0100
Received: from [192.168.2.100] (bdjngqZEQh-vaHV05bGvfDrdYGl-9eplzdq8rx1oih4Ux+RdYCChsoFnJMMi2hsZ77@[84.163.225.23]) by fwd26.t-online.de
	with esmtp id 1J2vBj-0cN9960; Thu, 13 Dec 2007 22:01:47 +0100
X-X-Sender: michael@castor.milkiway.cos
User-Agent: Alpine 0.99999 (LSU 796 2007-11-08)
X-ID: bdjngqZEQh-vaHV05bGvfDrdYGl-9eplzdq8rx1oih4Ux+RdYCChsoFnJMMi2hsZ77
X-TOI-MSGID: 4f608cc8-587a-470e-93aa-586376c9e7a3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68191>

Hi,

git merge --no-commit <branch> does "create" a commit. At lesat the 
head and index are moved to the new commit fetched from <branch>. Maybe 
that is because git was able to do a fast forward?

Cheers,
Michael
