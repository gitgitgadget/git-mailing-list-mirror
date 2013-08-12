From: Jeff King <peff@peff.net>
Subject: Re: git should not use a default user.email config value
Date: Mon, 12 Aug 2013 11:49:04 -0400
Message-ID: <20130812154904.GB18215@sigill.intra.peff.net>
References: <20130809134236.28143.75775.reportbug@tglase.lan.tarent.de>
 <20130809194214.GV14690@google.com>
 <20130809223758.GB7160@sigill.intra.peff.net>
 <20130809231928.GY14690@google.com>
 <20130810064717.GB30185@sigill.intra.peff.net>
 <52060EF9.2040504@alum.mit.edu>
 <7vvc3d1o01.fsf@alter.siamese.dyndns.org>
 <CAH5451nHfOaBzFzkrGvw+TyRj==cVpKF_QdXsTxnn5tTr1c0dw@mail.gmail.com>
 <20130812123921.GA16088@sigill.intra.peff.net>
 <5208DAF5.3040006@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andrew Ardill <andrew.ardill@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thorsten Glaser <tg@mirbsd.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Aug 12 17:49:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8uMr-0000n8-DU
	for gcvg-git-2@plane.gmane.org; Mon, 12 Aug 2013 17:49:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757159Ab3HLPtJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Aug 2013 11:49:09 -0400
Received: from cloud.peff.net ([50.56.180.127]:48135 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756863Ab3HLPtH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Aug 2013 11:49:07 -0400
Received: (qmail 22488 invoked by uid 102); 12 Aug 2013 15:49:07 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 Aug 2013 10:49:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Aug 2013 11:49:04 -0400
Content-Disposition: inline
In-Reply-To: <5208DAF5.3040006@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232195>

On Mon, Aug 12, 2013 at 02:54:13PM +0200, Michael Haggerty wrote:

> We could satisfy a whole class of wishes by supporting
> user-wide/system-wide git hooks like
> 
>     ~/.githooks/{pre,post}-clone     /etc/githooks/{pre,post}-clone
>     ~/.githooks/{pre,post}-init      /etc/githooks/{pre,post}-init
> 
> I suppose similar functionality could be implemented via git aliases,
> but hook scripts are easier to install and share.

I don't mind something like that, as it is very flexible. But I have a
feeling most uses would end up just symlinking some template hooks or
config.  At which point we might be better serving the user to provide a
solution that is simpler to use (e.g., a ~/.githooks directory that is
checked for all hooks; the tricky part there would be making rules for
the case that there are system, user, and repo-level scripts for a
particular hook).

-Peff
