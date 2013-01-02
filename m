From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: add a checkbox to control the visibility of tags
Date: Wed, 2 Jan 2013 18:17:01 +1100
Message-ID: <20130102071701.GG20724@iris.ozlabs.ibm.com>
References: <1354309737-4280-1-git-send-email-stlman@poczta.fm>
 <7vlidhmc5i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?Q?=C5=81ukasz?= Stelmach <stlman@poczta.fm>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 02 08:17:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqIZq-0004Y7-6Z
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 08:17:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061Ab3ABHRG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jan 2013 02:17:06 -0500
Received: from ozlabs.org ([203.10.76.45]:40172 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750763Ab3ABHRF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2013 02:17:05 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 4816F2C0094; Wed,  2 Jan 2013 18:17:04 +1100 (EST)
Content-Disposition: inline
In-Reply-To: <7vlidhmc5i.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212495>

On Sat, Dec 01, 2012 at 06:16:25PM -0800, Junio C Hamano wrote:
> =C5=81ukasz Stelmach <stlman@poczta.fm> writes:
>=20
> > Enable hiding of tags displayed in the tree as yellow labels.
> > If a repository is used together with a system like Gerrit
> > there may be quite a lot of tags used to control building
> > and there may be hardly any place left for commit subjects.
> >
> > Signed-off-by: =C5=81ukasz Stelmach <stlman@poczta.fm>
> > ---
>=20
> Paul, this patch is not done against your tree (does not have gitk
> at the top-level), but other than that, the change mimics the way
> existing hideremoes is implemented and looks reasonable to me.
>=20
> We _may_ want to unify these two "hidestuff" into a list of patterns
> that hides any ref that match one of the patterns in the list, e.g.
>=20
> 	set hidestuff {refs/heads/*/* refs/tags/* refs/remotes/*}
>=20
> may hide all tags, all remote-tracking branches and local branches
> that have a slash in their names.

If the concern is the amount of screen real-estate that the tags take
up when there are many of them (which is a reasonable concern), I'd
rather just put a single tag icon with "tags..." inside it and arrange
to list all the tags in the diff display pane when the user clicks on
it.  I think that would be better than not showing the tags at all.

Paul.
