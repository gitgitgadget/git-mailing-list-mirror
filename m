From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [RFC] origin link for cherry-pick and revert, and more about
 porcelain-level metadata
Date: Wed, 10 Sep 2008 17:24:35 +0200
Message-ID: <48C7E6B3.7030403@gnu.org>
References: <20080909132212.GA25476@cuci.nl> <20080909211355.GB10544@machine.or.cz> <20080909225603.GA7459@cuci.nl> <20080909230525.GC10360@machine.or.cz> <48C794D6.20001@gnu.org> <20080910143329.GE28210@dpotapov.dyndns.org> <20080910151542.GA10523@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Dmitry Potapov <dpotapov@gmail.com>, git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Wed Sep 10 17:26:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdRZq-0006k7-0Z
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 17:25:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752291AbYIJPYp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 11:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752204AbYIJPYo
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 11:24:44 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:33539 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752149AbYIJPYn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 11:24:43 -0400
Received: by gxk9 with SMTP id 9so13908722gxk.13
        for <git@vger.kernel.org>; Wed, 10 Sep 2008 08:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=o3EXB8/Hy1F3p0Rfu2m+lEDZ4r4MiwYA1IM+vAPc6vM=;
        b=ERopKXwMaC9AZG8+n4YUEfa1vNUMkQZI+2iPo/FU8GMBeB2iMOXkm85KlZFuAf53Xe
         RTxAmHwCPUbtnQdPUAfAH46lZsnwZksDwZEG+tTFw5Md4TbT5PU7b9BItuUIgFbpiC5l
         /oA0v83MQ+BU1nLpVpQpHgSoHvbbro2fa8mCU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding:sender;
        b=XIx7LtzN1R4sOFuy68hNY1j6bNwLmomUiuewNC8NrwQR2V9hXkftYhfWePODUuG9tb
         wMm0ry1xzTiePsfwlEjWIMjEZYB8Rc+VhTdKXKyaoQkTvGmrAGyzcDi/W26WxKEUlKAY
         +rvnQLWhem20njLrqxZyaPegA8pRu7YULehn4=
Received: by 10.86.100.19 with SMTP id x19mr1040942fgb.70.1221060281184;
        Wed, 10 Sep 2008 08:24:41 -0700 (PDT)
Received: from scientist-2.mobile.usilu.net ( [195.176.179.202])
        by mx.google.com with ESMTPS id d6sm7549044fga.2.2008.09.10.08.24.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 10 Sep 2008 08:24:40 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Macintosh/20080707)
In-Reply-To: <20080910151542.GA10523@cuci.nl>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95527>

> > > fork topic branches off the older branch [and merge them]
>
> Could you explain how the above mechanisms work based on the following
> cherry-pick action:
> 
> A -- B -- C -- D -- L
>       \            /
>        E -- F -- G -- H -- K
> 
> D is the stable branch.
> K is the development branch.
> G is cherry-picked and applied to D producing L.
> The origin link of L would have contained (G, F).
> 
> How would such a workflow be implemented using the temporary branches
> you describe?

You don't.  You do everything in topic branches based off the stable
branch, and you merge them.  That's the other way round, compared to
what you (and I) are used to.

Paolo
