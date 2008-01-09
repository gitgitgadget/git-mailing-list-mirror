From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/2] sideband.c: Use xmalloc() instead of variable-sized
 arrays.
Date: Wed, 09 Jan 2008 09:06:56 +0100
Message-ID: <478480A0.5030907@viscovery.net>
References: <4783A3B2.3060801@viscovery.net>	<alpine.LFD.1.00.0801081154460.3054@xanadu.home>	<4784791F.6090904@viscovery.net> <7vk5mjmo4f.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 09 09:07:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCVyU-0000wk-Sa
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 09:07:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752367AbYAIIHD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 03:07:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752178AbYAIIHB
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 03:07:01 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:17584 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163AbYAIIHA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 03:07:00 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JCVxh-0001R2-A3; Wed, 09 Jan 2008 09:06:57 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id C708F4E4; Wed,  9 Jan 2008 09:06:56 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7vk5mjmo4f.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69962>

Junio C Hamano schrieb:
> Johannes Sixt <j.sixt@viscovery.net> writes:
> 
>> Having said that, I'd actually prefer to stay with variable-sized arrays
>> if they prove portable enough because we don't need the handful of free()s
>> on function exits. Junio, if you like I can resend patch 2/2 using
>> variable-sized arrays.
> 
> As an old fashoned git myself, and given the fact that the
> possible prefix and suffix are small number of short constant
> strings, I actually prefer a simpler-and-more-stupid approach.
> 
>  sideband.c |   18 +++++++++++++-----
>  1 files changed, 13 insertions(+), 5 deletions(-)

Thanks, your version works well here, too, as a replacement of my two patches.

-- Hannes
