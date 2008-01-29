From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/2] Documentation: config: add "browser.<tool>.path".
Date: Tue, 29 Jan 2008 07:07:56 +0100
Message-ID: <200801290707.57040.chriscool@tuxfamily.org>
References: <20080128080223.de8a67d2.chriscool@tuxfamily.org> <7v1w82wgev.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 07:03:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJjYc-0004Xm-3U
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 07:02:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756434AbYA2GBz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jan 2008 01:01:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756493AbYA2GBz
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jan 2008 01:01:55 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:39274 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753396AbYA2GBx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Jan 2008 01:01:53 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id A611F1AB2A8;
	Tue, 29 Jan 2008 07:01:52 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 8BB1C1AB2B0;
	Tue, 29 Jan 2008 07:01:52 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <7v1w82wgev.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71953>

Le lundi 28 janvier 2008, Junio C Hamano a =E9crit :
> Christian Couder <chriscool@tuxfamily.org> writes:
> >
> > +browser.<tool>.path::
> > +	Override the path for the given tool that may be used to
> > +	browse help. See linkgit:git-help[1].
> > +
>
> Thanks.
>
> I wonder if we want to stress the fact that this is about
> rendering HTML version of the manual.  IOW, the <tool>.path
> is about the path the chosen HTML renderer program is at, and
> not consulted at all unless "git help -w help" is run.
>
> Also, do we want to list the repertoire of <tool>?  Unlike
> <name> in "remote.<name>.url" and "branch.<name>.remote", this
> is not something the end user can arbitrarily name.
>
> Incidentally, I notice that git-help manual page does not list
> what browsers are supported (except that it hints that firefox
> is usable by having an example "browser.firefox.path"), even
> though it tells how the browser is picked via "*.browser".

It should be fixed in the following patch series.

Thanks,
Christian.
