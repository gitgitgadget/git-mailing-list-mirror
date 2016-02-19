From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 13/21] fast-import: simplify allocation in start_packfile
Date: Fri, 19 Feb 2016 14:12:04 -0500
Message-ID: <20160219191204.GC777@sigill.intra.peff.net>
References: <20160219111941.GA31906@sigill.intra.peff.net>
 <20160219112449.GM9319@sigill.intra.peff.net>
 <xmqqio1kd20p.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 20:12:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWqTM-0000tG-VW
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 20:12:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1428448AbcBSTMI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 14:12:08 -0500
Received: from cloud.peff.net ([50.56.180.127]:45685 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030273AbcBSTMH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 14:12:07 -0500
Received: (qmail 9045 invoked by uid 102); 19 Feb 2016 19:12:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 Feb 2016 14:12:06 -0500
Received: (qmail 31523 invoked by uid 107); 19 Feb 2016 19:12:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 Feb 2016 14:12:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Feb 2016 14:12:04 -0500
Content-Disposition: inline
In-Reply-To: <xmqqio1kd20p.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286744>

On Fri, Feb 19, 2016 at 09:48:54AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > This function allocate a packed_git flex-array, and adds a
> 
> s/allocate/&s/, right?

Yes, thanks.

-Peff
