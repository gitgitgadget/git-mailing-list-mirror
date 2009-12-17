From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: diff attribute ignored by show and log -p
Date: Thu, 17 Dec 2009 22:17:40 +0900
Message-ID: <20091217221740.6117@nanako3.lavabit.com>
References: <76718490912162046k36e2a275gaf7672b38c7a63e4@mail.gmail.com> <76718490912162123r49f9bd90n8e032c144d0cdbac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 17 14:18:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLGFF-0001me-3i
	for gcvg-git-2@lo.gmane.org; Thu, 17 Dec 2009 14:18:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764689AbZLQNSL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2009 08:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764629AbZLQNSL
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Dec 2009 08:18:11 -0500
Received: from karen.lavabit.com ([72.249.41.33]:54244 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764342AbZLQNSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2009 08:18:09 -0500
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id A84B011B7C1;
	Thu, 17 Dec 2009 07:18:05 -0600 (CST)
Received: from 3690.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id BY72JBYLRVAO; Thu, 17 Dec 2009 07:18:05 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=vEBpgOZmmPV8E3BcfE7Pk2gj5479KvFz8pkDsOl5hjLrNefjpj2LJZIPo0r/PlADqtglBu9Tf03UkKtu8ing1X07z4/C0pjNFjXpfecxq6ePoWdFPJjUJzzheQvCKY/zwn0Pq5od5dUi0pBIOcrkqhiAHOHEIIYBKECO9MkhQBM=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <76718490912162123r49f9bd90n8e032c144d0cdbac@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135371>

Quoting Jay Soffian <jaysoffian@gmail.com>

>> But is apparently ignored by "git log -p" and "git show" which just
>> use internal diff. Is this behavior intentional?
>
> Ah, --ext-diff, and the reasoning behind requiring it for log/show is
> explained in 72909be.

The need to give --ext-diff is mentioned in 72909be (Add diff-option
--ext-diff, 2007-06-30) but its log message doesn't 'explain' why external
diff isn't used by default and you need to pass that extra option.

Probably --ext-diff should be the default?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
