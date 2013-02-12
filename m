From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Makefile: do not export mandir/htmldir/infodir
Date: Tue, 12 Feb 2013 15:16:51 -0800
Message-ID: <20130212231651.GI12240@google.com>
References: <cover.1360700102.git.john@keeping.me.uk>
 <20130212222508.GG12240@google.com>
 <7vmwv9ducx.fsf@alter.siamese.dyndns.org>
 <7vip5xdtt6.fsf@alter.siamese.dyndns.org>
 <7vehgldt8e.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	Steffen Prohaska <prohaska@zib.de>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 00:17:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5P6G-0006wp-3V
	for gcvg-git-2@plane.gmane.org; Wed, 13 Feb 2013 00:17:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758451Ab3BLXQ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 18:16:57 -0500
Received: from mail-da0-f52.google.com ([209.85.210.52]:43169 "EHLO
	mail-da0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756723Ab3BLXQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 18:16:56 -0500
Received: by mail-da0-f52.google.com with SMTP id f10so262312dak.39
        for <git@vger.kernel.org>; Tue, 12 Feb 2013 15:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=pd4PV+OfmIMLKyQUNCrQVswJbL8Pvj/SryiBWuVRBrw=;
        b=vPGWJg+TW47E0XiaHCf6g2Rg7dtMceUeXN+6TAU2cEtmq91eI2/s3dTSZN+xg/ctoP
         jSV33RL19h5uaMxYwMBR4uJisQeQ1k3BlwWmmhYuYuxN/0vrQAlUi0iz+ICXRIDYGER1
         BWGFaJhtM912u8F0s6+eEEXPmU0TP28KzUPXAbK6aH8jlPygQXhIinmnv00HNhsCtE43
         Q0uixxGEqcJl+N3KC2HOy39iD34372ebgVY4H+r/DaoT8TO7rNsB2LEJeUkWITpq4d32
         ppuyKm8ctFHicfv5k4tkvyhdb0i2DnDI/N04wamJWDggEnC9fkNuO/jeZ8FuGclkBXbj
         WbRA==
X-Received: by 10.67.22.33 with SMTP id hp1mr20124868pad.3.1360711016039;
        Tue, 12 Feb 2013 15:16:56 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id y9sm78419314paw.1.2013.02.12.15.16.53
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 12 Feb 2013 15:16:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vehgldt8e.fsf_-_@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216221>

Junio C Hamano wrote:

> These are defined in the main Makefile to be funny values that are
> optionally relative to an unspecified location that is determined at
> runtime.
[...]
> A longer term fix is to introduce runtime_{man,html,info}dir variables
> to hold these funny values, and make {man,html,info}dir variables
> to have real paths whose default values begin with $(prefix), but
> as a first step, stop exporting them from the top-level Makefile.

Makes sense.

Reported-by: John Keeping <john@keeping.me.uk>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
