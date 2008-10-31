From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH] Avoid using non-portable `echo -n` in tests.
Date: Fri, 31 Oct 2008 11:38:13 -0400
Message-ID: <B8E9E11A-48B9-44A8-8ED2-812FFFCFABA6@silverinsanity.com>
References: <8A4A84EC-51F7-4038-957C-CCA5C00E5977@silverinsanity.com> <1225429753-70109-1-git-send-email-benji@silverinsanity.com> <7vy70589jc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Shawn O Pearce <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 31 16:45:52 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kvw6T-0001t7-0d
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 16:40:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751919AbYJaPig (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 11:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751881AbYJaPig
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 11:38:36 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:35670 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751639AbYJaPif (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 11:38:35 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 564711FFC17B; Fri, 31 Oct 2008 15:38:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on 
	silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=5.0 tests=AWL,BAYES_00,RCVD_IN_PBL,
	RCVD_IN_SORBS_DUL autolearn=no version=3.1.7-deb
Received: from [192.168.1.109] (cpe-69-205-127-75.rochester.res.rr.com [69.205.127.75])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 9F5F71FFC176;
	Fri, 31 Oct 2008 15:38:19 +0000 (UTC)
In-Reply-To: <7vy70589jc.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.929.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99594>


On Oct 31, 2008, at 4:15 AM, Junio C Hamano wrote:

> Brian Gernhardt <benji@silverinsanity.com> writes:
>
>> Not all /bin/sh have a builtin echo that recognizes -n.  Using printf
>> is far more portable.
>
> This is much better (minor nit: we do not care if echo is built-in or
> /bin/echo); the point of t4030 is to produce an incomplete line ;-).

Well, yes.  The reason I phrased it that way was that my /bin/echo  
recognizes -n but /bin/sh does not.

~~ Brian
