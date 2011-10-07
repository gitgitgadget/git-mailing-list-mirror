From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] fmt-merge-msg: use branch.$name.description
Date: Fri, 7 Oct 2011 04:16:36 -0500
Message-ID: <20111007091636.GA22822@elie.hsd1.il.comcast.net>
References: <7vobxtwaog.fsf@alter.siamese.dyndns.org>
 <4E8EBDA7.2040007@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Oct 07 11:16:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RC6Y1-0002fn-DB
	for gcvg-git-2@lo.gmane.org; Fri, 07 Oct 2011 11:16:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759622Ab1JGJQs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Oct 2011 05:16:48 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:50967 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751970Ab1JGJQr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2011 05:16:47 -0400
Received: by iakk32 with SMTP id k32so3989864iak.19
        for <git@vger.kernel.org>; Fri, 07 Oct 2011 02:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=fAAbNrgqGv3zJWKCz5grMG3dxDijAZJcsWMElEwYhyo=;
        b=i0X+jJPhqmk/YtoNNxFg9pmFaNI3kHY73OvBvLxfjdXBr5VQ1abtjCAh+OhGAgshBx
         h11Z61GYmDGncOM6m9pE8e6tEVwcUAqEx/yMD/eV4TPcA8FSJ9h9Hm3XZ5M3/mchjaXi
         +bGL23KqcYw+6NEZlNUj/MJWgTNVi24nqu2R4=
Received: by 10.43.52.136 with SMTP id vm8mr11149654icb.26.1317979007017;
        Fri, 07 Oct 2011 02:16:47 -0700 (PDT)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id 2sm18545781ibf.0.2011.10.07.02.16.46
        (version=SSLv3 cipher=OTHER);
        Fri, 07 Oct 2011 02:16:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4E8EBDA7.2040007@drmicha.warpmail.net>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183071>

Michael J Gruber wrote:

> config based is so non-distributed, local in nature.

I don't follow.  Wouldn't a protocol change be enough to fix that, by
sharing branch descriptions analagously to how refs themselves are
shared?
