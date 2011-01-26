From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 2/2] Re: rebase -i: explain how to discard all commits
Date: Wed, 26 Jan 2011 02:33:14 -0500
Message-ID: <AANLkTim3jPv1=T49wG5WJu_b947ZE=uNHD_2gjxePAfx@mail.gmail.com>
References: <vpq62ziv788.fsf@bauges.imag.fr> <20110120195726.GA11702@burratino>
 <20110120200827.GB14184@vidovic> <201101202134.41911.trast@student.ethz.ch>
 <7vfwsnqn8c.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.1101210801210.15247@pacific.mpi-cbg.de>
 <7vsjwmp5cs.fsf@alter.siamese.dyndns.org> <vpqmxmu2nm3.fsf@bauges.imag.fr> <4D39C923.20202@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Thomas Rast <trast@student.ethz.ch>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Kevin Ballard <kevin@sb.org>, Yann Dirson <dirson@bertin.fr>,
	Eric Raible <raible@nextest.com>
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Wed Jan 26 08:33:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Phzt2-0003vD-IU
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 08:33:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752104Ab1AZHdp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Jan 2011 02:33:45 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:57830 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751594Ab1AZHdo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Jan 2011 02:33:44 -0500
Received: by iwn9 with SMTP id 9so611765iwn.19
        for <git@vger.kernel.org>; Tue, 25 Jan 2011 23:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=wXSWpRzQLnU/Fc4BtK3vFawCMS5rdd3dq3aMMJ6LHHo=;
        b=TRb1ery0hM01895z2+XZsltWpWUw9ReTQG3RPJm2jKIVhOMnwpdchli5jieuNLTZvl
         KDx5mu0ydHMOyXbep3Hnzi+iPEFEpZZ6nZZ13Y3XoQDymr050sYjOr1jRpJb2/8FXrAJ
         NphONlalvow74sBaSKSflJZ7GxXHN95cKj0t4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=msQlGZo91jd3cRmLJRw+jRUqL9YR+2Jld/iq8gT5aWKCkE4wBGmhPRYBv1E64J1EvJ
         HXS1vEWVdP2bwqwPD9AfcNjVlr2GB5o6N5REUaASL8Eljx47P8aDgp4Ik6hkbK+du+RQ
         UoFXbSSHBLjeYW+It/KIsr+8Nf7aBv3OraUfg=
Received: by 10.231.34.65 with SMTP id k1mr7826151ibd.9.1296027224237; Tue, 25
 Jan 2011 23:33:44 -0800 (PST)
Received: by 10.231.167.78 with HTTP; Tue, 25 Jan 2011 23:33:14 -0800 (PST)
In-Reply-To: <4D39C923.20202@workspacewhiz.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165506>

On Fri, Jan 21, 2011 at 12:57 PM, Joshua Jensen
<jjensen@workspacewhiz.com> wrote:
> I've always wished "git reset --hard" would tell me there are modifie=
d files
> and force me to type "git reset --hard --force" to overwrite them. =C2=
=A0It is a
> dangerous command, and I stupidly run it sometimes without running "g=
it
> status" first.

Something analogous to clean.requireForce?

j.
