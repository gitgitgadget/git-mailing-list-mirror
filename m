From: Jeff King <peff@peff.net>
Subject: [RFC/PATCH 0/5] branch --set-upstream-to error-message improvements
Date: Tue, 2 Apr 2013 15:01:34 -0400
Message-ID: <20130402190134.GA17784@sigill.intra.peff.net>
References: <F58991CB-9C83-4DA6-B82B-2E6C874C30EB@gmail.com>
 <20130402172333.GB24698@sigill.intra.peff.net>
 <A4C40BCB-85DD-4BCB-8BF0-79A75DE73211@gmail.com>
 <20130402175113.GD24698@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Garrett Cooper <yaneurabeya@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 21:02:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN6TA-00051p-Dl
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 21:02:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761509Ab3DBTBj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 15:01:39 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:52461 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760633Ab3DBTBj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 15:01:39 -0400
Received: (qmail 12447 invoked by uid 107); 2 Apr 2013 19:03:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 02 Apr 2013 15:03:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Apr 2013 15:01:34 -0400
Content-Disposition: inline
In-Reply-To: <20130402175113.GD24698@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219828>

On Tue, Apr 02, 2013 at 01:51:13PM -0400, Jeff King wrote:

> Things slowly improve as people make suggestions. I think the thing that
> might have helped here is better advice when "set-upstream-to" is
> pointed to a ref that does not exist.
> 
> Patches coming in a minute.

Or 60 minutes. :)

I'm not decided on whether the last patch is overkill or not (or even if
it is not, whether it may end up confusing people who do not fit into
one of the slots it suggests).

  [1/5]: t3200: test --set-upstream-to with bogus refs
  [2/5]: branch: factor out "upstream is not a branch" error messages
  [3/5]: branch: improve error message for missing --set-upstream-to ref
  [4/5]: branch: mention start_name in set-upstream error messages
  [5/5]: branch: give advice when tracking start-point is missing

-Peff
