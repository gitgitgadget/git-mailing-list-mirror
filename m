From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/8] fast-import: cache oe more often
Date: Mon, 19 Sep 2011 23:26:56 -0500
Message-ID: <20110920042655.GH6343@elie>
References: <1316395657-6991-1-git-send-email-divanorama@gmail.com>
 <7vy5xj7tf5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 20 06:33:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5s1M-0005A4-Hi
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 06:33:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452Ab1ITEdT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Sep 2011 00:33:19 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:61149 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013Ab1ITEdP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2011 00:33:15 -0400
Received: by gxk6 with SMTP id 6so85976gxk.19
        for <git@vger.kernel.org>; Mon, 19 Sep 2011 21:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=fdHZcCPWwkG3y6k0FS0p64J03Ro0a80mEEtCDbfzchw=;
        b=IN/TCuYon8BrbLGXSqGtIH6bcnm/QFdjMZZEWejOodZ6s9J+xFw5aIMrDsNgH4bhR4
         UBMvEiZseuZptLlNINfXPTatX0WKxsl0dZKJmDA+oupJBPzgApJilUNFB+l4+2tka07s
         qAvYk95jrCKRg7zkZJ9Cu0shffLfZdO96ymGA=
Received: by 10.146.192.28 with SMTP id p28mr2937449yaf.35.1316492821627;
        Mon, 19 Sep 2011 21:27:01 -0700 (PDT)
Received: from elie (99-120-124-35.lightspeed.cicril.sbcglobal.net. [99.120.124.35])
        by mx.google.com with ESMTPS id k12sm7877136anc.19.2011.09.19.21.26.58
        (version=SSLv3 cipher=OTHER);
        Mon, 19 Sep 2011 21:26:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vy5xj7tf5.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181731>

Junio C Hamano wrote:

> I gave the series a cursory look, and the patches all looked like a good
> and straight forward rewrites.  Provided if it is indeed a good idea
> overall to stuff more objects in-core, that is.

Right, that's exactly the question I had.  When and why is it a good
idea to stuff more objects in-core (or when might it be a bad idea,
for that matter)?
