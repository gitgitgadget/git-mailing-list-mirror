From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/3] gpg: Allow translation of more error messages
Date: Thu, 31 Jan 2013 10:20:52 -0800
Message-ID: <20130131182052.GA27340@google.com>
References: <1359597666-10108-1-git-send-email-sboyd@codeaurora.org>
 <1359597666-10108-4-git-send-email-sboyd@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
X-From: git-owner@vger.kernel.org Thu Jan 31 19:21:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0ylM-0003yL-0k
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 19:21:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754987Ab3AaSVG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 13:21:06 -0500
Received: from mail-pb0-f52.google.com ([209.85.160.52]:60304 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752122Ab3AaSVE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 13:21:04 -0500
Received: by mail-pb0-f52.google.com with SMTP id mc8so985033pbc.39
        for <git@vger.kernel.org>; Thu, 31 Jan 2013 10:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=R7+eaY5/dRcW9bPQcwf2UAjbBti/dcF0gw85KPhruTs=;
        b=T/ev5Y/UTFLOSXGMc+/6cUJpObvEjKwESJAayMZ9vN34nZlzi5vS56GJcgSxB+O+IO
         S1ugyjts1iNp4jbfb/fHBnvB4lBsVqgk+SyxD8Cvm3u8wAyj8+jmVM7YR5opkPrGRWLx
         geC0ofHY+RJ8wKflqXtJ9zd61zOaeWmHrni8qSBwN3sOyLU4S/ZTunCdyeu+OErgBNnM
         I++K2cdbGj4kATJbHb4pm28PrzZ7MYl2HIuVSeOk/Crr2OfxGFZ71xfP482pOUmjeINo
         p7eKChRsDyc07flz1cG3c+p/ILsQq2+X8p6XVPqpPcFMSU6rnU63YH/JPdNp0lYj3OGx
         slqQ==
X-Received: by 10.68.134.228 with SMTP id pn4mr24695270pbb.31.1359656463748;
        Thu, 31 Jan 2013 10:21:03 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id i5sm6286103pax.13.2013.01.31.10.21.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 31 Jan 2013 10:21:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1359597666-10108-4-git-send-email-sboyd@codeaurora.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215140>

Stephen Boyd wrote:

> Mark these strings for translation so that error messages are
> printed in the user's language of choice.

Yeah.  Other error messages in this file are already translated, so
it's oddly inconsistent.

Assuming this passes tests with GETTEXT_POISON=YesPlease,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
