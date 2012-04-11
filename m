From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC v2] fast-import doc: cat-blob and ls responses need
 to be consumed quickly
Date: Wed, 11 Apr 2012 16:46:48 -0500
Message-ID: <20120411214648.GI4248@burratino>
References: <20120411143249.GA4140@burratino>
 <7v1ununtb2.fsf@alter.siamese.dyndns.org>
 <20120411171707.GD4248@burratino>
 <7vlim2kwcv.fsf@alter.siamese.dyndns.org>
 <20120411212501.GH4248@burratino>
 <7vobqyhs43.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Dmitry Ivankov <divanorama@gmail.com>,
	Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 23:47:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI5NY-0004j4-W8
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 23:47:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933320Ab2DKVq7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 17:46:59 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:47367 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933291Ab2DKVq7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 17:46:59 -0400
Received: by iagz16 with SMTP id z16so1816238iag.19
        for <git@vger.kernel.org>; Wed, 11 Apr 2012 14:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ERSN1C9xEMNrZ+iRLuzJ3BPSBMPwP1hIPWLlQixlIMI=;
        b=e7eBYOlT7J2Q1yQNFR/DpElMv/lSafOYHsREe5n99mJpdcymF4TNRnQ4aHX1uvbR1B
         ZLDnYwqd9WfB9mCDfKldfm1hXSaFsaAKucCmuiwjhuy8wTtlNnGLZmJ3hNmcNkaUn61h
         MUyBWqqHcgSwyjjqHfAgR2VPytPIAIswr4xf+/AwZVwjg3tmOtF/pbEEhi3Rej2z+9gJ
         mSTxyw/of4UQKE7DyQNKVtMo8UOSzlGmRw5jEVS27b7oVTb5+KoWeMfAJImh0/3uKDVT
         /9duojo9Bau+SO1L6SKJkvdcxy0hd+sPup88O2SgEeaHVoHlM0AG0UYuiAWPsJWP57oO
         gD6A==
Received: by 10.50.192.228 with SMTP id hj4mr7081864igc.65.1334180817668;
        Wed, 11 Apr 2012 14:46:57 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id xt2sm26637931igb.6.2012.04.11.14.46.56
        (version=SSLv3 cipher=OTHER);
        Wed, 11 Apr 2012 14:46:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vobqyhs43.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195269>

Junio C Hamano wrote:

> Looks good.  Do you want me to queue it, or would it be of not much use
> outside the context of the other patch that actually does create the
> loop-back?

Thanks.  It's useful for git versions v1.7.9.5~1^2~2 ("fast-import:
add 'ls' command") and newer.  I've pushed a copy of the patch to

  git://repo.or.cz/git/jrn.git fast-import
