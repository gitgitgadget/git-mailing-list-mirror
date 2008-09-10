From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Wed, 10 Sep 2008 10:10:07 +0200
Message-ID: <48C780DF.1070605@gnu.org>
References: <20080909132212.GA25476@cuci.nl> <20080909205003.GA3397@coredump.intra.peff.net> <200809100035.23166.jnareb@gmail.com> <200809100107.44933.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	"Stephen R. van den Berg" <srb@cuci.nl>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 10 10:11:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdKnK-0001cZ-6a
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 10:11:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbYIJIKP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 04:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbYIJIKO
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 04:10:14 -0400
Received: from gv-out-0910.google.com ([216.239.58.189]:27897 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258AbYIJIKN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 04:10:13 -0400
Received: by gv-out-0910.google.com with SMTP id e6so825277gvc.37
        for <git@vger.kernel.org>; Wed, 10 Sep 2008 01:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding:sender;
        bh=D8crbEGc1I+hNXoBVVoCOrm2qCCUxW8QmN1Bq5kTWUY=;
        b=vZf7snEy1CAyMRbGFopkfOHGoNgq4pqYR+wf9Xg4H1nlFYgVyWy1h6TYyLXo0nggL1
         /EUOAo70cwgp24C05NHQzPLvzcEEr28WqB0tHflVfejZKFPkt5j+ZrEpihVEYlokOV4a
         jbDMDIi+ETU2xkjJ5nd+55SYk6Nf7eqnLJaMo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :sender;
        b=cQ1nI1F5CrBI+cu1GprCqNzQsscRMLpNxpkVzyfWCg5ASZGt/9nw5R1J90vmEgz8y9
         b5b0Y+GMp0L2ku+VJWV+hqDyRJ5/pbCukziZPiHaxRtUSCClLyK5fX8LjvEpn9ZAZ2tx
         U5CUmaCxwWOPscS0PWGv3gNhxnt90JoxLA39o=
Received: by 10.86.80.17 with SMTP id d17mr693816fgb.24.1221034210019;
        Wed, 10 Sep 2008 01:10:10 -0700 (PDT)
Received: from scientist-2.mobile.usilu.net ( [195.176.179.202])
        by mx.google.com with ESMTPS id 4sm8152454fge.8.2008.09.10.01.10.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 10 Sep 2008 01:10:08 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Macintosh/20080707)
In-Reply-To: <200809100107.44933.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95495>

> By the way, beside graphical history viewers it would also help rebase
> (and git-cherry) notice when patch was already applied better.

I think that rebase had better not trust the origin links in deciding
whether a patch was already applied; it already does it well enough.

git-cherry is another story, as that tool is not faking "changeset mode"
so well (because it cannot attempt merges, and these are what allows
git-rebase to fake changesets much better).

Paolo
