From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Do check_repository_format() early
Date: Wed, 28 Nov 2007 18:11:17 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711281810410.27959@racer.site>
References: <20071128165837.GA5903@laptop>  <Pine.LNX.4.64.0711281703470.27959@racer.site>
  <fcaeb9bf0711280910x40fecdd5mf6d86e4a9b656d01@mail.gmail.com> 
 <Pine.LNX.4.64.0711281717460.27959@racer.site>
 <fcaeb9bf0711280924v34160eddsf8a75f8f8cee389c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 19:12:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxROS-0001LQ-JE
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 19:12:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752406AbXK1SL2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 13:11:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752308AbXK1SL2
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 13:11:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:58803 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752154AbXK1SL1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 13:11:27 -0500
Received: (qmail invoked by alias); 28 Nov 2007 18:11:25 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp057) with SMTP; 28 Nov 2007 19:11:25 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19GnrsgUKVGNgm/CPKu79kq2QBtJOP/Xk34gRPMN6
	W0oD6HIKBnJEYg
X-X-Sender: gene099@racer.site
In-Reply-To: <fcaeb9bf0711280924v34160eddsf8a75f8f8cee389c@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66395>

Hi,

On Thu, 29 Nov 2007, Nguyen Thai Ngoc Duy wrote:

> The comment is clearly not clear enough. Maybe this?
> 
> +                     if (!work_tree_env) {
> +                             retval = set_work_tree(gitdirenv);
> +                             /* config may override worktree (see
> set_work_tree comment) */
> +                             check_repository_format();
> +                             return retval;
> +                     }

Perfect.  Please make it so, and add my ACK.

Thanks,
Dscho
