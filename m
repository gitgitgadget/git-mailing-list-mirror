From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 00/14] Clean up how fetch_pack() handles the heads list
Date: Sun, 9 Sep 2012 09:05:33 -0400
Message-ID: <20120909130532.GA27754@sigill.intra.peff.net>
References: <1347171589-13327-1-git-send-email-mhagger@alum.mit.edu>
 <7v7gs3sdjx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 09 15:05:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAhCv-0007ft-VY
	for gcvg-git-2@plane.gmane.org; Sun, 09 Sep 2012 15:05:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515Ab2IINFm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Sep 2012 09:05:42 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:38507 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751332Ab2IINFl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Sep 2012 09:05:41 -0400
Received: (qmail 19819 invoked by uid 107); 9 Sep 2012 13:06:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 09 Sep 2012 09:06:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 09 Sep 2012 09:05:33 -0400
Content-Disposition: inline
In-Reply-To: <7v7gs3sdjx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205076>

On Sun, Sep 09, 2012 at 03:20:18AM -0700, Junio C Hamano wrote:

> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
> > This patch series depends on the "Add some string_list-related
> > functions" series that I just submitted.
> 
> Makes sense.  The only worry (without reading the series first) I
> have is that the use of string list may make the responsiblity of
> sorting the list fuzzier. I am guessing that we never sorted the
> refs we asked to fetch (so that FETCH_HEAD comes out in an expected
> order), so use of unsorted string list would be perfectly fine.

I haven't read the series yet, but both the list of heads from the user
and the list of heads from the remote should have been sorted by 4435968
and 9e8e704f, respectively.

-Peff
