From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv2 1/2] git-patch-id: test for "no newline" markers
Date: Thu, 17 Feb 2011 13:11:59 +0100
Message-ID: <4D5D108F.7060606@drmicha.warpmail.net>
References: <7vwrkziw2i.fsf@alter.siamese.dyndns.org>	<d27aa07556df763b34b980d3706320216094d592.1297928549.git.git@drmicha.warpmail.net> <m3ei7698qf.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 17 13:15:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pq2lO-0002SJ-9w
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 13:15:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753760Ab1BQMPJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 07:15:09 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:37781 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753621Ab1BQMPI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Feb 2011 07:15:08 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 66212207F8;
	Thu, 17 Feb 2011 07:15:07 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 17 Feb 2011 07:15:07 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=g4zPFgPSseMQoxH2YgPQm86R7yA=; b=BTSbJ9zDvhQL+p0CDrYCuN5JM3FhLplwhwpIyBXtnN/URLwU3PbWfGoFrAWlDV4i457X5LmSqfFVacRMdqau7AK6NlAwTYygIbDtCTqbJxGv6ZnOzWPPwjRFRCFUxlD61nQneDQJiyZ1yQL+yxx7DXJV8LUtDr0YtgzLbEqfECk=
X-Sasl-enc: GhXDan50Wx9hQJeWrcofwQRTPU2/etRsLgwPK0H87tB8 1297944907
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id AB5C6409762;
	Thu, 17 Feb 2011 07:15:06 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <m3ei7698qf.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167073>

Jakub Narebski venit, vidit, dixit 17.02.2011 12:55:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Currently, patch-id trips over our very own diff extension for marking
>> the absence of newline at EOF.
> 
> This is not *our* diff extension; it is either GNU diff extension, or
> it is defined in diff/patch format standard.

So, which one is it?

The point is that our very own code produces that extension, so we'd
better support what our "diff" and "log -p" produce.

Michael
