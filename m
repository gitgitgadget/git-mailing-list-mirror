From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: git stash save <message>
Date: Fri, 05 Mar 2010 13:55:28 +0100
Message-ID: <4B90FF40.4020607@viscovery.net>
References: <4B90F636.2030300@syntevo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Thomas Singer <thomas.singer@syntevo.com>
X-From: git-owner@vger.kernel.org Fri Mar 05 13:55:42 2010
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NnX48-0004gQ-OY
	for gcvg-git-2@lo.gmane.org; Fri, 05 Mar 2010 13:55:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751713Ab0CEMzc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Mar 2010 07:55:32 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:35769 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423Ab0CEMzb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Mar 2010 07:55:31 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NnX3w-00015N-RB; Fri, 05 Mar 2010 13:55:28 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 8D36F1660F;
	Fri,  5 Mar 2010 13:55:28 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <4B90F636.2030300@syntevo.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141579>

Thomas Singer schrieb:
> Where can I find information about what content in <message> is (not)
> allowed? We've got a bug-report where a SmartGit user has simply entered a
> minus and Git refused to work. Of course, entering just a minus is quite
> useless, but we have to be able to reliable detect allowed and disallowed
> messages.

Does SmartGit call 'git stash save' behind the scenes with the
user-supplied message? Then it should run

  git stash save -- "$msg"

and you don't need to forbid anything.

-- Hannes
