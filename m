From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH] Re: [TRIVIAL] Documentation: merge: one <remote> is
 required
Date: Tue, 11 Aug 2009 16:58:01 +0200
Message-ID: <1250002681.2707.2.camel@localhost.localdomain>
References: <1249995838.1589.3.camel@localhost.localdomain>
	 <20090811144253.GA12956@vidovic>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Tue Aug 11 16:58:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MasoA-0002G9-5W
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 16:58:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbZHKO6J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 10:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbZHKO6I
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 10:58:08 -0400
Received: from smtp-out1.tiscali.nl ([195.241.79.176]:33540 "EHLO
	smtp-out1.tiscali.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932090AbZHKO6H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 10:58:07 -0400
Received: from [212.123.169.34] (helo=[192.168.1.61])
	by smtp-out1.tiscali.nl with esmtp (Exim)
	(envelope-from <pebolle@tiscali.nl>)
	id 1Masnf-0000WP-LG; Tue, 11 Aug 2009 16:58:07 +0200
In-Reply-To: <20090811144253.GA12956@vidovic>
X-Mailer: Evolution 2.27.5 (2.27.5-3.kb.1.fc12) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125568>

On Tue, 2009-08-11 at 16:42 +0200, Nicolas Sebrecht wrote:
> The 11/08/09, Paul Bolle wrote:
> >  'git merge' [-n] [--stat] [--no-commit] [--squash] [-s <strategy>]...
> > -	[-m <msg>] <remote> <remote>...
> > +	[-m <msg>] <remote>...
> >  'git merge' <msg> HEAD <remote>...
> 
> Shoudn't be 
> 
>    [-m <msg>] <remote> [<remote>...]

No, since "<remote>..." means one or more instances of the "<remote>"
option.  

> or
> 
>    [-m <msg>] <remote>[...]

Is "<$something>[...]" used anywhere? It makes little sense to me.

> instead?

Paul Bolle
