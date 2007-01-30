From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Why is git clone not checking out files?
Date: Tue, 30 Jan 2007 20:18:42 +0100
Message-ID: <200701302018.43119.jnareb@gmail.com>
References: <17855.35058.967318.546726@lisa.zopyra.com> <200701301950.00195.jnareb@gmail.com> <Pine.LNX.4.64.0701301058250.3611@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Bill Lear <rael@zopyra.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jan 30 20:18:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HByUb-0000G8-Gb
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 20:18:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751670AbXA3TRa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 30 Jan 2007 14:17:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751680AbXA3TR3
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 14:17:29 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:56718 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751669AbXA3TR2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 14:17:28 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1623289uga
        for <git@vger.kernel.org>; Tue, 30 Jan 2007 11:17:26 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=K26V1zSFA3RdVtu+fnmJ6FNdcaVDOOOTqun4Wf3udr15j+nBm4dmvzuLgVp1tRQWt9BI9JIiDNZDkUCPDI8mNNn89njw3FR7UOTbRB3NRAp2x4G2zR5vkSm4JKMOm3v0eg2aw878b73pNXrEY9e9AqyHatBvcj5gNBis88ryzZM=
Received: by 10.67.97.7 with SMTP id z7mr10335491ugl.1170184646523;
        Tue, 30 Jan 2007 11:17:26 -0800 (PST)
Received: from host-81-190-29-4.torun.mm.pl ( [81.190.29.4])
        by mx.google.com with ESMTP id e1sm10905040ugf.2007.01.30.11.17.25;
        Tue, 30 Jan 2007 11:17:26 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.64.0701301058250.3611@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38192>

Linus Torvalds wrote:

> Anyway, it's certainly easy to fix. Bill, you can either:
>=20
> =A0- just rename the "topic" branch to "master"
>=20
> =A0- change the HEAD to point to "topic" rather than "master".

Or, in repository you clone from, do "git pull . topic" when
on master, and you will have 'master' branch for your own work,
which would be fast-forward of 'topic'.

--=20
Jakub Narebski
Poland
