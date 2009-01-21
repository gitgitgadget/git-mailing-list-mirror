From: Charles Bailey <charles@hashpling.org>
Subject: Re: feature request mergetool, skip, abort
Date: Wed, 21 Jan 2009 11:22:36 +0000
Message-ID: <20090121112236.GC18488@hashpling.org>
References: <81bfc67a0901200839q361923f1xb25ddadfdac37981@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Caleb Cushing <xenoterracide@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 12:56:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPbgd-0007HT-HH
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 12:55:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757715AbZAULyf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 06:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757515AbZAULye
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 06:54:34 -0500
Received: from fhw-relay07.plus.net ([212.159.14.148]:46292 "EHLO
	fhw-relay07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756180AbZAULye (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 06:54:34 -0500
X-Greylist: delayed 1914 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Jan 2009 06:54:34 EST
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by fhw-relay07.plus.net with esmtp (Exim) id 1LPbAM-0000Hq-42; Wed, 21 Jan 2009 11:22:38 +0000
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id n0LBMbTY020531
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 21 Jan 2009 11:22:37 GMT
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id n0LBMavw020530;
	Wed, 21 Jan 2009 11:22:36 GMT
Content-Disposition: inline
In-Reply-To: <81bfc67a0901200839q361923f1xb25ddadfdac37981@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Plusnet-Relay: 6a4f9ee431a750fa17979fa5bf1c0287
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106596>

On Tue, Jan 20, 2009 at 11:39:59AM -0500, Caleb Cushing wrote:
> firstly my patch sucks, and I know it. but hopefully it'll give some
> idea of what I'm trying to do and someone can implement it properly.
> 
> basically there are some files, that I can't merge with git, but I
> need to merge other files before I can fix those and I like to use
> mergetool, so I want a way to skip the files I'm not going to be able
> to merge.
> 

For some reason I couldn't see a patch, but I like the idea of this
from the description and I was at very early stage of working on
something similar myself but it stalled due to other commitments.

For the moment the only way to 'skip' files is by passing full paths
of what you *don't* want to skip to mergetool which isn't really the
same thing at all.

-- 
Charles Bailey
http://ccgi.hashpling.plus.com/blog/
