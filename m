From: Anders Kaseorg <andersk@MIT.EDU>
Subject: Re: [PATCH] Quote ' as \(aq in manpages
Date: Wed, 21 Oct 2009 14:01:11 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.0910211357160.5105@dr-wily.mit.edu>
References: <200910151402.56295.trast@student.ethz.ch> <ab31eb03b25272341b91e1f1132dab9d8a49e5b6.1256113282.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Oct 21 20:02:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0fVz-0003OE-2P
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 20:02:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754545AbZJUSCQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 14:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754530AbZJUSCQ
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 14:02:16 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:47950 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753628AbZJUSCP (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Oct 2009 14:02:15 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id n9LI14n7014119;
	Wed, 21 Oct 2009 14:01:05 -0400 (EDT)
Received: from localhost (LINERVA.MIT.EDU [18.181.0.232])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id n9LI1DVQ028808;
	Wed, 21 Oct 2009 14:01:14 -0400 (EDT)
In-Reply-To: <ab31eb03b25272341b91e1f1132dab9d8a49e5b6.1256113282.git.trast@student.ethz.ch>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130946>

On Wed, 21 Oct 2009, Thomas Rast wrote:
> The docbook/xmlto toolchain insists on quoting ' as \'.  This does
> achieve the quoting goal, but modern 'man' implementations turn the
> apostrophe into a unicode "proper" apostrophe (given the right
> circumstances), breaking code examples in many of our manpages.
> 
> Quote them as \(aq instead, which is an "apostrophe quote" as per the
> groff_char manpage.

\(aq is not portable to non-GNU roff.  See
  http://bugs.debian.org/507673#65
  http://sourceforge.net/tracker/index.php?func=detail&aid=2412738&group_id=21935&atid=373747
for a proposed portable solution.

Anders
