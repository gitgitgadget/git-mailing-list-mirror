From: Sergei Organov <osv@javad.com>
Subject: Re: [PATCH] Improve description of git-branch -d and -D in man page.
Date: Mon, 19 Nov 2007 12:49:54 +0300
Message-ID: <877ike1s59.fsf@osv.gnss.ru>
References: <874pfq9q8s.fsf@osv.gnss.ru> <200711131703.16357.jnareb@gmail.com>
	<A919E788-C5D0-4404-95D4-869BAFE868AC@zib.de>
	<200711131842.03622.jnareb@gmail.com> <87d4ue81tv.fsf@osv.gnss.ru>
	<20071117191256.GD5198@efreet.light.src>
	<20071117195144.GF5198@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Mon Nov 19 10:50:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iu3H0-0001QO-Qe
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 10:50:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752655AbXKSJuS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 04:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752604AbXKSJuR
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 04:50:17 -0500
Received: from javad.com ([216.122.176.236]:4105 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752495AbXKSJuQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 04:50:16 -0500
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id lAJ9o0i12993;
	Mon, 19 Nov 2007 09:50:00 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1Iu3GM-0007g0-IP; Mon, 19 Nov 2007 12:49:54 +0300
In-Reply-To: <20071117195144.GF5198@efreet.light.src> (Jan Hudec's message of "Sat\, 17 Nov 2007 20\:51\:44 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65420>

Jan Hudec <bulb@ucw.cz> writes:
> Some users expect that deleting a remote-tracking branch would prevent
> fetch from creating it again, so be explcit about that it's not the case.
> Also be a little more explicit about what fully merged means.
>
> Signed-off-by: Jan Hudec <bulb@ucw.cz>
> ---
>
> On Sat, Nov 17, 2007 at 20:12:56 +0100, Jan Hudec wrote:
>> On Tue, Nov 13, 2007 at 20:58:20 +0300, osv@javad.com wrote:
>> > <quote Documentation/git-branch.txt>
>> > Delete unneeded branch::
>> > +
>> > ------------
>> > $ git clone git://git.kernel.org/.../git.git my.git
>> > $ cd my.git
>> > $ git branch -d -r origin/todo origin/html origin/man   <1>
>> > $ git branch -D test                                    <2>
>> > ------------
>> > +
>> > <1> Delete remote-tracking branches "todo", "html", "man"
>> > </quote>
>> > 
>> > That's *exactly* what I did! And it *doesn't work*! Well, it does delete
>> > the branches, but they are automagically re-created on the next fetch,
>> > so "deleting" them this way is useless.
>> 
>> Of course it *does* work. It *deletes* the branches. There is not a single
>> word about stopping fetch getting them!
>> 
>> Obviously given that the example is slightly contrived, it should really
>> be mentioned that it does not affect fetch at all.
>
> Would this make the description obvious enough?

Yes, I think now it describes the actual behavior much much better, --
thanks.

-- 
Sergei.
