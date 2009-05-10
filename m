From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 2/2] completion: enhance "current branch" display
Date: Sun, 10 May 2009 13:57:01 +0200
Message-ID: <200905101357.01959.j6t@kdbg.org>
References: <7vvdo91glm.fsf@alter.siamese.dyndns.org> <200905101259.07175.j6t@kdbg.org> <87my9lnqet.fsf@erwin.mina86.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Michal Nazarewicz <mina86@tlen.pl>
X-From: git-owner@vger.kernel.org Sun May 10 13:57:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M37eb-0005R5-W3
	for gcvg-git-2@gmane.org; Sun, 10 May 2009 13:57:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478AbZEJL5G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2009 07:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbZEJL5E
	(ORCPT <rfc822;git-outgoing>); Sun, 10 May 2009 07:57:04 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:36692 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751097AbZEJL5D (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2009 07:57:03 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 5C6A32C4005;
	Sun, 10 May 2009 13:57:02 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 114815B0AB;
	Sun, 10 May 2009 13:57:02 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <87my9lnqet.fsf@erwin.mina86.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118716>

On Sonntag, 10. Mai 2009, Michal Nazarewicz wrote:
> Johannes Sixt <j6t@kdbg.org> writes:
> > On Sonntag, 10. Mai 2009, Junio C Hamano wrote:
> >>  				b="$(cut -c1-7 "$g/HEAD" 2>/dev/null)..." ||
> >
> > While you are here, you could turn this line into
> >
> > 		{ b=$(< "$g/HEAD") && b=${b:0:7}...; } 2>/dev/null ||
> >
> > to save a process. $(< foo) is a bash feature and does the same as
> > $(cat foo), but faster.
>
> Excuse me this little cavil but how about something that works on other
> shells as well:
>
> { read b <$g/HEAD && _b=${b#???????} && b=${b%"$_b"}... && unset _b }

Because this is all about *bash* completion ;-)

-- Hannes
