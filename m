From: Johan Herland <johan@herland.net>
Subject: Re: [RFC 06/11 v2] fast-import: Add support for importing commit notes
Date: Thu, 30 Jul 2009 02:29:13 +0200
Message-ID: <200907300229.13642.johan@herland.net>
References: <1248656659-21415-1-git-send-email-johan@herland.net>
 <20090729142634.GC1033@spearce.org> <7v8wi7wjex.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	barkalow@iabervon.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 30 02:29:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWJWS-0000EB-0m
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 02:29:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753259AbZG3A3Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 20:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752890AbZG3A3Q
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 20:29:16 -0400
Received: from mx.getmail.no ([84.208.15.66]:52049 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752821AbZG3A3P (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jul 2009 20:29:15 -0400
Content-disposition: inline
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KNK008OGK0RA4B0@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 30 Jul 2009 02:29:15 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KNK00893K0PYL40@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Thu, 30 Jul 2009 02:29:15 +0200 (MEST)
X-PMX-Version: 5.5.5.374460, Antispam-Engine: 2.7.1.369594,
 Antispam-Data: 2009.7.30.1816
User-Agent: KMail/1.11.4 (Linux/2.6.30-ARCH; KDE/4.2.4; x86_64; ; )
In-reply-to: <7v8wi7wjex.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124423>

On Wednesday 29 July 2009, Junio C Hamano wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> >> > We recently hit a similar unintended limitation that we regret in
> >> > the fast-import language, didn't we?
> >>
> >> I don't know. Must have slipped past my mailbox.
> >
> > I remember something being raised, but I can't remember exactly
> > what it was either.
>
> Exporting a tag that points at a non commit was what I had in mind.
>
> > tag, there might be arguments for tagging trees, e.g. so you can
> > export the linux kernel repository with `git fast-export` and reload
> > it with fast-import.  But that's unrelated to this change.
> >
> > See above about notes.
>
> I think we are in agreement then.  Good.

We do? on what? That 'notemodify' should work on <committish> + <tag 
object>? Or that 'notemodify' should work on <any object>?

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
