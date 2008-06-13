From: Olivier Marin <dkr+ml.git@free.fr>
Subject: Re: [RFCv2/FYI] git-sequencer.txt
Date: Fri, 13 Jun 2008 21:24:38 +0200
Message-ID: <4852C976.80007@free.fr>
References: <20080607220101.GM31040@leksak.fem-net> <20080612002258.GC7200@leksak.fem-net> <7vabhr9qru.fsf@gitster.siamese.dyndns.org> <20080612170715.GC6848@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Paolo Bonzini <bonzini@gnu.org>,
	Pierre Habouzit <madcoder@debian.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Fri Jun 13 21:25:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7Etv-0007sl-Mg
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 21:25:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751821AbYFMTYQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jun 2008 15:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755460AbYFMTYP
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 15:24:15 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:52584 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754993AbYFMTYN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 15:24:13 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 153D712B6E7;
	Fri, 13 Jun 2008 21:24:12 +0200 (CEST)
Received: from [10.253.21.40] (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 5EFEA12B6E0;
	Fri, 13 Jun 2008 21:24:11 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
In-Reply-To: <20080612170715.GC6848@leksak.fem-net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84934>

Stephan Beyer a =E9crit :
> Junio C Hamano wrote:
>> How would [tag] interact with "--abort"?
>=20
> Nice question.
> Currently all tags are kept on --abort.
> Sequencer could keep a list of generated tags (refs) and remove it=20
> on --abort (or tell the user to remove them if she likes.)

What about tags that have been overwritten?

And why the tag instruction replace an existing tag by default? Would
not be better to exit with an error during the sanity check if the tag
already exists? Perhaps it make sens to accept -f and -d options.

What do you think?

Olivier.
