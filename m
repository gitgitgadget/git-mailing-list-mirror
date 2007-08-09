From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] allow git-bundle to create bottomless bundle
Date: Wed, 08 Aug 2007 22:48:05 -0400
Message-ID: <46BA8065.6010005@gmail.com>
References: <fcaeb9bf0708070623p24f1cae2q2af959a89738c4e8@mail.gmail.com>	<20070808035946.GP9527@spearce.org>	<Pine.LNX.4.64.0708081012110.14781@racer.site>	<7vlkcl4zcw.fsf@assigned-by-dhcp.cox.net> <7vps1xzic2.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	Mark Levedahl <mdl123@verizon.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 09 04:48:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIy4N-0000EX-Va
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 04:48:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764481AbXHICsM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 22:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763105AbXHICsL
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 22:48:11 -0400
Received: from an-out-0708.google.com ([209.85.132.241]:12550 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763573AbXHICsK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 22:48:10 -0400
Received: by an-out-0708.google.com with SMTP id d31so66000and
        for <git@vger.kernel.org>; Wed, 08 Aug 2007 19:48:09 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=GoPBl3WhoYd2r+2VE8HRpADYfBmB6WFfYzFMt3+rTWG7JSBM7/5d/f90rNeVoEhukDrqlrHcIExrFamoJ3UJ1TAG+NQm8QK849PlYkMr7+t8xJjrqbICcY3IzF81orJurhlcQ7dOJBus6JPVlwPv06hFA1yQbIP6m9WZta9gXPk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=UxQlsdyfRWOEleuAgjr7mNTNTfQm1kN5OL3ePgV6pxCzf45PGPzlCfAnDz2LVOSIVSgKmq9BgJYotLwM2PvDni5E3Vib6kEWDEtZg29SxZ0J7Y0JycIayga6VHRNBxnNhiXfHQtSuvNf+3iPS1cwk4LDoGqr9lJPdnSpKcI4O0U=
Received: by 10.90.102.20 with SMTP id z20mr2462943agb.1186627689208;
        Wed, 08 Aug 2007 19:48:09 -0700 (PDT)
Received: from ?192.168.100.118? ( [71.246.233.117])
        by mx.google.com with ESMTPS id 39sm2006587agb.2007.08.08.19.48.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 08 Aug 2007 19:48:07 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.12 (Windows/20070509)
In-Reply-To: <7vps1xzic2.fsf_-_@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55403>

Junio C Hamano wrote:
> While "git bundle" was a useful way to sneakernet incremental
> changes, we did not allow:
>   
Thanks - I've been thinking for months I could fix this bug, never 
figured it out and didn't want to nag Dscho one more time. I confirm 
that this allows creation of bundles with arbitrary refs, not just those 
under refs/heads. Yahoo!

Mark
