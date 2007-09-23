From: David Kastrup <dak@gnu.org>
Subject: Re: [OT] Re: C++ *for Git*
Date: Sun, 23 Sep 2007 09:23:08 +0200
Message-ID: <851wcpsv4z.fsf@lola.goethe.zz>
References: <ABE0ABE82AE84593A2B71B0281F4C814@ntdev.corp.microsoft.com>
	<46F5318A.4030103@krose.org> <877imishdp.fsf@catnip.gol.com>
	<46F55E03.2040404@krose.org>
	<5e4707340709221550o6d0a6062qd51c16a278727c29@mail.gmail.com>
	<20070923020951.GF24423@planck.djpig.de>
	<20070923062527.GA8979@old.davidb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Unleashed <alex@flawedcode.org>, Kyle Rose <krose@krose.org>,
	Miles Bader <miles@gnu.org>,
	Dmitry Kakurin <dmitry.kakurin@gmail.com>,
	Git <git@vger.kernel.org>
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Sun Sep 23 09:23:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZLoN-0003Uf-7v
	for gcvg-git-2@gmane.org; Sun, 23 Sep 2007 09:23:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753646AbXIWHXV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Sep 2007 03:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753090AbXIWHXV
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Sep 2007 03:23:21 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:33607 "EHLO
	mail-in-03.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751309AbXIWHXU (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Sep 2007 03:23:20 -0400
Received: from mail-in-09-z2.arcor-online.net (mail-in-09-z2.arcor-online.net [151.189.8.21])
	by mail-in-03.arcor-online.net (Postfix) with ESMTP id 55A742CB061;
	Sun, 23 Sep 2007 09:23:19 +0200 (CEST)
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net [151.189.21.42])
	by mail-in-09-z2.arcor-online.net (Postfix) with ESMTP id 45CE328EEB6;
	Sun, 23 Sep 2007 09:23:19 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-000-085.pools.arcor-ip.net [84.61.0.85])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id 0CB8B7FC7;
	Sun, 23 Sep 2007 09:23:10 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 4C9411C1F3DC; Sun, 23 Sep 2007 09:23:09 +0200 (CEST)
In-Reply-To: <20070923062527.GA8979@old.davidb.org> (David Brown's message of "Sat\, 22 Sep 2007 23\:25\:27 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58953>

David Brown <git@davidb.org> writes:

> On Sun, Sep 23, 2007 at 04:09:51AM +0200, Frank Lichtenheld wrote:
>>On Sun, Sep 23, 2007 at 12:50:00AM +0200, Alex Unleashed wrote:
>>> I'd say being forced to be explicit is a good thing here, so that the
>>> programmer at least has some sort of good understanding of what is
>>> going on, and chances are that if he doesn't really know, things just
>>> won't work out (quite unlike a lot of other languages where this
>>> programmer might actually end up with something half-assed that
>>> "mostly" works).
>>> For some reason it seems to me a lot harder to find bad programmers
>>> surviving using C than a lot of the other languages.
>>
>>Idiot-proofness-by-complexity is a myth IMHO. Idiots can be quite
>>persistent...
>
> I work with plenty of them :-) It's all C.  All of the same things
> happen, with management looking for magic bullets to solve problems
> caused by bad programmers.

C++ is good for creating black boxes.  A black box that has been
fitted into its environment and that has good innards is fine.  A
black box with rotten innards, or not really being well-suited for the
job at hand, isn't.  For a project where people come and go, black
boxes might hide a lot about bad design and implementation.

In particular, changing an algorithm to require different black boxes
is something that is very unpleasant to do.

Having everything in the open is an advantage as long as the
complexity to be managed is at a reasonable level.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
