From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: Difference between --date-order and reverse chronological order?
Date: Wed, 27 Apr 2011 21:39:50 +0200
Message-ID: <4DB87106.9030209@kdbg.org>
References: <12e0244a-313e-4d67-9b91-c0d443276cff@k7g2000yqj.googlegroups.com> <7v7haf8ulj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Dun Peal <dunpealer@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 21:40:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFAae-00070b-Pc
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 21:40:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756121Ab1D0Tjz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 15:39:55 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:46848 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755141Ab1D0Tjy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 15:39:54 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id BCA52CDF87;
	Wed, 27 Apr 2011 21:39:41 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 9AE3319F35B;
	Wed, 27 Apr 2011 21:39:50 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.14) Gecko/20110221 SUSE/3.1.8 Thunderbird/3.1.8
In-Reply-To: <7v7haf8ulj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172264>

Am 27.04.2011 19:36, schrieb Junio C Hamano:
> Dun Peal <dunpealer@gmail.com> writes:
> 
>> But by Git's definition, for a child commit to be created, its parent
>> must already exist. So even in reverse chronological order, all
>> parents should come after all their children, no?
> 
> I think "distributed" and "your clock may be skewed" would solve that
> puzzlement ;-)

Are you saying that given this history:

      E----D
    /     /
   A--B--C

* we can get D-C-B-E-A or D-E-C-B-A with --topo-order

* we can get the above plus D-C-E-B-A with --date-order

* and with neither --topo-order nor --date-order we can also get
D-E-A-C-B or D-C-B-A-E if there was sufficient clock skew when the
commits were created. How would such a clock skew have looked like?

-- Hannes
