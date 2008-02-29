From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 22/40] Windows: Implement asynchronous functions as
 threads.
Date: Thu, 28 Feb 2008 23:51:54 -0800
Message-ID: <7v7igodwth.fsf@gitster.siamese.dyndns.org>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
 <1204138503-6126-23-git-send-email-johannes.sixt@telecom.at>
 <alpine.LSU.1.00.0802281525510.22527@racer.site>
 <47C6F40A.4010703@comcast.net>
 <alpine.LSU.1.00.0802290122110.22527@racer.site>
 <47C76407.3090804@comcast.net>
 <alpine.LSU.1.00.0802290150440.22527@racer.site>
 <47C77720.2080405@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Paul Franz <thefranz@comcast.net>
X-From: git-owner@vger.kernel.org Fri Feb 29 08:52:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JV02x-0007Sj-8K
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 08:52:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843AbYB2HwL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 02:52:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbYB2HwK
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 02:52:10 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60820 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778AbYB2HwJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 02:52:09 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BDD8513F6;
	Fri, 29 Feb 2008 02:52:07 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id E1BDE13F4; Fri, 29 Feb 2008 02:52:02 -0500 (EST)
In-Reply-To: <47C77720.2080405@comcast.net> (Paul Franz's message of "Thu, 28
 Feb 2008 22:08:16 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75511>

Paul Franz <thefranz@comcast.net> writes:

> Johannes Schindelin wrote:
>> Hi,
>>
>> [top-posting?]
>
> Is there something wrong with it?

Yes.  Please do not do it.
