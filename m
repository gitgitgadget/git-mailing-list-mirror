From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] t/test-lib.sh: Let test_must_fail fail on signals
	only
Date: Wed, 16 Jul 2008 01:18:29 -0400
Message-ID: <20080716051829.GB4030@segfault.peff.net>
References: <1215877672-17049-1-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Wed Jul 16 07:19:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIzQI-0004UW-Dr
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 07:19:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751649AbYGPFSb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 01:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751637AbYGPFSb
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 01:18:31 -0400
Received: from peff.net ([208.65.91.99]:2246 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751592AbYGPFSa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 01:18:30 -0400
Received: (qmail 4340 invoked by uid 1000); 16 Jul 2008 05:18:29 -0000
Content-Disposition: inline
In-Reply-To: <1215877672-17049-1-git-send-email-s-beyer@gmx.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88637>

On Sat, Jul 12, 2008 at 05:47:51PM +0200, Stephan Beyer wrote:

> The test_must_fail function in test-lib.sh has been designed
> to distinguish segmentation faults from controlled errors.
> But in the current implementation this only works if a git
> command does not return a small negative value, like -1, -2
> or -3. But some git commands do.

This is probably a fine protective measure, and it looks like Junio has
already applied it. But shouldn't any git commands returning such values
be fixed? Which commands return such bogus error codes?

-Peff
