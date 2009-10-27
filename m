From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: git update --prune issue
Date: Tue, 27 Oct 2009 17:40:40 +0100
Message-ID: <20091027164040.GB12464@localhost>
References: <4389ce950910261508p7eca354el77bad07305a80952@mail.gmail.com> <4AE6B28F.9010407@drmicha.warpmail.net> <4389ce950910270807o69d51155xb083f34bb31e1dae@mail.gmail.com> <20091027162936.GA8130@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeffrey Middleton <jefromi@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 27 17:41:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2p6M-0003PH-UV
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 17:40:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756069AbZJ0Qko convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Oct 2009 12:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756016AbZJ0Qko
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 12:40:44 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:57784 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755850AbZJ0Qkn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2009 12:40:43 -0400
Received: by fg-out-1718.google.com with SMTP id 16so5034fgg.1
        for <git@vger.kernel.org>; Tue, 27 Oct 2009 09:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=u2rdN8M1bunHGOL50H7Hfv89oTCjF3TEsGwLyv+V0aE=;
        b=it3RwM/2x1zZ8/HZooZTX4E8TeEtdOQgvhAfopppDfqNWTlauftf6tTMxnkwzXjwqn
         CJtz3OVUug4MtotKFNnmBYm76WRNMi05uWWvTG+JPk7uBWnc8F4QQz6QmPP+ZaIdeXK6
         02jSboegKZDlljFjZ5dY2ycxYPdF9gWWGaX9A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        b=BTr0ubd/6cRQ+nDy7oXjS6Hsxls2Pz7jyXpo5HmaZKpunS1KF66LASg0juLt7dmuZK
         LsRilsgnWKsQg4/HLbQH0dKajPj6lzchjjRxXE/m4yjimtO9PzP0FBaSjWSymD/wL8wl
         YD4n6Z/nrCJW5Uc16zHijlo+d8aoOzFiTSwbY=
Received: by 10.86.173.16 with SMTP id v16mr5437680fge.62.1256661647709;
        Tue, 27 Oct 2009 09:40:47 -0700 (PDT)
Received: from darc.lan (p549A6E37.dip.t-dialin.net [84.154.110.55])
        by mx.google.com with ESMTPS id 3sm399942fge.29.2009.10.27.09.40.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 Oct 2009 09:40:47 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1N2p68-0006gM-3B; Tue, 27 Oct 2009 17:40:40 +0100
Content-Disposition: inline
In-Reply-To: <20091027162936.GA8130@sigill.intra.peff.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131357>

On Tue, Oct 27, 2009 at 12:29:36PM -0400, Jeff King wrote:

> > Pruning steph
> > URL: /users/sdewet/CxTF_DEV/CxTF_DB/
> > =A0* [pruned] steph/beta_gc_dev_old
> > Updating kevin
> > error: refs/remotes/steph/beta_gc_dev does not point to a valid obj=
ect!
> > error: refs/remotes/steph/beta_veh_dev does not point to a valid ob=
ject!
>=20
> The "pruned" line basically means that we are deleting that ref, and
> then we complain immediately about that very ref (which is probably
> pointing to the null sha1 or something at this point).

Actually, it's beta_gc_dev_old and beta_gc_dev, not the same refs.

Clemens
