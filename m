From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 00/18] GSoC update: Sequencer for inclusion v3
Date: Thu, 28 Jul 2011 18:39:20 +0200
Message-ID: <20110728163919.GA3155@elie.dc0b.debconf.org>
References: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
 <7vfwlrmisu.fsf@alter.siamese.dyndns.org>
 <CALkWK0kWtdHD2JF+sP8ox96jPncZagQpHzu3vvggyEFO3D2ryw@mail.gmail.com>
 <CALkWK0=d_JEy=24Sqg7Np12wsV754kbw_ejpFJsKttDc4t2g1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 28 18:39:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmTcU-0002cu-2M
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 18:39:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755217Ab1G1Qja (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 12:39:30 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39491 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754906Ab1G1Qj2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 12:39:28 -0400
Received: by fxh19 with SMTP id 19so1422002fxh.19
        for <git@vger.kernel.org>; Thu, 28 Jul 2011 09:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=c1qrNtYj8ImIBipi+hxCF7FK2ckRmcqsUVq4oZQ7s8g=;
        b=SK5BSPFKCR4f6cWO0xysLgmoP40YgZqw4TO8MMgzgnENyeB/NC2Opv2y46amzp0a89
         uRz+hTuyMbPTpDItiUho6Q3RUQ6JCgnE0PON71OOvKIWj51yFXDvBBrsog/ePC8Iqa50
         335JgBB6yRStT2ym4+xCVOBcxAwDmJGSqDHQA=
Received: by 10.223.159.8 with SMTP id h8mr311934fax.3.1311871167684;
        Thu, 28 Jul 2011 09:39:27 -0700 (PDT)
Received: from elie.dc0b.debconf.org ([78.28.140.4])
        by mx.google.com with ESMTPS id c28sm574645fam.16.2011.07.28.09.39.25
        (version=SSLv3 cipher=OTHER);
        Thu, 28 Jul 2011 09:39:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0=d_JEy=24Sqg7Np12wsV754kbw_ejpFJsKttDc4t2g1Q@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178078>

Ramkumar Ramachandra wrote:

> Um, one more thing.  I've also decided to let Jonathan's commit
> signoff-factoring patch [1] wait until the next series.
>
> [1]: https://github.com/artagnon/git/commit/0494a

Sure, I don't think it belongs in the series at all fwiw --- it can
migrate to master independently.  It was mostly a way to deter a
non-sequitor in the commit message. :)
