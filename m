From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC PATCH] git push: Push nothing if no refspecs are given or 
	configured
Date: Fri, 6 Mar 2009 12:17:57 +0100
Message-ID: <fabb9a1e0903060317s6bb4644bvb4dbf0b9432ba58a@mail.gmail.com>
References: <20090305221529.GA25871@pvv.org>
	 <fabb9a1e0903051418k3fb6c8baqd0189c772893844e@mail.gmail.com>
	 <200903052322.02098.markus.heidelberg@web.de>
	 <200903052325.44648.markus.heidelberg@web.de>
	 <fabb9a1e0903051426p1222f151s8f466abf319706da@mail.gmail.com>
	 <alpine.DEB.1.00.0903061124000.10279@pacific.mpi-cbg.de>
	 <7v4oy7szze.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: markus.heidelberg@web.de, Finn Arne Gangstad <finnag@pvv.org>,
	git@vger.kernel.org, John Tapsell <johnflux@gmail.com>,
	Andreas Ericsson <ae@op5.se>
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 06 12:19:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfY5c-0000pD-F5
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 12:19:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753421AbZCFLSG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Mar 2009 06:18:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754016AbZCFLSD
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 06:18:03 -0500
Received: from mail-fx0-f176.google.com ([209.85.220.176]:59490 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752019AbZCFLSA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Mar 2009 06:18:00 -0500
Received: by fxm24 with SMTP id 24so327916fxm.37
        for <git@vger.kernel.org>; Fri, 06 Mar 2009 03:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=pTrebR28A2mA+m5iodMRyrSoZV6PAMt8RGqVLng47VA=;
        b=pyhMDWfnnPZZ92CxtOPv/lnx6D6Tw+bi4CnBzd1m5rzHnwY1C/Np86daxzzzAoIm+h
         owh6wvCOBKqsIcAgLXargkomvO8kAzgPPRJxLm2HTChDOiHcSPfqqoJdbbbobQsE7OA/
         XpH6oIKPdr/yfwDHbCIbjLQiKkXo75R2mpImU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=C2Wk1OTDP5GF1qHO754iDqFX3KmTPg/uLByZL331DpPH7oRIbPz1xKOseCqB/FJQrl
         Fe5e4nW9Nps2Z5BCPqZrvQQk9q4C8G31o03eyxkHLHjkF+Z/cbBrV/RY3snHVxKXd1h/
         wBXkcNQOjE8igq+BszCuSQv8541jgN6CGNPck=
Received: by 10.103.241.15 with SMTP id t15mr998578mur.85.1236338277228; Fri, 
	06 Mar 2009 03:17:57 -0800 (PST)
In-Reply-To: <7v4oy7szze.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112424>

Heya,

On Fri, Mar 6, 2009 at 11:32, Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> On Thu, 5 Mar 2009, Sverre Rabbelier wrote:
>>> Right, I'd like to be able to do:
>>> $ git config push.iamnotretarded true
>>> $ git push
>>
>> LOL! =A0Sverre, you have a way to crack me up...

Hehe, good, never hurts to add some humor to this list every now and th=
en ;).

> I found it amusing, too.

I think that humor at times is an effective way to convey your point
while and at the same time keeping the tone light :).

> It may have some correlation with how well organized your work habit =
is,
> but I do not think it has much correlation with being retarded. =A0It=
 is
> more about "'matching refs' is the perfect default for _my_ use patte=
rn,
> don't mess with it, please".

=46or me the reason 'git push' works well for me is that origin is
repo.or.cz and I use the repo there just to synch my changes between
my laptop and my pc (and to keep a backup). I reckon there are other
workflows for which it makes sense to use 'git push' directly :).

--=20
Cheers,

Sverre Rabbelier
