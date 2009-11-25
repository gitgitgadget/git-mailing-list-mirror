From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH] grep: --full-tree
Date: Wed, 25 Nov 2009 17:43:37 -0500
Message-ID: <4B0DB319.6000805@gmail.com>
References: <7vk4xggv27.fsf@alter.siamese.dyndns.org> <20091125203922.GA18487@coredump.intra.peff.net> <7viqcytjic.fsf@alter.siamese.dyndns.org> <20091125210034.GC18487@coredump.intra.peff.net> <7vmy2as319.fsf@alter.siamese.dyndns.org> <4B0DAC9F.2010205@gmail.com> <7vljhuqm84.fsf@alter.siamese.dyndns.org> <4B0DB04A.6020209@gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: gitzilla@gmail.com
X-From: git-owner@vger.kernel.org Wed Nov 25 23:43:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDQaO-0005ob-Sr
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 23:43:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759841AbZKYWnd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 17:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759829AbZKYWnd
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 17:43:33 -0500
Received: from mail-yw0-f182.google.com ([209.85.211.182]:33817 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759832AbZKYWnc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 17:43:32 -0500
Received: by ywh12 with SMTP id 12so209833ywh.21
        for <git@vger.kernel.org>; Wed, 25 Nov 2009 14:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=N5E92wdVTISmYg99U+LtCdGZo7heKpRybM4Vzd6MqRg=;
        b=SkoPsK/u7y6eERj8vyTjKdz8Ej9f8JCfAVyVtlOYuTy40zTLUcA+VDExZygiVrzRp1
         GBqVBUI7pJHJeVH6d6LeVn1tuz5yL0cvfL4CqjkSf4zB78S+9GnCJLmfjFQs2bZ9SaOb
         fW0ekSYz73jGAWOJexRzAlZAmVF/Zt+lM249M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=foVx2Z8KzFzrv+Ta/TpD3+r6BRTzsQhfCkUdNt0b+kGPbfSNFetj2d/C04ruT2wPQT
         FCvhcpzEoMGn2M8znA0YmOX9Q7wDMd0+uX3Nk6Wj6pfqjkTy3+e1UgWrZVGbBYae+eKd
         hUpqV3G2dJsH1K7ydABwKHTgkHNAtvXY7MzyA=
Received: by 10.150.251.10 with SMTP id y10mr14626144ybh.49.1259189018905;
        Wed, 25 Nov 2009 14:43:38 -0800 (PST)
Received: from ?10.0.0.6? (c-71-199-240-201.hsd1.fl.comcast.net [71.199.240.201])
        by mx.google.com with ESMTPS id 4sm42995ywd.29.2009.11.25.14.43.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Nov 2009 14:43:38 -0800 (PST)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <4B0DB04A.6020209@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133690>

A Large Angry SCM wrote:
> git-diff aside, I would be much happier with git's interface, and I 
> think new/occasional users would be also, if it was consistent across 
> all of git commands. And even more so if git's conventions matched most 
> other commands on my system of choice.

s/my system of choice/the user's system of choice/
