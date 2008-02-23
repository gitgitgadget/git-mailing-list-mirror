From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Better chopping in commit search results
Date: Sat, 23 Feb 2008 11:20:18 +0100
Message-ID: <200802231120.19448.jnareb@gmail.com>
References: <7vbq6kprql.fsf@gitster.siamese.dyndns.org> <20080222163035.5942.93410.stgit@localhost.localdomain> <20080223092722.GB1390@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Karl =?iso-8859-1?q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Sat Feb 23 11:21:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSrVW-0005cf-NX
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 11:21:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757713AbYBWKU3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Feb 2008 05:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756942AbYBWKU3
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 05:20:29 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:17667 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756429AbYBWKU1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 05:20:27 -0500
Received: by ug-out-1314.google.com with SMTP id z38so117398ugc.16
        for <git@vger.kernel.org>; Sat, 23 Feb 2008 02:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=UE6CdNP0Jo4gQxIPmzPYd/u3vHYjLYSrGkdgBfeOSAM=;
        b=I9/KqahYcj5ErYrnE2u/20jjo+EYNPeuV049fAAMTJk5AzhDdtoNS91UmGA7Kf389sMJDHhzE1GcyAobh/3k+RwvBaWwVoAXAhgLbNDnDK5slXMEtP/VOw4ZXqvqaLzC3S+W8mw8tLHDE42TQbwltVHH3XxbqTk8SJWDrJ8fmc0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=nCaZSAv8STDOW2BQD0lgtfABXA7J848Qgeq+YDiyf1XBgQU1yRwvqZS7HeCDtGxPutGPKiyIo2b1LKcwhcTHSXFMa1QgEide8bO75RiFUlAnt0cw0Wav6qwlU90KPgFIxnNLOgfEAdOsQRq4XrWC2xIMOellmMGEbJXYeO6mSpA=
Received: by 10.67.95.4 with SMTP id x4mr276009ugl.26.1203762025979;
        Sat, 23 Feb 2008 02:20:25 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.255.83])
        by mx.google.com with ESMTPS id q40sm901466ugc.70.2008.02.23.02.20.23
        (version=SSLv3 cipher=OTHER);
        Sat, 23 Feb 2008 02:20:24 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20080223092722.GB1390@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74813>

On Sat, 23 Feb 2008, Karl Hasselstr=F6m wrote:
> On 2008-02-22 17:33:47 +0100, Jakub Narebski wrote:
>=20
> > Strange that StGit always sends patches (stg mail) as if repo owner
> > was their author, regardless of path/commit author (I think; unless
> > "stg edit" cannot change authorship).
>=20
> It'll always put the sender in the From: header in the mail,
> obviously. But the patch mail template contains a "%(fromauth)s"
> string, which will be replaced by "From: Real Author
> <ra@example.com>\n", or the empty string if the patch author is the
> same as the sender.
>=20
> Your problem might be that you're using an old template.

Thanks a lot. That was it.

--=20
Jakub Narebski
Poland
