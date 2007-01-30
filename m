From: Jeff King <peff@peff.net>
Subject: Re: blameview and file line number
Date: Tue, 30 Jan 2007 09:06:50 -0500
Message-ID: <20070130140650.GB6949@coredump.intra.peff.net>
References: <cc723f590701292325k1c85d9edgb9e72ae380fcaad7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Aneesh Kumar <aneesh.kumar@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 30 15:07:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBtdX-0007vU-VZ
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 15:07:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965454AbXA3OGy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 09:06:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965394AbXA3OGy
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 09:06:54 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4792 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965454AbXA3OGx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 09:06:53 -0500
Received: (qmail 15951 invoked from network); 30 Jan 2007 09:07:17 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 30 Jan 2007 09:07:17 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Jan 2007 09:06:50 -0500
Content-Disposition: inline
In-Reply-To: <cc723f590701292325k1c85d9edgb9e72ae380fcaad7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38154>

On Tue, Jan 30, 2007 at 12:55:44PM +0530, Aneesh Kumar wrote:

> Is it a typo or intentional ? I found the blameview output confusing.

The original output was 0-based, so I suspect that line simply didn't
get updated when Junio changed the incremental format to be 1-based.

-Peff
