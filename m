From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] transport-helper: improve push messages
Date: Wed, 10 Apr 2013 23:41:02 -0400
Message-ID: <20130411034102.GD14551@sigill.intra.peff.net>
References: <1365638832-9000-1-git-send-email-felipe.contreras@gmail.com>
 <1365638832-9000-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 11 05:41:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ8Nv-0003mL-35
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 05:41:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934898Ab3DKDlK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 23:41:10 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39647 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758624Ab3DKDlJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 23:41:09 -0400
Received: (qmail 11295 invoked by uid 107); 11 Apr 2013 03:43:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 10 Apr 2013 23:43:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Apr 2013 23:41:02 -0400
Content-Disposition: inline
In-Reply-To: <1365638832-9000-2-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220814>

On Wed, Apr 10, 2013 at 07:07:11PM -0500, Felipe Contreras wrote:

> If there's already a remote-helper tracking ref, we can fetch the SHA-1
> to report proper push messages (as opposed to always reporting
> [new branch]).
> 
> The remote-helper currently can specify the old SHA-1 to avoid this
> problem, but there's no point in forcing all remote-helpers to be aware
> of git commit ids; they should be able to be agnostic of them.
> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>

Yeah, this looks correct to me. Thanks.

-Peff
