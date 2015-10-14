From: John Keeping <john@keeping.me.uk>
Subject: Re: [BUG] Broken links in Git Documentation/user-manual.txt
Date: Wed, 14 Oct 2015 14:40:42 +0100
Message-ID: <20151014134042.GD19802@serenity.lan>
References: <CAAF+z6F3Yej0ByAL1bGnG7qGRLz_HnpwVRqFVVHiMOebNRmSmA@mail.gmail.com>
 <vpqk2qp52am.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Xue Fuqiao <xfq.free@gmail.com>, Git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Oct 14 15:41:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmMIi-0002T5-BG
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 15:41:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753863AbbJNNk6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2015 09:40:58 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:39334 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753217AbbJNNkz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2015 09:40:55 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 1909BCDA54B;
	Wed, 14 Oct 2015 14:40:55 +0100 (BST)
X-Quarantine-ID: <MsLf7gfIUAvd>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_20=-0.001, URIBL_BLOCKED=0.001]
	autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id MsLf7gfIUAvd; Wed, 14 Oct 2015 14:40:52 +0100 (BST)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 9FC4886600E;
	Wed, 14 Oct 2015 14:40:44 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <vpqk2qp52am.fsf@grenoble-inp.fr>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279573>

On Wed, Oct 14, 2015 at 09:37:05AM +0200, Matthieu Moy wrote:
> Xue Fuqiao <xfq.free@gmail.com> writes:
> 
> > Hi list,
> >
> > In https://git-scm.com/docs/user-manual.html , all links to the
> > glossary[1] are broken.
> 
> Actually, the links themselves are fine, but the destimation is broken.
> 
> The doc is supposed to look like this :
> 
>   https://www.kernel.org/pub/software/scm/git/docs/user-manual.html#def_head
> 
> with the glossary at the end. On
> https://git-scm.com/docs/user-manual.html, the glossary is displayed as
> verbatim text.
> 
> This does not seem to be a bug in our user-manual.txt, but in the way
> it's processed by git-scm.com.

I think it was an issue in the source, but was fixed by be510e0
(Documentation: fix section header mark-up, 2015-09-25).  I'm not sure
when/how git-scm.com rebulds its documentation, but I'm pretty sure that
fix hasn't made it into a release yet so I doubt the site has picked it
up.

> I reported the issue there:
> 
> https://github.com/git/git-scm.com/issues/605
