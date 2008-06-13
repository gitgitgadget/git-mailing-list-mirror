From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [RFCv2/FYI] git-sequencer.txt
Date: Fri, 13 Jun 2008 14:16:07 +0200
Message-ID: <20080613121607.GC7925@leksak.fem-net>
References: <20080607220101.GM31040@leksak.fem-net> <20080612002258.GC7200@leksak.fem-net> <7vabhr9qru.fsf@gitster.siamese.dyndns.org> <20080612170715.GC6848@leksak.fem-net> <4851FFE9.30108@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Fri Jun 13 14:18:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K78DP-0001iS-Es
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 14:17:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755214AbYFMMQM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 08:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754985AbYFMMQM
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 08:16:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:35117 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754124AbYFMMQL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 08:16:11 -0400
Received: (qmail invoked by alias); 13 Jun 2008 12:16:09 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp025) with SMTP; 13 Jun 2008 14:16:09 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/dgDA9PDPdIIJmIJuFLElr/R41DQgPl1+7k4B794
	tid8RXPzKBca7D
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1K78CN-00061s-2E; Fri, 13 Jun 2008 14:16:07 +0200
Content-Disposition: inline
In-Reply-To: <4851FFE9.30108@gnu.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84870>

>> squash [<options>] --from <mark>::
>> 	Squash all commits from the given mark into one commit.
>> 	There must not be any `merge` instructions between the
>> 	`mark` instruction and this `squash --from` instruction.
>
> --after maybe?

I have no idea what is best here ;-)
Something that seems intuitive when you see:

	merge ...
	mark :5
	pick 666babe
	patch foo.patch
	pick fa1afe1

Now?
1)  squash --up-to :5
2)  squash --from :5
3)  squash --after :5

(1) suggests the wrong direction...
My English feeling says that (2) "squash from" is better than 
(3) "squash after", but I'm not a native speaker ;-)

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
