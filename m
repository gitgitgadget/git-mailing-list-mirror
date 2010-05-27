From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: git pull works remotely but not locally
Date: Thu, 27 May 2010 17:28:52 +0200
Message-ID: <4BFE8FB4.60002@viscovery.net>
References: <4BFE750B.5030007@llaisdy.com> <AANLkTikmrBQ1aUQeAZKB8pdgwXjureozZOzEHq8CF4kb@mail.gmail.com> <4BFE83A7.4020604@llaisdy.com> <AANLkTinn_D2nrZDoczHqvAFKdCxxubK0N0jHr-nE94JP@mail.gmail.com> <4BFE8A99.5060906@llaisdy.com> <20100527151514.GB18590@coredump.intra.peff.net> <4BFE8DF8.8050301@llaisdy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>, artagnon@gmail.com
To: Ivan Uemlianin <ivan@llaisdy.com>
X-From: git-owner@vger.kernel.org Thu May 27 17:29:06 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHf17-0003to-TR
	for gcvg-git-2@lo.gmane.org; Thu, 27 May 2010 17:29:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758317Ab0E0P27 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 May 2010 11:28:59 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:10144 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758309Ab0E0P24 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 May 2010 11:28:56 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1OHf0u-0002Ph-NO; Thu, 27 May 2010 17:28:52 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 67EE61660F;
	Thu, 27 May 2010 17:28:52 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <4BFE8DF8.8050301@llaisdy.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147875>

Please Reply-To-All, do not cull Cc list.

Am 5/27/2010 17:21, schrieb Ivan Uemlianin:
> $ GIT_TRACE=1 git pull
> trace: exec: 'git-pull'
> trace: run_command: 'git-pull'
> fatal: cannot exec 'git-pull': Permission denied

You get 'Permission denied' also if you cannot execute the shell that the
first line of the script references. But that would be really odd...

-- Hannes
