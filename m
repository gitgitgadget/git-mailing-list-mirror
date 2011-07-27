From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 02/18] config: Introduce functions to write non-standard
 file
Date: Tue, 26 Jul 2011 23:42:56 -0600
Message-ID: <20110727054256.GA28821@sigill.intra.peff.net>
References: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
 <1311736755-24205-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 27 07:43:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qlwte-0004VJ-9Q
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 07:43:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753156Ab1G0FnB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jul 2011 01:43:01 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37577
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752551Ab1G0Fm7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2011 01:42:59 -0400
Received: (qmail 27869 invoked by uid 107); 27 Jul 2011 05:43:29 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 27 Jul 2011 01:43:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Jul 2011 23:42:56 -0600
Content-Disposition: inline
In-Reply-To: <1311736755-24205-3-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177936>

On Wed, Jul 27, 2011 at 08:48:59AM +0530, Ramkumar Ramachandra wrote:

> Introduce two new functions corresponding to "git_config_set" and
> "git_config_set_multivar" to write a non-standard configuration file.
> Expose thse new functions in cache.h for other git programs to use.

Thanks, this one looks much nicer to me (though I also agree with
Jonathan's style micronit).

-Peff
