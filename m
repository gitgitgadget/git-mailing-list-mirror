From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Git Clone Parameter
Date: Fri, 19 Jul 2013 15:33:25 +0200
Message-ID: <51E94025.3090802@viscovery.net>
References: <FB572366-0B1D-4053-9255-979CB213B160@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Allan Acheampong <allanadjei@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 19 15:33:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0AoV-0002BF-JS
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 15:33:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760145Ab3GSNdf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 09:33:35 -0400
Received: from so.liwest.at ([212.33.55.13]:44683 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759738Ab3GSNdf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 09:33:35 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1V0AoM-0008K3-NT; Fri, 19 Jul 2013 15:33:30 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 730C31660F;
	Fri, 19 Jul 2013 15:33:25 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <FB572366-0B1D-4053-9255-979CB213B160@gmail.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230805>

Am 7/19/2013 11:21, schrieb Allan Acheampong:
> Something like 'git clone <theRepo> -createLocalBranchesForAllBranches'

Perhaps:

$ git clone theRepo
$ git fetch origin refs/heads/*:refs/heads/*

(untested). There may be ways to write the same shorter, but I've lost
track of what is and what is not possible in refspec.

-- Hannes
