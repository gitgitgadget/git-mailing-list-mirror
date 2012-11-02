From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Document 'git commit --no-edit' explicitly
Date: Fri, 2 Nov 2012 07:53:35 -0400
Message-ID: <20121102115335.GA2598@sigill.intra.peff.net>
References: <nnpq3wiaha.fsf@stalhein.lysator.liu.se>
 <1351852770-13897-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, nisse@lysator.liu.se
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Nov 02 12:53:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUFot-0007DD-Vd
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 12:53:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752235Ab2KBLxj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2012 07:53:39 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54321 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751978Ab2KBLxi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2012 07:53:38 -0400
Received: (qmail 3394 invoked by uid 107); 2 Nov 2012 11:54:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 02 Nov 2012 07:54:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Nov 2012 07:53:35 -0400
Content-Disposition: inline
In-Reply-To: <1351852770-13897-1-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208923>

On Fri, Nov 02, 2012 at 11:39:30AM +0100, Matthieu Moy wrote:

> I was tempted to merge the paragraph with --edit::, but I thought this
> may add confusion. The use-cases for --edit and --no-edit are really
> different so I went for a separate paragraph, right below the --edit one.

Yeah, usually I think it would be better to keep the positive and
negative forms together, but the way you have done it does seem a lot
more clear to me. I think it is because the default flips based on other
options. So you would be stuck writing something like:

  -e, --edit::
          Edit the commit message using `$EDITOR`. This is the default
          unless the `-F`, `-m`, or `-C` options are used; in those
          cases, `-e` or `--edit` can be used to invoke the editor.
          Likewise, `--no-edit` can be used to suppress the editor when
          using an existing commit message. For example, `git commit
          --amend --no-edit` amends a commit without changing its commit
          message.

Your split reads much better, IMHO.

Thanks.

-Peff
