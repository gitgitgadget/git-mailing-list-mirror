From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] push: document --no-verify
Date: Wed, 22 May 2013 15:17:14 +0300
Message-ID: <20130522121714.GB7707@redhat.com>
References: <20130522104356.GA5472@redhat.com>
 <878v378b8a.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Aaron Schrab <aaron@schrab.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Wed May 22 14:17:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uf7yk-0001a6-Rd
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 14:17:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755336Ab3EVMRL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 08:17:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:16455 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754865Ab3EVMRK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 May 2013 08:17:10 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r4MCGro2003284
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Wed, 22 May 2013 08:16:54 -0400
Received: from redhat.com (vpn-202-164.tlv.redhat.com [10.35.202.164])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id r4MCGn6w032092;
	Wed, 22 May 2013 08:16:50 -0400
Content-Disposition: inline
In-Reply-To: <878v378b8a.fsf@linux-k42r.v.cablecom.net>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225150>

On Wed, May 22, 2013 at 02:12:21PM +0200, Thomas Rast wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > commit ec55559f937727bcb0fa8a3dfe6af68c188e968a added
> > --no-verify flag to git push, but didn't document it.
> > It's a useful flag when using pre-push hooks so
> > add the documentation.
> >
> > Suggested-by: Thomas Rast <trast@inf.ethz.ch>
> > Cc: Aaron Schrab <aaron@schrab.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> [...]
> > +-n::
> > +--no-verify::
> > +	This option bypasses the pre-commit and commit-msg hooks.
> > +	See also linkgit:githooks[5].
> > +
> 
> Umm, half of that is not correct :-)
> 
> Push doesn't have the -n short form that git-commit does,

Hmm true - in fact -n means dry-run.

> and the hook
> names are wrong.
> 
> I also ended up writing a patch myself; sorry for not telling you on
> IRC:
> 
>   http://thread.gmane.org/gmane.comp.version-control.git/225141

Great, thanks.

> -- 
> Thomas Rast
> trast@{inf,student}.ethz.ch
