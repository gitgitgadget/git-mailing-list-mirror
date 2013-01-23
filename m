From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv2 0/8] config key-parsing cleanups
Date: Tue, 22 Jan 2013 23:27:16 -0800
Message-ID: <20130123072716.GB3361@elie.Belkin>
References: <20130114145845.GA16497@sigill.intra.peff.net>
 <20130114150012.GA16828@sigill.intra.peff.net>
 <7v8v7veixc.fsf@alter.siamese.dyndns.org>
 <20130115160422.GC21815@sigill.intra.peff.net>
 <7vehhm4bof.fsf@alter.siamese.dyndns.org>
 <7va9s6qkkz.fsf@alter.siamese.dyndns.org>
 <20130123062132.GA2038@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Joachim Schmitz <jojo@schmitz-digital.de>,
	=?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 23 08:27:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxukK-0005xU-92
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 08:27:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753242Ab3AWH1W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 02:27:22 -0500
Received: from mail-pb0-f52.google.com ([209.85.160.52]:51801 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751885Ab3AWH1W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 02:27:22 -0500
Received: by mail-pb0-f52.google.com with SMTP id ro2so4477333pbb.11
        for <git@vger.kernel.org>; Tue, 22 Jan 2013 23:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=2pM7v226AwE5XZXmLDpf3pvXZ96OFY1LbpRmCHveZLc=;
        b=iWU9ewi+EqMpMnZ7uErHMJG3fSNCxUl1aSlEWf8v+o8Dd2PLGpmSmmU2If8TlOrTH4
         S3CP8cn6HxxtYMC1nQcrywlLh8yPtJBujsxt+UJ2g/nzRgEdZjSJJwReDO4QK4Dsk3Wr
         N+4gs2zuKY6EunA9W+G2ameZqvuxThXqSD77qh6MiogK2hseajFGXlxkRtM/HaB3AY3S
         yszW5Vy5OxWAH4ZnSlYrNmhCRIA7Oi5Hai85UWEovlP7vA5tgpx7SbCqynxi0/AHYenA
         wb0s2UBz5H5lrPL4DjY4fwEhhoJhCNv2H5p0I5llQbkV/N+5QMuoVDTqUFy1+zLDdVon
         rLjA==
X-Received: by 10.66.83.232 with SMTP id t8mr2007014pay.73.1358926041629;
        Tue, 22 Jan 2013 23:27:21 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id vq4sm12296433pbc.67.2013.01.22.23.27.19
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 22 Jan 2013 23:27:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130123062132.GA2038@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214295>

Jeff King wrote:

> So I've re-rolled the original version

Lovely. :)
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
