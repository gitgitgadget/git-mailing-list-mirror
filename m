From: Jeff King <peff@peff.net>
Subject: Re: [Bug] git gc with alternates tries accessing non-existing
 directory
Date: Wed, 18 Mar 2015 05:42:32 -0400
Message-ID: <20150318094232.GA26496@peff.net>
References: <55093344.9030500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Ephrim Khong <dr.khong@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 10:42:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYAUq-0004wB-NR
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 10:42:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755364AbbCRJmg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 05:42:36 -0400
Received: from cloud.peff.net ([50.56.180.127]:34510 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753810AbbCRJmf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 05:42:35 -0400
Received: (qmail 31114 invoked by uid 102); 18 Mar 2015 09:42:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 Mar 2015 04:42:35 -0500
Received: (qmail 1543 invoked by uid 107); 18 Mar 2015 09:42:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 Mar 2015 05:42:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Mar 2015 05:42:32 -0400
Content-Disposition: inline
In-Reply-To: <55093344.9030500@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265700>

On Wed, Mar 18, 2015 at 09:11:48AM +0100, Ephrim Khong wrote:

> I have a non-bare repository /home/a set up with an alternate to the bare
> repository /b. Running  git gc  on /home/a produces below's error
> [...]
> > git --version
> git version 2.3.0

Try v2.3.2. It has b0a4264 (sha1_file: fix iterating loose alternate
objects, 2015-02-08), which is almost certainly the problem.

-Peff
