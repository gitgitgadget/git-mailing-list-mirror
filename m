From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH] Re: Clarify documentation on the "ours" merge strategy.
Date: Sat, 14 Nov 2009 11:12:59 +0900
Message-ID: <20091114111259.6117@nanako3.lavabit.com>
References: <alpine.DEB.1.00.0911031047510.4985@pacific.mpi-cbg.de>
	<7vskckn5b4.fsf@alter.siamese.dyndns.org>
	<20091111213049.GJ27518@vidovic>
	<200911120037.11901.trast@student.ethz.ch>
	<7vvdhggote.fsf@alter.siamese.dyndns.org>
	<alpine.DEB.2.00.0911121034580.8825@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Baz <brian.ewins@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	<Johannes.Schindelin@gmx.de>, <B.Steinbrink@gmx.de>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Sat Nov 14 03:16:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N98BV-0006CW-U5
	for gcvg-git-2@lo.gmane.org; Sat, 14 Nov 2009 03:16:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754708AbZKNCQF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2009 21:16:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753952AbZKNCQF
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Nov 2009 21:16:05 -0500
Received: from karen.lavabit.com ([72.249.41.33]:34034 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753567AbZKNCQE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2009 21:16:04 -0500
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id CF7DF11B8AD;
	Fri, 13 Nov 2009 20:16:07 -0600 (CST)
Received: from 6820.lavabit.com (customer-148-233-239-23.uninet.net.mx [148.233.239.23])
	by lavabit.com with ESMTP id KHX6JFG0AUE6; Fri, 13 Nov 2009 20:16:07 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=GCP4HJ+n9udO/wR3MAoFwkfEbkSrJvaLY9H8AYQw0aShMVnKozerSaFwOLuV/7zEPLI4ynAWTgbGmcOeSOsQ1sbzEsZQupEeGSThMWYace+DcpcvMa6sMgR1DYRwKQc7PxmwDxhpC/RmZxcYKO8nFL6OGltKhJKCnleTfBO5gDM=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <alpine.DEB.2.00.0911121034580.8825@ds9.cixit.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132856>

Quoting Peter Krefting <peter@softwolves.pp.se>

> The web tree checkout script uses rebase to avoid introducing merge
> commits every time the blog comment is updated, as it in 99 % of cases
> is unrelated to any other changes found in the central repo.
>
> In the few cases where the blog comment update from the web tree
> conflicts with a change in the central repo, I want the "git pull
> --rebase" call to overwrite any changes in the central repo with my
> changes in the web tree (meaning that I would later have to manually
> re-delete the spam comments, but I can live with that).

That sounds like "-Xours" merge option that was discussed some time 
ago. See

    http://thread.gmane.org/gmane.comp.version-control.git/76650/focus=89021

I remember that Junio and Petr were against it because it would 
encourage a bad workflow. Dscho was against the syntax used to 
pass the options also.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
