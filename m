From: Jeff King <peff@peff.net>
Subject: [PATCH v5 0/2] reporting transport helper errors
Date: Wed, 10 Apr 2013 17:13:11 -0400
Message-ID: <20130410211311.GA24277@sigill.intra.peff.net>
References: <1365432004-20132-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 10 23:13:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ2Ka-0002ar-2f
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 23:13:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754605Ab3DJVNT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 17:13:19 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39215 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750975Ab3DJVNS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 17:13:18 -0400
Received: (qmail 7402 invoked by uid 107); 10 Apr 2013 21:15:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 10 Apr 2013 17:15:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Apr 2013 17:13:11 -0400
Content-Disposition: inline
In-Reply-To: <1365432004-20132-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220765>

I think this topic is close to being done, so I just wanted to move it
along.

  [1/2]: transport-helper: report errors properly

    This is Felipe's v4 patch with the adjustments I suggested in
    review. It explains more in the commit message, and should fix
    Thomas's valgrind failures (it consumes fast-export's data before
    dying rather than sleeping and hoping that fast-export is done
    writing).

  [2/2]: transport-helper: mention helper name when it dies

    This changes the error message, to help with the issue raised by
    Sverre.

-Peff
