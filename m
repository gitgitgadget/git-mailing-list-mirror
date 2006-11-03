X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 7/n] gitweb: Output also empty patches in "commitdiff" view
Date: Fri, 3 Nov 2006 12:56:37 +0100
Message-ID: <200611031256.37927.jnareb@gmail.com>
References: <200610301953.01875.jnareb@gmail.com> <200610311736.27910.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 3 Nov 2006 11:56:33 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ssh3NS03NUB3T+fLCxmbOOfuo8T+cuCZA64P9bmsCnk8sUAKnVIQxakPcOm0dnaZ4RGh+qm5W9tURj17/aI5xAy7RS3Kt1TmTpSoeYCX4EFEh6POSuxEfzlxTlI802fpLajSVtwPk6+uLz2qLLyzT7PIOV1oJC6FbpDajI2R704=
User-Agent: KMail/1.9.3
In-Reply-To: <200610311736.27910.jnareb@gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30831>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gfxep-0005ma-PQ for gcvg-git@gmane.org; Fri, 03 Nov
 2006 12:56:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750991AbWKCL4U (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 06:56:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751010AbWKCL4U
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 06:56:20 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:19495 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1750956AbWKCL4U
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 06:56:20 -0500
Received: by ug-out-1314.google.com with SMTP id m3so384538ugc for
 <git@vger.kernel.org>; Fri, 03 Nov 2006 03:56:18 -0800 (PST)
Received: by 10.66.244.10 with SMTP id r10mr2528591ugh.1162554978447; Fri, 03
 Nov 2006 03:56:18 -0800 (PST)
Received: from host-81-190-18-116.torun.mm.pl ( [81.190.18.116]) by
 mx.google.com with ESMTP id h1sm753989ugf.2006.11.03.03.56.17; Fri, 03 Nov
 2006 03:56:18 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Jakub Narebski wrote:
> Remove skipping over empty patches (i.e. patches which consist solely
> of extended headers) in git_patchset_body, and add links to those
> header-only patches in git_difftree_body (but not generate blobdiff
> links when there were no change in file contents).

Attention: I think this patch causes that in some cases gitweb generates
incorrect HTML (one of <div> elements is not closed).
-- 
Jakub Narebski
