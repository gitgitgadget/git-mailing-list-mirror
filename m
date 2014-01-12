From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH] git-p4: Do not include diff in spec file when just
 preparing p4
Date: Sun, 12 Jan 2014 17:29:46 -0500
Message-ID: <20140112222946.GA13519@padd.com>
References: <20140110181807.GA29164@nekage>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Maxime Coste <frrrwww@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 12 23:39:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W2Th8-0000v6-Eo
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jan 2014 23:39:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbaALWjr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jan 2014 17:39:47 -0500
Received: from honk.padd.com ([74.3.171.149]:36664 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750899AbaALWjp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jan 2014 17:39:45 -0500
X-Greylist: delayed 594 seconds by postgrey-1.27 at vger.kernel.org; Sun, 12 Jan 2014 17:39:45 EST
Received: from arf.padd.com (unknown [50.105.0.78])
	by honk.padd.com (Postfix) with ESMTPSA id 3BC2270F4;
	Sun, 12 Jan 2014 14:29:50 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 7FC6C202AD; Sun, 12 Jan 2014 17:29:46 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20140110181807.GA29164@nekage>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240353>

frrrwww@gmail.com wrote on Fri, 10 Jan 2014 18:18 +0000:
> The diff information render the spec file unusable as is by p4,
> do not include it when run with --prepare-p4-only so that the
> given file can be directly passed to p4.

Thanks for the patch, but I'm curious how you'd like this to
work.  I never use the option myself.

As it is, --prepare-p4-only generates a file in /tmp/ that has
exactly the contents you'd see in the editor during "git p4
submit".  It includes the diff of the change, presumably to help
with writing the description.

Now you can't actually feed this file directly to "p4 submit"
without deleting the diff.  That's the part you don't like?

		-- Pete
