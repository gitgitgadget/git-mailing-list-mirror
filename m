From: Caleb Cushing <xenoterracide@gmail.com>
Subject: Re: fatal: git write-tree failed to write a tree
Date: Tue, 3 Mar 2009 12:18:22 -0500
Message-ID: <81bfc67a0903030918w3ccc88fcudfa8a2986e8e2415@mail.gmail.com>
References: <81bfc67a0902280825t507e385bvd25c846add2a299c@mail.gmail.com>
	 <alpine.DEB.1.00.0903012210230.10279@pacific.mpi-cbg.de>
	 <81bfc67a0903022147m42e8fe38gb93773084614d30@mail.gmail.com>
	 <alpine.DEB.1.00.0903031103580.6399@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 03 18:20:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeYHZ-0002CX-1D
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 18:19:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752831AbZCCRSZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Mar 2009 12:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752796AbZCCRSZ
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 12:18:25 -0500
Received: from yw-out-2324.google.com ([74.125.46.31]:7189 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751077AbZCCRSY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2009 12:18:24 -0500
Received: by yw-out-2324.google.com with SMTP id 5so1879810ywh.1
        for <git@vger.kernel.org>; Tue, 03 Mar 2009 09:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=U24HASuaI6xny6As5xNLlcOjd6gZ76jqtwHoORPv+cE=;
        b=xZ1PzDTaFsMMYfBd9tiP2z6tS02gLfAskmsRu4lsi1/6Sy8yn7zxEaGv3IH/2m91tb
         NMbX4bZ8gFm0eZQNll8EohlLQMMaY4cuJPDKl5gj2HiHdlsdUaAPuPzHA4kT0qNJYVlr
         EDw6fvk4Hr5YZ2n1u+RlVLeDPTPHV290NXhcI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qvNazwIFi0Fz10kAxYET8Eh4+UFe1DGzhE+iiQGTM3L6kenZf1qmB858/I0eNQof7v
         fa2xGe55tSk4wOamKQ0tLwo8QgM7oSzwneBxIYJAe+xx+I0qvvq2W1ykyhnVo987dfHC
         +KgwAeMxkH5teBJWhsFRh/NYpjQS7Ojx88GC4=
Received: by 10.100.143.14 with SMTP id q14mr5913856and.47.1236100702632; Tue, 
	03 Mar 2009 09:18:22 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0903031103580.6399@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112125>

>
> You have a tree with unmerged entries. =C2=A0Why don't you look into =
the issue
> and solve it? =C2=A0A simple "git status" should show you what are th=
e unmerged
> entries. =C2=A0A simple look at those files should show you conflict =
markers.
>
> Resolve the issue, commit, continue.

no... not so simple... git mergetool comes back with (c)reated
(d)eleted files. I want the created one. when I choose that and
commit, no merge is capable of happening. it says (for that file) that
there is nothing to change, in fact if nothing else has changed the
branch will simply say nothing to commit once I've resolved it. all
commits at this point are simply commits.
--=20
Caleb Cushing

http://xenoterracide.blogspot.com
