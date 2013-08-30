From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] revision: add --except option
Date: Fri, 30 Aug 2013 11:08:44 +0200
Message-ID: <5220611C.5080605@viscovery.net>
References: <1377838805-7693-1-git-send-email-felipe.contreras@gmail.com> <7vhae7k7t1.fsf@alter.siamese.dyndns.org> <CAMP44s1y2kvSnF3dKDMr9QtS40PNSW93DWCxFUoL658YkqYeVA@mail.gmail.com> <CAPc5daVSqoE74kmsobg7RpMtiL3vzKN+ckAcWEKU_Q_wF8HYuA@mail.gmail.com> <CAMP44s0P=XF5C8+fU2cJ-Xuq57iqcAn674Upub6N=+iiMpQK0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 30 11:08:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFKhJ-0007Wy-VP
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 11:08:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752754Ab3H3JIu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 05:08:50 -0400
Received: from so.liwest.at ([212.33.55.24]:53751 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752529Ab3H3JIt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 05:08:49 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1VFKhB-0001uF-4p; Fri, 30 Aug 2013 11:08:45 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id D6EDA1660F;
	Fri, 30 Aug 2013 11:08:44 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <CAMP44s0P=XF5C8+fU2cJ-Xuq57iqcAn674Upub6N=+iiMpQK0g@mail.gmail.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233435>

Am 8/30/2013 9:32, schrieb Felipe Contreras:
> On Fri, Aug 30, 2013 at 2:26 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> On Aug 30, 2013 12:19 AM, "Felipe Contreras" <felipe.contreras@gmail.com>
>> Would the same argument apply to
>>
>>   next ^maint --except maint
>>
>> where next gets in the queue, maint in tainted, and skipped?
> 
> maint is not skipped, as it's not the same as ^maint, basically it's
> the same as:
> 
> next ^maint
> 
> I think that's good, as there's absolutely no reason why anybody would
> want '^maint --except maint' to cancel each other out.

But isn't this basically the same as '--not maint --except maint'? This by
itself looks strange. But when disguised in the form '--not --branches
--except maint', it would make sense to mean '--not master next', aka
'^master ^next'.

-- Hannes
