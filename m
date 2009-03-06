From: obrien654j@gmail.com (Jeremy O'Brien)
Subject: Re: setting up tracking on push
Date: Fri, 06 Mar 2009 09:15:19 -0500
Message-ID: <49b12ff7.nCWIz4ABJcgwW3BZ%obrien654j@gmail.com>
References: <buofxhr2vta.fsf@dhlpc061.dev.necel.com>
 <76718490903052049k217e9c12gb7881f8904fdd9d@mail.gmail.com>
 <alpine.DEB.1.00.0903061144480.10279@pacific.mpi-cbg.de>
 <buoy6vi297q.fsf@dhlpc061.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jaysoffian@gmail.com, git@vger.kernel.org
To: miles@gnu.org, Johannes.Schindelin@gmx.de
X-From: git-owner@vger.kernel.org Fri Mar 06 15:18:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lfat4-00031w-Ni
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 15:18:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752296AbZCFOPS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Mar 2009 09:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751719AbZCFOPR
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 09:15:17 -0500
Received: from wf-out-1314.google.com ([209.85.200.174]:47209 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832AbZCFOPP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 09:15:15 -0500
Received: by wf-out-1314.google.com with SMTP id 28so558022wfa.4
        for <git@vger.kernel.org>; Fri, 06 Mar 2009 06:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject:cc
         :message-id:references:in-reply-to:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=8xv3ErdtknzVNrmQb/p+/gYnideNdfwY2McjHHszJzw=;
        b=JbIK2lHGCk+TRgyeBCdSkr540L+VeYn+PXU1c5wTBODbjMfJJoVrhRQvAtrojpT5FW
         ty9j/lb4pRb/Fpmnt26YEBQwcTLGApH594mbPdxaJz7ey9RlKT6FdIisr2CJ9ufl/RHv
         FaSPKSPbarD0jRUyy3wmNqIqnr9x2RlHDe5WM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:cc:message-id:references:in-reply-to
         :user-agent:mime-version:content-type:content-transfer-encoding;
        b=AdHnuNxxjKi8QmUvwC2MP/pohVZmL1s8N61li0ug7Gcg+7kCdBn+fqeth5HS3fY7FC
         dAgZTfdOL1edlSmpz7/kFOSQ+B5lU4F2TrmKtuprzrWlI9P6kXhxX0Tyfz/hJm2oJSU1
         g9gdpK2rJziRRxtdvDtyssbf4s1/MzURXxcN4=
Received: by 10.142.127.11 with SMTP id z11mr139747wfc.286.1236348913092;
        Fri, 06 Mar 2009 06:15:13 -0800 (PST)
Received: from localhost.localdomain (dynamic-180-199.natpool.uc.edu [129.137.180.199])
        by mx.google.com with ESMTPS id g14sm1767031rvb.0.2009.03.06.06.15.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Mar 2009 06:15:12 -0800 (PST)
In-Reply-To: <buoy6vi297q.fsf@dhlpc061.dev.necel.com>
User-Agent: Heirloom mailx 12.4 7/29/08
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112440>

Miles Bader <miles@gnu.org> wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >> > I vaguely feel like I should be able to do:
> >> >
> >> > =A0git push --track origin grognul
> >
> > http://search.gmane.org/?query=3Dpush+track&group=3Dgmane.comp.vers=
ion-control.git
> >
> > Summary for the lazy: it needs a lot of work to be implemented prop=
erly.
>
> Alternatively, maybe a "git track [REMOTE [BRANCH]]" command that sim=
ply
> adds makes adding the appropriate config magic more convenient ?
>
> I dunno what the arg syntax would look like in the general case;
> I almost always want to use the current branch, and track an identica=
lly
> named branch in the origin remote though...
>
> -Miles

I definitely second this approach. It would be very useful.
