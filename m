From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 6/8] Documentation/notes: simplify treatment of default
 display refs
Date: Mon, 10 May 2010 02:06:30 -0400
Message-ID: <20100510060630.GC13340@coredump.intra.peff.net>
References: <20100509031357.GA7926@progeny.tock>
 <20100509033223.GF7958@progeny.tock>
 <20100509070022.GC23717@sigill.intra.peff.net>
 <20100509084325.GA9801@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Thomas Rast <trast@student.ethz.ch>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 10 08:06:38 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBM8T-0003xG-1X
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 08:06:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754212Ab0EJGGc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 May 2010 02:06:32 -0400
Received: from peff.net ([208.65.91.99]:44438 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754383Ab0EJGGb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 02:06:31 -0400
Received: (qmail 32474 invoked by uid 107); 10 May 2010 06:06:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 10 May 2010 02:06:47 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 10 May 2010 02:06:30 -0400
Content-Disposition: inline
In-Reply-To: <20100509084325.GA9801@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146761>

On Sun, May 09, 2010 at 03:43:25AM -0500, Jonathan Nieder wrote:

> Thanks for bringing this up.  I think some of the changes ultimately
> ought to be propagated back to config.txt.  I copied the text anyway
> because as long as the differences are in short-term memory, I find i=
t
> easier to manipulate two similar files than one file with ifdefs in
> it; so it seemed like a reasonable strategy to let these diverge for =
a
> few weeks and then merge them with ifdefs again.

Hrm. If that merge actually happens while things are still in short-ter=
m
memory. ;)

> Some divergence is needed imho so that the text can say things like
> =E2=80=9Csee the Options section earlier in this page=E2=80=9D.

Yeah, understandable. And I also don't want to get into a rat's nest of
ifdefs in the documentation. Which is why I was pushing to move straigh=
t
into something more elegant. :)

> Longer term, I suspect I would like a gitconfig.5 page that functione=
d
> something like the main commands list, which could avoid some
> duplication.  But this is something to be considered carefully: right
> now it is very easy to start with knowing there is some configuration
> for what you want to change (conflict hunk format, say) and find it b=
y
> searching the descriptions in git-config.1; if we split that file up,
> that won=E2=80=99t be so easy.

Yeah, I do worry about people being able to search effectively. But to
some degree, sensible naming of the options helps with that. Searching
for "conflict" even in just a list of options should come up with
"merge.conflictstyle", and I had always intended for such a gitconfig.5
to have a full list.

>   CONFIGURATION SECTIONS
>   [...]

Your breakdown looks like a sensible thing to have at the start of
gitconfig.5. It looks like you were planning on putting some generic
concepts like "alias" and "core" into that page (at the end of the
overview list), and then referring to individual command pages for thei=
r
respective sections. That sounds reasonable to me.

-Peff
