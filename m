From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] object.h: Remove obsolete struct object_refs
Date: Mon, 14 Mar 2011 18:03:01 +0100
Message-ID: <4D7E4A45.3060703@drmicha.warpmail.net>
References: <4D7E4118.6060802@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakob Pfender <jpfender@elegosoft.com>
X-From: git-owner@vger.kernel.org Mon Mar 14 18:06:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzBE8-0002Yc-CN
	for gcvg-git-2@lo.gmane.org; Mon, 14 Mar 2011 18:06:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752892Ab1CNRGe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2011 13:06:34 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:50665 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751142Ab1CNRGd (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Mar 2011 13:06:33 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 26DA920EBF;
	Mon, 14 Mar 2011 13:06:33 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 14 Mar 2011 13:06:33 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=VmapHVVK7h2vD3mlYL8Y6x3tpQA=; b=B85+CEEFUk7fMIzD1YvRZzjLKcd3kIxRrIXpqLHBiuEMTLc6WlBtUTbnAXPsFTy2q77ijSjrq/Tx2YMQ2zuSIbFu5fi93FYDSRi02yqUil3g53AoWwsrSi6UokCeiGT8OEfbgrmoDWoZg7CeyLWhGAgA4/SCOJ8rCmGhnqv5K7g=
X-Sasl-enc: fvsqWgy2sRIONjeg+ZoGA4LlaglDN/JEk9Pc1qkNMhaR 1300122392
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 8E70E442881;
	Mon, 14 Mar 2011 13:06:32 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <4D7E4118.6060802@elegosoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169000>

Jakob Pfender venit, vidit, dixit 14.03.2011 17:23:
> The struct object_refs in object.h is never used anywhere, so remove it.
> 

Maybe you could add the information that it is unused since

7914053 (Remove unused object-ref code, 2008-02-25)

That saves everyone else a pickaxe :)

Michael
