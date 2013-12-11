From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] cat-file: pass expand_data to print_object_or_die
Date: Wed, 11 Dec 2013 12:11:12 -0800
Message-ID: <20131211201112.GM2311@google.com>
References: <20131211115458.GA10561@sigill.intra.peff.net>
 <20131211115642.GA10594@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Samuel Bronson <naesten@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 11 21:11:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vqq7t-00078j-Nk
	for gcvg-git-2@plane.gmane.org; Wed, 11 Dec 2013 21:11:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510Ab3LKULT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Dec 2013 15:11:19 -0500
Received: from mail-yh0-f50.google.com ([209.85.213.50]:34091 "EHLO
	mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751222Ab3LKULR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Dec 2013 15:11:17 -0500
Received: by mail-yh0-f50.google.com with SMTP id b6so5568076yha.37
        for <git@vger.kernel.org>; Wed, 11 Dec 2013 12:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=eoIEGDOAeHNBn4qJTG3cg5AWwjQQv5oPJNAX0jHhVRA=;
        b=u2CDMIGGpepIC9BIv9cEGOBgEaMqFMQ1nFtfu5x4qAUzT4H9UraikSNm/BgoY+bu3e
         CWfITRMmrCFclGSCdxxLvkDwT3nX8hjmZHd5z9E671JIxblkfIQVQmAVmPP99yQ4wlEH
         kDFmxzwYA8AGEzivlAOg92gzYHRfOKt3Uk/j8slHljmkUj5xX6DcQvBxojzM+XzMhakA
         SrtZk0SgOuDNUe3Is0c3Y6PnwUYF65Zgaf7IthrfzpgSBIcf7iGjszOgStjZIM7ckcHY
         7zADT+umZoSmb0reyAiy1nE70u1MrJtJPcEB2o687HvofAX4VTN7pJ61s2bzZnlV+8UF
         yHZQ==
X-Received: by 10.236.158.226 with SMTP id q62mr2909271yhk.2.1386792676074;
        Wed, 11 Dec 2013 12:11:16 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id o27sm30034949yhb.19.2013.12.11.12.11.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 11 Dec 2013 12:11:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131211115642.GA10594@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239210>

Hi,

Jeff King wrote:

>                                        However, if we pass
> the whole struct, the called function can make more
> intelligent decisions about which fields were actualled
> filled by sha1_object_info.

Thanks.

s/actualled/actually/, I think.

At first I thought this patch was going to be about making those
intelligent decisions.  Maybe s/the called function can/a future patch
can teach the called function/ or something?

[...]
> There should be no functional change to this patch.

The patch itself looks straightforward, yep. :)

With the typofix mentioned above,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
