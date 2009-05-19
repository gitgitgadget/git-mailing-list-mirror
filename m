From: Johan Herland <johan@herland.net>
Subject: Re: What's cooking in git.git (May 2009, #02; Sun, 17)
Date: Tue, 19 May 2009 10:45:38 +0200
Message-ID: <200905191045.39108.johan@herland.net>
References: <7vab5ci281.fsf@alter.siamese.dyndns.org> <200905190923.33874.johan@herland.net> <alpine.DEB.1.00.0905191015560.26154@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	markus.heidelberg@web.de, Peter Hutterer <peter.hutterer@who-t.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue May 19 10:45:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6KxM-0000te-3Z
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 10:45:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520AbZESIpo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 04:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbZESIpo
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 04:45:44 -0400
Received: from sam.opera.com ([213.236.208.81]:46140 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750840AbZESIpn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 04:45:43 -0400
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id n4J8jdUc031906
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 19 May 2009 08:45:39 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0905191015560.26154@pacific.mpi-cbg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119507>

On Tuesday 19 May 2009, Johannes Schindelin wrote:
> On Tue, 19 May 2009, Johan Herland wrote:
> > On Tuesday 19 May 2009, Junio C Hamano wrote:
> > > Johan Herland <johan@herland.net> writes:
> > > > After some thinking, I don't like my original name
> > > > submodule.<name>.resolve, since ".resolve" sounds more like a
> > > > merge strategy or conflict resolution method, than a "how to
> > > > deal with submodule update" choice. I propose
> > > > submodule.<name>.update instead.
> > >
> > > Sounds like a plan, even though I do not necessarily agree with
> > > the idea of automatically rebinding what is at the submodule path
> > > every time you update the toplevel project tree.
> >
> > I agree that in many workflows this does not make sense, but I
> > believe that (as with 'git submodule update --rebase') there are
> > some cases where it does make sense, and I see no reason to support
> > one, but not the other.
>
> We have a _lot_ of obscure things that are not supported by core Git,
> but are _very_ easy to add as _tiny_ add-on scripts by the user,
> without the need for "official" feature support.
>
> Just like this one

Does that mean you're also opposed to 'git submodule update --rebase' 
(which is already in 'next', and is even Signed-off-by yourself)?

I still don't see any reason why one should be added (--rebase), and not 
the other (--merge).

Dropping both would at least be consistent from core Git's POV, but 
following that thread, we should probably also drop "git pull" (which 
is just a simple wrapper around "git fetch" and "git merge"), and maybe 
also "git clone" (which can easily be scripted, using "git init", "git 
remote", "git fetch" and "git branch")...


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
