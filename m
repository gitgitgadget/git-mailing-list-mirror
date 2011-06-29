From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH/RFC] sideband: remove line padding (was: Re: [PATCH]
 progress: use \r as EOL only if isatty(stderr) is true)
Date: Wed, 29 Jun 2011 14:15:10 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1106291414140.2142@xanadu.home>
References: <1309272009-23076-1-git-send-email-sdaoden@gmail.com>
 <7vwrg5u7oz.fsf@alter.siamese.dyndns.org>
 <20110629174220.GA36658@sherwood.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
To: Steffen Daode Nurpmeso <sdaoden@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Jun 29 20:15:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbzIK-0005b0-Lq
	for gcvg-git-2@lo.gmane.org; Wed, 29 Jun 2011 20:15:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757531Ab1F2SPO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jun 2011 14:15:14 -0400
Received: from relais.videotron.ca ([24.201.245.36]:15617 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757309Ab1F2SPL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2011 14:15:11 -0400
Received: from xanadu.home ([66.130.28.92]) by vl-mh-mrz25.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LNK00COFD9J0Q20@vl-mh-mrz25.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 29 Jun 2011 14:12:56 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20110629174220.GA36658@sherwood.local>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176455>

On Wed, 29 Jun 2011, Steffen Daode Nurpmeso wrote:

> For formatting purposes recv_sideband() sofar appended a suffix to
> band #2 (informative) messages: dependent on getenv("TERM") lines
> may have been space-filled ("dumb") or padded with an ANSI escape
> sequence (ANSI EL, mode 0: clear from cursor to end of line).  This
> patch removes handling of terminal specifics and any pad suffixes.

Why?


Nicolas
