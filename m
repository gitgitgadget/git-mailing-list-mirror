From: Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [PATCH v2 2/4] stripspace: Use parse-options for command-line
 parsing
Date: Tue, 20 Oct 2015 10:48:23 +0200
Message-ID: <20151020084823.GP2468@distanz.ch>
References: <1445008605-16534-1-git-send-email-tklauser@distanz.ch>
 <1445008605-16534-3-git-send-email-tklauser@distanz.ch>
 <xmqqoafyg2sp.fsf@gitster.mtv.corp.google.com>
 <xmqqd1weg1s0.fsf@gitster.mtv.corp.google.com>
 <20151017103134.GD2468@distanz.ch>
 <xmqq6125choi.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 20 10:48:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZoSax-00082O-Bn
	for gcvg-git-2@plane.gmane.org; Tue, 20 Oct 2015 10:48:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753972AbbJTIsa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2015 04:48:30 -0400
Received: from sym2.noone.org ([178.63.92.236]:46115 "EHLO sym2.noone.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753962AbbJTIs0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2015 04:48:26 -0400
Received: by sym2.noone.org (Postfix, from userid 1002)
	id 3ng7s471WBzQWj7; Tue, 20 Oct 2015 10:48:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <xmqq6125choi.fsf@gitster.mtv.corp.google.com>
X-Editor: Vi IMproved 7.3
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279903>

On 2015-10-17 at 23:24:13 +0200, Junio C Hamano <gitster@pobox.com> wrote:
> Tobias Klauser <tklauser@distanz.ch> writes:
> 
> > On 2015-10-16 at 19:29:35 +0200, Junio C Hamano <gitster@pobox.com> wrote:
> >> Junio C Hamano <gitster@pobox.com> writes:
> >> 
> >> >> -	if (mode == INVAL)
> >> >> -		usage(usage_msg);
> >> >
> >> > When given "git stripspace -s blorg", we used to set mode to INVAL
> >> > and then showed the correct usage.  But we no longer have a check
> >> > that corresponds to the old INVAL thing, do we?  Perhaps check argc
> >> > to detect presence of an otherwise ignored non-option argument
> >> > immediately after parse_options() returns?
> >> 
> >> Perhaps like this.
> >
> > Thanks. I'll fold it into v3.
> 
> Before starting v3, please fetch from me and check what is queued on
> 'pu'.  It may turn out that the fix-ups I did while queuing this
> round is sufficient, in which case you can just say that instead ;-)

Now that patches 3 and 4 will be dropped and no changes being necessary
for patches 1 and 2 (except for your changes that I see are already
folded into 'pu'), do you want me to submit a v3 of the series? Or is it
enough if I ask you to drop patches 3 (stripspace: implement
--count-lines option) and 4 (rebase -i: use "stripspace --count-lines"
when counting todo items)?

Thanks
