From: Jeff King <peff@peff.net>
Subject: Re: Test failures with python versions when building git 1.8.1
Date: Wed, 2 Jan 2013 15:54:35 -0500
Message-ID: <20130102205435.GA24810@sigill.intra.peff.net>
References: <CAEik5nOqge8ix4WGf-h+0Dmz1CanH_XtQdB-CxvPsggSu1-LzQ@mail.gmail.com>
 <7va9ss5fhq.fsf@alter.siamese.dyndns.org>
 <20130102065345.GA8685@sigill.intra.peff.net>
 <7v1ue459yh.fsf@alter.siamese.dyndns.org>
 <20130102085935.GB9328@sigill.intra.peff.net>
 <7vip7f4k7x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dan McGee <dan@archlinux.org>,
	GIT Mailing-list <git@vger.kernel.org>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	David Michael Barr <b@rr-dav.id.au>,
	"Eric S. Raymond" <esr@thyrsus.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 02 21:54:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqVKy-0001Yg-Pv
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 21:54:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752739Ab3ABUyi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2013 15:54:38 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41539 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752699Ab3ABUyh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2013 15:54:37 -0500
Received: (qmail 32251 invoked by uid 107); 2 Jan 2013 20:55:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 02 Jan 2013 15:55:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Jan 2013 15:54:35 -0500
Content-Disposition: inline
In-Reply-To: <7vip7f4k7x.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212540>

On Wed, Jan 02, 2013 at 08:34:42AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Whether we end up doing something with contrib and tests or not, the
> > patch below gives a minimal fix in the meantime.
> 
> Replacing the symbolic link with write_script that uses exported
> variables looks like a familiar pattern.  I like it.
> 
> Oh, wait.  That pattern is of course familiar, because 5a02966
> (t9020: use configured Python to run the test helper, 2012-12-18)
> has been in 'next', and is planned for the first batch.

Great minds think alike, I guess?

Would have been nice to mention that you had done a patch when you
pointed to the unproductive thread. :P But I think you can take the
similarity of our patches and commit messages as my endorsement of
5a02966. :)

-Peff
