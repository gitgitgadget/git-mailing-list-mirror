From: Charles Bailey <charles@hashpling.org>
Subject: Re: [RFC/PATCH] Teach git mergetool to use custom commands defined at config time
Date: Sun, 17 Feb 2008 23:41:50 +0000
Message-ID: <20080217234150.GB6249@hashpling.org>
References: <20080216185349.GA29177@hashpling.org> <CD749541-1B3B-4EA7-82A5-0DFC67B953BE@zib.de> <20080217002029.GA504@hashpling.org> <alpine.LSU.1.00.0802170045210.30505@racer.site> <20080217005620.GB504@hashpling.org> <7vbq6g758h.fsf@gitster.siamese.dyndns.org> <FBA2E61E-5CAF-49E3-A917-ACDD10586928@zib.de> <20080217214942.GJ8905@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Theodore Tso <tytso@MIT.EDU>
X-From: git-owner@vger.kernel.org Mon Feb 18 00:42:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQt9q-0002Gf-2t
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 00:42:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755159AbYBQXmT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 18:42:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755161AbYBQXmT
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 18:42:19 -0500
Received: from pih-relay08.plus.net ([212.159.14.134]:53562 "EHLO
	pih-relay08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755159AbYBQXmT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 18:42:19 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay08.plus.net with esmtp (Exim) id 1JQt8u-0005ek-S5; Sun, 17 Feb 2008 23:41:57 +0000
Received: from fermat.hashpling.org (fermat.hashpling.org [127.0.0.1])
	by hashpling.plus.com (8.13.8/8.13.6) with ESMTP id m1HNfpXS007273;
	Sun, 17 Feb 2008 23:41:51 GMT
Received: (from charles@localhost)
	by fermat.hashpling.org (8.13.8/8.13.6/Submit) id m1HNfoZU007272;
	Sun, 17 Feb 2008 23:41:50 GMT
Content-Disposition: inline
In-Reply-To: <20080217214942.GJ8905@mit.edu>
User-Agent: Mutt/1.4.2.1i
X-Plusnet-Relay: 0bdf232e3295be55d0541da28376d4c2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74206>

On Sun, Feb 17, 2008 at 04:49:42PM -0500, Theodore Tso wrote:
> I have no objection to a generic mechanism, but I don't see the value
> of Charles suggestion to rip out support for the existing tools
> supported by git-mergetool.

Apologies for the multiple replies, I just remembered that I didn't
comment on this part.

My suggestion was really just me thinking aloud ("one idea I had...").
I was only stating that it would be possible to do this, there's no
value in actually doing this on its own, but the thought exercise
helped me validate my patch (at least to myself). If my patch were
flexible enough to handle all of the current built-in tools in a
generic fashion then it is a good sign that it should be able to cope
with a good portion of (as yet) unknown merge tools which is, after
all, the main point of my patch.

Charles.
