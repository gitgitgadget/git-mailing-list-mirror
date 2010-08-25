From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v5 2/5] merge: Make '--log' an integer option for
 number of shortlog entries
Date: Wed, 25 Aug 2010 10:20:06 +0530
Message-ID: <20100825045003.GB3280@kytes>
References: <1282494398-20542-1-git-send-email-artagnon@gmail.com>
 <1282494398-20542-3-git-send-email-artagnon@gmail.com>
 <20100823222542.GD1308@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Yaroslav Halchenko <debian@onerussian.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 25 06:52:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo7yC-0001PQ-1a
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 06:52:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752627Ab0HYEwB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Aug 2010 00:52:01 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:33060 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751869Ab0HYEwA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Aug 2010 00:52:00 -0400
Received: by yxg6 with SMTP id 6so43907yxg.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 21:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=jdFc2Yq2P7zI8XUjphiBPGBHVWE68gWku8JWQ6Yq2fo=;
        b=o3wuSs19yfEK32UWnNAsX6e9ogam82oKUDUCHFdBtAfxosAlXK7x0xGfhbHU4teU4o
         gBR6tB9a+dqX0b5ApwjsffYAzTOPCWeY2rgGcr3S+DCpUd8d8g2bJ2A7hq1z6UhtreRI
         Y9FujS8PmGf+u1JOk9/QaKdvaKMqlsZrtSnMM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=GMeqTj/f+rZhyuTpHb3yanYcxoLpiuLIelMrxjwtRuFWHJjNysISJ9QIsKR96BY7fD
         6bh8zDssJwWCY4EbOebDiyzKE5FoAfDPg2E1NkQjNElZD1pIF06uXBteOjcIJd6eICHE
         6SEiklBppL1akUH85jRMxJrzN/Hkv7cK78d2M=
Received: by 10.100.209.9 with SMTP id h9mr8380372ang.189.1282711919212;
        Tue, 24 Aug 2010 21:51:59 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id h5sm1323695anb.28.2010.08.24.21.51.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Aug 2010 21:51:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100823222542.GD1308@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154416>

Hi Jonathan,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
> 
> >  Documentation/git-fmt-merge-msg.txt |   10 +++++-----
> >  Documentation/merge-options.txt     |    6 +++---
> >  builtin/fmt-merge-msg.c             |   25 ++++++++++++++-----------
> >  builtin/merge.c                     |   18 ++++++++++--------
> >  4 files changed, 32 insertions(+), 27 deletions(-)
> 
> Is this on top of "next"?  I had trouble applying it on top of the
> update-contrib-example-merge topic.
[...]

Due to an unfortunate mistake on my part, it's based on `pu`. I'll fix
all the issues you pointed out and re-roll on top of rr/fmt-merge-msg
later today. Thanks.

-- Ram
