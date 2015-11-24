From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2] git-p4: clean up after p4 submit failure
Date: Tue, 24 Nov 2015 16:18:27 -0500
Message-ID: <20151124211827.GA29185@sigill.intra.peff.net>
References: <1448351039-15625-1-git-send-email-luke@diamand.org>
 <1448351039-15625-2-git-send-email-luke@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, sunshine@sunshineco.com,
	Junio C Hamano <gitster@pobox.com>, egirard@murex.com,
	larsxschneider@gmail.com
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Tue Nov 24 22:18:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1Kyu-0001fH-QW
	for gcvg-git-2@plane.gmane.org; Tue, 24 Nov 2015 22:18:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754479AbbKXVSa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2015 16:18:30 -0500
Received: from cloud.peff.net ([50.56.180.127]:33430 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754127AbbKXVSa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2015 16:18:30 -0500
Received: (qmail 23585 invoked by uid 102); 24 Nov 2015 21:18:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Nov 2015 15:18:29 -0600
Received: (qmail 18351 invoked by uid 107); 24 Nov 2015 21:18:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Nov 2015 16:18:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Nov 2015 16:18:27 -0500
Content-Disposition: inline
In-Reply-To: <1448351039-15625-2-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281632>

On Tue, Nov 24, 2015 at 07:43:59AM +0000, Luke Diamand wrote:

> From: GIRARD Etienne <egirard@murex.com>
> 
> When "p4 submit" command fails in P4Submit.applyCommit, the
> workspace is left with the changes.  We already have code to revert
> the changes to the workspace when the user decides to cancel
> submission by aborting the editor that edits the change description,
> and we should treat the "p4 submit" failure the same way.
> 
> Clean the workspace if p4_write_pipe raised SystemExit, so that the
> user don't have to do it themselves.
> 
> Signed-off-by: GIRARD Etienne <egirard@murex.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Luke Diamand <luke@diamand.org>
> ---

Thanks, I think this should be ready for 'next', then.

-Peff
