From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http-push: making HTTP push more robust and more user-friendly
Date: Mon, 14 Jan 2008 11:35:36 -0800
Message-ID: <7v1w8kkxo7.fsf@gitster.siamese.dyndns.org>
References: <1200250979-19604-1-git-send-email-gb@gbarbier.org>
	<7vbq7ppbyh.fsf@gitster.siamese.dyndns.org>
	<alpine.LSU.1.00.0801141220001.8333@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Gr=C3=A9goire?= Barbier <gb@gbarbier.org>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 14 20:36:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEV6U-0004kg-0V
	for gcvg-git-2@gmane.org; Mon, 14 Jan 2008 20:36:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbYANTfp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2008 14:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751587AbYANTfp
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jan 2008 14:35:45 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40579 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968AbYANTfo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2008 14:35:44 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 68FAB5D08;
	Mon, 14 Jan 2008 14:35:43 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id EFBE65D07;
	Mon, 14 Jan 2008 14:35:38 -0500 (EST)
In-Reply-To: <alpine.LSU.1.00.0801141220001.8333@wbgn129.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Mon, 14 Jan 2008 12:21:08 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70469>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sun, 13 Jan 2008, Junio C Hamano wrote:
>
>> The second one to add a couple of "goto cleanup" looked correct.  Acks, 
>> people?
>
> I haven't used http-push in ages, but there was a bug report with msysgit.  
> Hopefully that issue gets fixed by this patch.

Could you work with the reporter to see if this fixes the issue
for him?
