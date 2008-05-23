From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 4/3] bisect: use a detached HEAD to bisect
Date: Fri, 23 May 2008 09:08:24 +0200
Message-ID: <200805230908.24988.chriscool@tuxfamily.org>
References: <20080523012857.acce6457.chriscool@tuxfamily.org> <7v3ao9twfa.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 23 09:04:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzRKe-0002P3-J8
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 09:04:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754773AbYEWHDy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 May 2008 03:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758247AbYEWHDy
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 03:03:54 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:42064 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754470AbYEWHDx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 May 2008 03:03:53 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 5DFC31AB2EF;
	Fri, 23 May 2008 09:03:51 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 443B71AB2AB;
	Fri, 23 May 2008 09:03:51 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7v3ao9twfa.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82687>

Le vendredi 23 mai 2008, Junio C Hamano a =E9crit :
> Christian Couder <chriscool@tuxfamily.org> writes:
> > When "git bisect" was first written, it was not possible to
> > checkout a detached HEAD. The detached feature appeared latter.
> > ...
> > This patch makes "git bisect" checkout revisions to be tested on
> > a detached HEAD. This simplifies the code a bit.
>
> Yay!!
>
> One potential worry/downside is "bisect visualize".  Because <bisect>
> branch was used for bisection, the _current_ commit has always been
> indicated with a label.  HEAD would not get any special label in gitk=
,
> would it?

You are probably right. I will have a look at that.

Thanks,
Christian.
