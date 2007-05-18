From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [3/4] What's not in 1.5.2 (new topics)
Date: Fri, 18 May 2007 13:36:00 +0100
Message-ID: <200705181336.01563.andyparkins@gmail.com>
References: <200705170539.11402.andyparkins@gmail.com> <200705181040.37648.andyparkins@gmail.com> <20070518112202.GE4708@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Junio C Hamano <junkio@cox.net>, Nicolas Pitre <nico@cam.org>
To: git@vger.kernel.org, "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
X-From: git-owner@vger.kernel.org Fri May 18 14:36:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hp1hF-0000bo-LG
	for gcvg-git@gmane.org; Fri, 18 May 2007 14:36:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754977AbXERMgI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 08:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753170AbXERMgI
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 08:36:08 -0400
Received: from qb-out-0506.google.com ([72.14.204.237]:29987 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755127AbXERMgH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 08:36:07 -0400
Received: by qb-out-0506.google.com with SMTP id q11so601577qbq
        for <git@vger.kernel.org>; Fri, 18 May 2007 05:36:05 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=oF1SqBwGRVZfoo9rpX9uJ0UJXwFYZByB20wJBnl4ThpvFUAogWxvqq/beCCrEdYEoa6s8OGpGajOLSx517f7QurmPlWBrsQ/obuoAO6OE0nsTbLtqgibtGFnIwdZfESSQBndfauwWIxoMaRwimpOplhZNmYoGa1cPCW3DvbjoAk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=HY1CujqHKVUxIlEU5z2gJqhV4+o6i9EQCyO+71oZ2ulhxEvH3LjG99fEpoSsvrx0MyUYGTL7DRQHSq23p+jwTa6QCaYS1t/ChDEueLdzvYEWCTABZc1peHU84gHGq8IhOAG+YMLxV1gwJwszjpbIAjJtateHzI/afDklS+4Ag/Q=
Received: by 10.65.148.19 with SMTP id a19mr6253839qbo.1179491765400;
        Fri, 18 May 2007 05:36:05 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id z21sm3909103qbc.2007.05.18.05.36.03;
        Fri, 18 May 2007 05:36:04 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <20070518112202.GE4708@mellanox.co.il>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47603>

On Friday 2007 May 18, Michael S. Tsirkin wrote:

> Why is that? Content is what is important.  URLs are only a convenience
> measure to help clients find the content.  The link must have a commit
> hash, so git can *verify* that the content is correct. Where it comes from
> must be irrelevant.
>
> So if someone looks at my tree, and does not know where to get the content,
> he might want my hint on this.

True.  Hannes also pointed out that the trust comes from the hash contained in 
the gitlink that is in tree, there is no need to assign trust to the URL.

I withdraw my objection.


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
