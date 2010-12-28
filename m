From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH 01/31] rebase: clearer names for directory variables
Date: Tue, 28 Dec 2010 21:53:46 +0100 (CET)
Message-ID: <alpine.DEB.1.10.1012282137580.29381@debian>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com> <1293528648-21873-2-git-send-email-martin.von.zweigbergk@gmail.com> <7vtyhxts0a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 29 03:53:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXmA6-0006qH-Ss
	for gcvg-git-2@lo.gmane.org; Wed, 29 Dec 2010 03:53:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788Ab0L2Cwz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Dec 2010 21:52:55 -0500
Received: from mail-qy0-f194.google.com ([209.85.216.194]:38899 "EHLO
	mail-qy0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751015Ab0L2Cwy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Dec 2010 21:52:54 -0500
Received: by qyk4 with SMTP id 4so2915055qyk.1
        for <git@vger.kernel.org>; Tue, 28 Dec 2010 18:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:x-x-sender:to:cc
         :subject:in-reply-to:message-id:references:user-agent:mime-version
         :content-type;
        bh=grpOmNAuo1TaTgEX1fKellkj7I5CEytT+rc43hSIMgE=;
        b=k/n0oIhkZdQJj3wA4PcdV62y5TsvumoNn0ziWZKu1IBjiWp8QUjqww6sdA2pku2Mcg
         1EXfDTyx6vtN1nZ++c2e+AKviOFpESlcfJZs/EE2jvV4DEeHeDimmZ2m2RhwJdpseAiZ
         CKrGwtCGL1F3ovWzLB2mN431XoIEo/qHvYxLg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=DVFCvN9aexfqbCm4AdR8GA9KjtysgzWE7RFgpD/2/YTIKe+3lhhOWi/saowA6l/RTy
         5soSxsfim2PYAh3fNtShyojp03ZIIG0hcqZ494WzFGTTJi/0ZiFM06cptz22alJMOwU5
         XI8a8fpEGpVrI3T6GYx+P8vGHNTwNN9bJrlLU=
Received: by 10.229.229.132 with SMTP id ji4mr12453095qcb.285.1293591173660;
        Tue, 28 Dec 2010 18:52:53 -0800 (PST)
Received: from [192.168.1.105] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id s10sm6614835qco.11.2010.12.28.18.52.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Dec 2010 18:52:52 -0800 (PST)
X-X-Sender: martin@debian
In-Reply-To: <7vtyhxts0a.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164302>


On Tue, 28 Dec 2010, Junio C Hamano wrote:

> If this were just "s/dotest/merge_dir/g" and the same for rebase-apply, I
> would have to say it is long overdue ;-)


Yes, that should be all!

Well, to be precise, in the "@@ -560,35 +561,35 @@ then" hunk, I also
moved the quotes to contain the file name as was done for
rebase-merge. I redid the search/replace just to double check.
