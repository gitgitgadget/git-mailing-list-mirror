From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [minor usability suggestion] git rebase <upstream> --onto
	<newbase> ?
Date: Sat, 8 Nov 2008 12:49:56 +0100
Message-ID: <20081108114955.GC8354@elte.hu>
References: <20081107092035.GA1339@elte.hu> <7vej1ngztd.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0811071504110.19665@iabervon.org> <7vy6zvfdp5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 08 12:51:32 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KymLj-0005xX-3n
	for gcvg-git-2@gmane.org; Sat, 08 Nov 2008 12:51:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753010AbYKHLuQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Nov 2008 06:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753031AbYKHLuQ
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Nov 2008 06:50:16 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:53596 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752974AbYKHLuP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2008 06:50:15 -0500
Received: from elvis.elte.hu ([157.181.1.14])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1KymKO-0006DH-CD
	from <mingo@elte.hu>; Sat, 08 Nov 2008 12:50:10 +0100
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 225C03E21A5; Sat,  8 Nov 2008 12:49:56 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vy6zvfdp5.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Received-SPF: neutral (mx2: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00,DNS_FROM_SECURITYSAGE autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	0.0 DNS_FROM_SECURITYSAGE  RBL: Envelope sender in
	blackholes.securitysage.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100397>


* Junio C Hamano <gitster@pobox.com> wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > "git log origin/master -p" works, though.
> 
> That's an accident.  Do not rely on it.

hm, i frequently rely on tacking-on options after the fact, especially 
the -- ones.

Just like the best workflow is append-mostly, command parameters are 
often added append-only as well, without jumping back and forth in the 
command line to edit the command.

Path or brach names starting with '--' are weird anyway, so isnt this 
a reasonable expectation? I hope i'm not misunderstanding something 
here.

	Ingo
