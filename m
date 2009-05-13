From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: switching upstream tips
Date: Wed, 13 May 2009 10:16:30 +0200
Message-ID: <4A0A81DE.9070506@viscovery.net>
References: <4A0A6BD1.7050907@gmail.com>	 <81b0412b0905130019x114d53d1v86833217bff613bc@mail.gmail.com>	 <4A0A777E.7080506@gmail.com> <81b0412b0905130041t327ef5f2m3b6d1dfac51fc1b1@mail.gmail.com> <4A0A7BA1.4030500@gmail.com> <4A0A7D5E.1010909@viscovery.net> <4A0A7FBA.1010606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Ittay Dror <ittay.dror@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 13 10:16:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M49dq-0002zx-Qx
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 10:16:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757120AbZEMIQf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 04:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754373AbZEMIQd
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 04:16:33 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:16686 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757541AbZEMIQb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 04:16:31 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1M49df-0006Mf-14; Wed, 13 May 2009 10:16:31 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id AF47854D; Wed, 13 May 2009 10:16:30 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <4A0A7FBA.1010606@gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119001>

Ittay Dror schrieb:
> same thing:
>> git rebase -i --onto upstream old-upstream master
> fatal: Needed a single revision
> Does not point to a valid commit: upstream

I guess you don't have a branch with the name "upstream". Use the name (or
SHA1) that designates your upstream.

-- Hannes
