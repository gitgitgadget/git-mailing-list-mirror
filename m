From: Jeff King <peff@peff.net>
Subject: Re: Bug in "git rev-parse --verify"
Date: Thu, 28 Mar 2013 11:38:08 -0400
Message-ID: <20130328153808.GB3337@sigill.intra.peff.net>
References: <51543FDB.9010109@alum.mit.edu>
 <CAPc5daUqzz=9TBmj2Q0MHqEc6gMHxXoGr9+JV3hq76zDKJAyCw@mail.gmail.com>
 <515462FB.9040605@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <junio@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Mar 28 16:38:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULEuZ-0001Nn-PL
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 16:38:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756109Ab3C1PiQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 11:38:16 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43671 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755204Ab3C1PiP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 11:38:15 -0400
Received: (qmail 25848 invoked by uid 107); 28 Mar 2013 15:40:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 28 Mar 2013 11:40:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Mar 2013 11:38:08 -0400
Content-Disposition: inline
In-Reply-To: <515462FB.9040605@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219412>

On Thu, Mar 28, 2013 at 04:34:19PM +0100, Michael Haggerty wrote:

> Is there a simple way to verify an object name more strictly and convert
> it to an SHA1?  I can only think of solutions that require two commands,
> like
> 
>     git cat-file -e $ARG && git rev-parse --verify $ARG

Is the rev-parse line doing anything there? If $ARG does not resolve to
a sha1, then wouldn't cat-file have failed?

-Peff
