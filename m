From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: What's cooking in git.git (May 2011, #11; Tue, 24)
Date: Wed, 25 May 2011 08:25:22 +0200
Message-ID: <4DDCA0D2.2070604@viscovery.net>
References: <7vboyr7oxh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 25 08:25:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QP7XB-0003yp-KE
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 08:25:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752069Ab1EYGZ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 02:25:28 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:16561 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751794Ab1EYGZ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 02:25:27 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1QP7X0-0008Vg-SO; Wed, 25 May 2011 08:25:23 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 94B211660F;
	Wed, 25 May 2011 08:25:22 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <7vboyr7oxh.fsf@alter.siamese.dyndns.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174372>

Am 5/24/2011 23:45, schrieb Junio C Hamano:
> * ab/i18n-scripts (2011-05-21) 48 commits
>   (merged to 'next' on 2011-05-23 at 69164a3)
>  ...
> 
> Rerolled.

I see you promoted ab/i18n-scripts-basic to master. What are your plans
with this topic? In its current form, git-submodule breaks in an obvious
way on Windows, and other pitfalls may hide elsewhere.

I don't have enough energy to help out with this issue, particularly
because i18n is not exactly my own itch. Personally, I wouldn't mind the
fate of the topic if there were a NO_GETTEXT switch that simply avoids all
the problems on Windows. Is there such a switch?

-- Hannes
