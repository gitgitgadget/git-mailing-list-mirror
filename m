From: Andreas Krey <a.krey@gmx.de>
Subject: Re: git-push segfault
Date: Wed, 24 Feb 2010 09:22:14 +0100
Message-ID: <20100224082214.GA31559@inner.home.ulmdo.de>
References: <loom.20100224T043557-954@post.gmane.org> <20100224063606.GB12796@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dale Rowley <ddrowley3@juno.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 24 09:26:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkCZl-0005lG-QM
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 09:26:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754722Ab0BXIW2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 03:22:28 -0500
Received: from continuum.iocl.org ([213.146.114.200]:63546 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752416Ab0BXIW1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 03:22:27 -0500
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id o1O8MEL32455;
	Wed, 24 Feb 2010 09:22:14 +0100
Content-Disposition: inline
In-Reply-To: <20100224063606.GB12796@coredump.intra.peff.net>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140919>

On Wed, 24 Feb 2010 01:36:06 +0000, Jeff King wrote:
...
> #!/bin/sh
...
> git clone parent child &&
> cd child &&

How about 'set -xe' instead of all the &&?

Andreas
