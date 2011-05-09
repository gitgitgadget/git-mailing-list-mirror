From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4 (for maint)] git-completion: fix zsh support
Date: Mon, 9 May 2011 18:35:06 -0500
Message-ID: <20110509233506.GC23781@elie>
References: <BANLkTikkhryMa69DSx4EAYjw+aar4icKcQ@mail.gmail.com>
 <1304979299-6496-1-git-send-email-felipe.contreras@gmail.com>
 <20110509225307.GG22908@elie>
 <7v1v07o3rs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 10 01:35:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJZz1-0007KR-ER
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 01:35:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755129Ab1EIXfR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2011 19:35:17 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:45109 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753458Ab1EIXfP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 19:35:15 -0400
Received: by yia27 with SMTP id 27so1981865yia.19
        for <git@vger.kernel.org>; Mon, 09 May 2011 16:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=UTEtinAlqr7/WdgspGnoZaaTA3P0b+7QdMpZ2IaSeqE=;
        b=gc+IYQF7ZKPub9EJ58+KFH4HKFKiddnFOFB7/jCxMQSoLEUrMbzamjG2iYhy8tnSFM
         /LDjOqw6tU+aaw8T7IeYyH/RV+bsgBUNGgsBjXQ6XlkDPQm7TBwqA+dgIrUFEiH45NIX
         2dwQKVp4YOLRsYX+ylzxKH7OLivHMuEqsgVUc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=xFNGA/YJgS/a3SlS7EbO27WQ8BTt4nMx/Bn7DuejKse1DDAA12bLjOGDgI4Ci5tKTq
         5AvkPYKm20aHG3v74M48kYyfwW1MO0N5QMC5Z7pRNpI2hYvFOLf+qf9mdgpU5I0LfpTe
         lUSSR5/NZLHvmHI6UfDBj2XHbsX9YEYGRAj9g=
Received: by 10.236.187.5 with SMTP id x5mr8600143yhm.255.1304984115310;
        Mon, 09 May 2011 16:35:15 -0700 (PDT)
Received: from elie (adsl-68-255-107-251.dsl.chcgil.sbcglobal.net [68.255.107.251])
        by mx.google.com with ESMTPS id x75sm180975yhn.24.2011.05.09.16.35.13
        (version=SSLv3 cipher=OTHER);
        Mon, 09 May 2011 16:35:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v1v07o3rs.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173290>

Junio C Hamano wrote:

> One big thing going for this patch is that this is the blessed solution
> zsh folks themselves like to use, no? The repeated mention "zsh bashinit
> bug" in the code seems to suggest that it is the case.
>
> I do not mind reverting sg/completion-updates from 'next' (please remind
> me that I need to resurrect your "private shopt shim" separately if we go
> this route) and applying a cleaned-up version of this one.

Thanks, will spend some time later today to do so.

> Thanks.

Sorry for all the noise.  I wish I knew a way to work on patches like
this one without causing so much animosity.
