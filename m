From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv3 2/3] cvsimport: fix the parsing of uppercase config
 options
Date: Wed, 1 Dec 2010 11:01:40 -0600
Message-ID: <20101201170140.GG26120@burratino>
References: <cover.1291207768.git.git@drmicha.warpmail.net>
 <7vd3pmw9n5.fsf@alter.siamese.dyndns.org>
 <b61288036e756c78709438491416d573459a732e.1291207768.git.git@drmicha.warpmail.net>
 <AANLkTi=cb0i28oGi9vrYfEyU_fPHhQGhNNtramtCpCHy@mail.gmail.com>
 <20101201160503.GB26120@burratino>
 <m3aakp4g5o.fsf@localhost.localdomain>
 <20101201163406.GD26120@burratino>
 <4CF67D36.9020908@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Dec 01 18:01:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNq43-0003iB-D2
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 18:01:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754820Ab0LARBu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 12:01:50 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:56491 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752940Ab0LARBt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 12:01:49 -0500
Received: by vws16 with SMTP id 16so444088vws.19
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 09:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=mucyRvMIDVzvLxh3OhgnBwDUou8YeFu8EV0McFsbRbg=;
        b=dOfQ5JEuycimURC++O8nQHL3+2s1zoxb4LsNqAlrXzZANd/FB90SqZb6rM3crdchZi
         0pfaobafx8bjGjtmE2v4QWcJX6ihEqzdvT7X6lkwBVD1iEOg7eQCMsldy+Zcy8jgoTa/
         3P0nVKWuMa9X87pPsP99akqaZVFnFv08iY9rU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=tVJ8iMjdV5usB8NpHtIfQdAIoBr/G+SIUM4eG0OTlvyiED/hVmYCeEF+PmyFhCTEMg
         RrWlgkUBIiJQu/43qBgXhA9PecobBBzNPZwOQcjyYMuxEgQ4UTTdRJlOssosemNyjZdn
         hEWhQ5qiO6TLXY3+ImQzXa55Ud7Sc5qwp9uHE=
Received: by 10.220.179.205 with SMTP id br13mr49488vcb.178.1291222908829;
        Wed, 01 Dec 2010 09:01:48 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id c40sm51680vcs.1.2010.12.01.09.01.46
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 01 Dec 2010 09:01:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4CF67D36.9020908@drmicha.warpmail.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162550>

Michael J Gruber wrote:

> So you guys are going to break current behaviour (for "cvsimport.r" etc.)?

Actual git cvsimport users get the real vote.

But yes, I would like to break current behavior for cvsimport.r, since
the current behavior is insane.  On the other hand, I think it is fine
to preserve the current behavior for cvsimport.d.

Meanwhile we would get better documentation and self-describing
command lines:

	git cvsimport --cvshead=master --authors-file=$(pwd)/.git/cvs-authors \
		... etc ...

> I hate it when simple things get held up like this.

Perhaps it is a case of everyone knowing what an ugly shed is and thus
spending the time to make it a little better.

Anyway, feel free to ignore me in this case if you want.
Jonathan
