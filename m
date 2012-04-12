From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 00/15] Hierarchical reference cache (once again)
Date: Thu, 12 Apr 2012 02:44:59 -0400
Message-ID: <20120412064459.GD27369@sigill.intra.peff.net>
References: <1334035827-20331-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Apr 12 08:45:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIDmG-0003RN-B4
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 08:45:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762002Ab2DLGpC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 02:45:02 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58330
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761996Ab2DLGpB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 02:45:01 -0400
Received: (qmail 23871 invoked by uid 107); 12 Apr 2012 06:45:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 12 Apr 2012 02:45:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Apr 2012 02:44:59 -0400
Content-Disposition: inline
In-Reply-To: <1334035827-20331-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195303>

On Tue, Apr 10, 2012 at 07:30:12AM +0200, mhagger@alum.mit.edu wrote:

> Michael Haggerty (15):
>   refs.c: reorder definitions more logically
>   refs: manage current_ref within do_one_ref()
>   do_for_each_ref_in_array(): new function
>   do_for_each_ref_in_arrays(): new function
>   repack_without_ref(): reimplement using do_for_each_ref_in_array()
>   names_conflict(): new function, extracted from is_refname_available()
>   names_conflict(): simplify implementation
>   is_refname_available(): reimplement using do_for_each_ref_in_array()
>   free_ref_entry(): new function
>   check_refname_component(): return 0 for zero-length components
>   struct ref_entry: nest the value part in a union
>   refs.c: rename ref_array -> ref_dir
>   sort_ref_dir(): simplify logic
>   refs: store references hierarchically
>   do_for_each_ref(): only iterate over the subtree that was requested

I read through the whole series and didn't find anything noticeably
wrong.  Overall, it was quite readable for such a large series. Thanks
for breaking it up as you did.

-Peff
