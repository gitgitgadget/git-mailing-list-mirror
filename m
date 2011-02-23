From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/6] fetch/pull: Add the 'on-demand' value to the
 --recurse-submodules option
Date: Wed, 23 Feb 2011 17:14:30 -0600
Message-ID: <20110223231430.GD6819@elie>
References: <4D656F25.5090007@web.de>
 <4D656F77.7060306@web.de>
 <20110223231210.GC6819@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Kevin Ballard <kevin@sb.org>, Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Feb 24 00:14:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsNut-00076v-Cg
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 00:14:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753126Ab1BWXOh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 18:14:37 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:53785 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752735Ab1BWXOg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Feb 2011 18:14:36 -0500
Received: by vws12 with SMTP id 12so3578631vws.19
        for <git@vger.kernel.org>; Wed, 23 Feb 2011 15:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=zX5mWcAGH8vp47NIhoVSHe2bCPeJ8TAk2LkPsjjoeKI=;
        b=sNu/vjDBAivkdvYZRX9X/grKwln5gCZcPoReaKLiRvSK4V4A36/ceK3lhpIWzztfNx
         cgwV72bO8rHWwmAPtkHcf5xcRA2bYWkc54sXX0U+htGBh6CePNIZ/OXsJWccLC8NEXe/
         tMcvP/G/Id7+HnNTnp6kJem5jCpeFoxunDjy4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=I7YrPwFhOXbGB8gu3bxQTDCJWp4JjIUYt0iUoFdv3VFk05iT3Iel6T/J4gyNxPO2ol
         08ZZLKM5/g6c4G/0ghyeL4Sl3kNGkMXd5jWaeyb30XfiOQvMtsbOA/z5lgrWHB4v54QM
         Sx8QpOxBv3gtxl5ZuP+O/PDSs3xX/6ceWX0c8=
Received: by 10.52.166.1 with SMTP id zc1mr265218vdb.14.1298502875478;
        Wed, 23 Feb 2011 15:14:35 -0800 (PST)
Received: from elie (adsl-69-209-53-52.dsl.chcgil.ameritech.net [69.209.53.52])
        by mx.google.com with ESMTPS id a6sm3851291vcm.22.2011.02.23.15.14.33
        (version=SSLv3 cipher=OTHER);
        Wed, 23 Feb 2011 15:14:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110223231210.GC6819@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167736>

Jonathan Nieder wrote:
> Jens Lehmann wrote:

>>             As fetch and pull now by default just fetch those submodules
>> for which new commits have been fetched in the superproject, a command
>> line option to enforce that behavior is needed to be able to override
>> configuration settings.
>
> Probably this should go first in the series (the usual procedure:
> first command line for easy testing, then configuration for routine
> use, then defaults).

Ah, sorry for the nonsense.  The series already follows that order.
