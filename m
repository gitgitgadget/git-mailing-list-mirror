From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC] rebase: add --revisions flag
Date: Wed, 9 Dec 2009 15:45:36 +0200
Message-ID: <20091209134535.GK2977@redhat.com>
References: <20091208144740.GA30830@redhat.com> <7vfx7lcj18.fsf@alter.siamese.dyndns.org> <vpqiqcgp95t.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Dec 09 14:48:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIMu5-0007jl-UQ
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 14:48:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755985AbZLINsT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Dec 2009 08:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755930AbZLINsS
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Dec 2009 08:48:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:11144 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755911AbZLINsR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2009 08:48:17 -0500
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id nB9DmKvP007142
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Wed, 9 Dec 2009 08:48:20 -0500
Received: from redhat.com (vpn2-9-43.ams2.redhat.com [10.36.9.43])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with SMTP id nB9DmIAO009444;
	Wed, 9 Dec 2009 08:48:18 -0500
Content-Disposition: inline
In-Reply-To: <vpqiqcgp95t.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134969>

On Wed, Dec 09, 2009 at 02:30:06PM +0100, Matthieu Moy wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > So perhaps a good way to move forward is to teach "git cherry-pick A..B"
> > to be a thin wrapper that invokes a new hidden mode of operation added to
> > "rebase" that is not advertised to the end user.
> >
> > I would suggest calling the option to invoke that hidden mode not
> > "--revisions", but "--reverse" or "--opposite" or something of that
> > nature, though.  It makes "rebase" work in different direction.
> 
> Intuitively,
> 
>   git rebase --reverse A..B
> 
> would mean "take the range A..B, and start applying the patches from
> B, going in reverse order up to A", like "git log --reverse". So, I'd
> find it misleading.
> 
> Perhaps "git rebase --cherry-pick A..B" would be a better name. No
> objection for --opposite either.

I relly like --cherry-pick. Junio, objections to that one?

> -- 
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
