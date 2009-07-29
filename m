From: Johan Herland <johan@herland.net>
Subject: Re: [RFC 06/11 v2] fast-import: Add support for importing commit notes
Date: Thu, 30 Jul 2009 01:08:51 +0200
Message-ID: <200907300108.51703.johan@herland.net>
References: <1248656659-21415-1-git-send-email-johan@herland.net>
 <200907280343.56586.johan@herland.net>
 <7v1vnzuxly.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	barkalow@iabervon.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 30 01:09:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWIGc-0001YE-Sx
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 01:09:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754998AbZG2XIz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 19:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754986AbZG2XIy
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 19:08:54 -0400
Received: from mx.getmail.no ([84.208.15.66]:62573 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754922AbZG2XIy (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jul 2009 19:08:54 -0400
Content-disposition: inline
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KNK0088PGATA4B0@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 30 Jul 2009 01:08:53 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KNK00HTLGASJYE0@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 30 Jul 2009 01:08:53 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.7.29.225716
User-Agent: KMail/1.11.4 (Linux/2.6.30-ARCH; KDE/4.2.4; x86_64; ; )
In-reply-to: <7v1vnzuxly.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124409>

On Wednesday 29 July 2009, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> > Introduce a 'notemodify' subcommand of the 'commit' command. This
> > subcommand is similar to 'filemodify', except that no mode is supplied
> > (all notes have mode 0644), and the path is set to the hex SHA1 of the
> > given "comittish".
> >
> > This enables fast import of note objects along with their associated
> > commits, since the notes can now be named using the mark references of
> > their corresponding commits.
> >
> > The patch also includes a test case of the added functionality.
> >
> > Signed-off-by: Johan Herland <johan@herland.net>
>
> Thanks.
>
> Replacing this will cascade to the rest of the series, right?

Not sure what you mean by "cascade to the rest of the series". If you just 
replace 06/11_v1 with 06/11_v2, things will stop working (since 10/11 and 
11/11 needs a corresponding update of their fast-import commands).

On the other hand, I have moved this patch into the jh/notes series (which I 
updated/resent last night).

I will update/resend this patch series tomorrow, with suggested fixes, and 
rebased onto the updated jh/notes series.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
