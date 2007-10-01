From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH] Improve bash prompt to detect various states like an unfinished merge
Date: Mon, 1 Oct 2007 20:29:37 +0200
Message-ID: <200710012029.38100.robin.rosenberg@dewire.com>
References: <20070904071301.GA18160@spearce.org> <1191111645134-git-send-email-robin.rosenberg@dewire.com> <7vabr3tfmq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, johannes.sixt@telecom.at, spearce@spearce.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 01 20:27:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcPzX-0004r6-9e
	for gcvg-git-2@gmane.org; Mon, 01 Oct 2007 20:27:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752130AbXJAS1a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Oct 2007 14:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752104AbXJAS1a
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Oct 2007 14:27:30 -0400
Received: from [83.140.172.130] ([83.140.172.130]:9927 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751941AbXJAS13 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2007 14:27:29 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 5AE5F8030C6;
	Mon,  1 Oct 2007 20:19:07 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 30083-09; Mon,  1 Oct 2007 20:19:07 +0200 (CEST)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 00F6780264D;
	Mon,  1 Oct 2007 20:19:06 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <7vabr3tfmq.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59630>

m=E5ndag 01 oktober 2007 skrev Junio C Hamano:
> Robin Rosenberg <robin.rosenberg@dewire.com> writes:
>=20
> > This patch makes the git prompt (when enabled) show if a merge or a
> > rebase is unfinished. It also detects if a bisect is being done as
> > well as detached checkouts.
>=20
> Since you show the name of the branch anyway, I have to wonder
> why you should say BISECT.

You can wonder around different branches while bisecting. The BISECT
part is there to remind you that you are already doing bisecting, espec=
ially
when being away from the prompt for a while. I did some mistakes withou=
t it.

> Also if you know you normally get branch name, lack of branch
> name would indicate detached HEAD, I would presume.

Yes, sure, but I like it better this way.

> But other state information may be helpful.

This is an example script, so I'd say it's better to have a little too =
much=20
and let people remve stuff they don't like in their personal copies.

-- robin
