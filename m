From: Jeff King <peff@peff.net>
Subject: Re: git-svn authors file and =?utf-8?Q?SVN?=
 =?utf-8?B?IHVzZXJzIHdpdGgg4oCYPeKAmQ==?= in the username
Date: Tue, 29 Jul 2014 05:26:37 -0400
Message-ID: <20140729092637.GB13134@peff.net>
References: <dc3fda62c3e94eba9d29fd4b34f2e7cc@EXCHLONDON2013.zoo.lan>
 <20140728200744.GA18098@peff.net>
 <49f272949fef4122b2eb83a7a242e366@EXCHLONDON2013.zoo.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: David Braden <David.Braden@softwire.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 11:26:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XC3gC-0002Zl-LL
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 11:26:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752864AbaG2J0l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2014 05:26:41 -0400
Received: from cloud.peff.net ([50.56.180.127]:42354 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751587AbaG2J0k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2014 05:26:40 -0400
Received: (qmail 5961 invoked by uid 102); 29 Jul 2014 09:26:40 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 Jul 2014 04:26:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Jul 2014 05:26:37 -0400
Content-Disposition: inline
In-Reply-To: <49f272949fef4122b2eb83a7a242e366@EXCHLONDON2013.zoo.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254408>

On Tue, Jul 29, 2014 at 08:35:26AM +0000, David Braden wrote:

> Yeah, the --authors-prog does work.  Is there a way to save the
> configuration though so you don't have to add it everytime time you
> rebase or dcommit?

I think that git-svn's config reader uses the command-line options as a
template, and automatically reads "--authors-prog" from
"svn.authorsprog". I didn't test it, though.

-Peff
