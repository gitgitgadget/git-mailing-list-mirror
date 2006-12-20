X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [RFC/PATCH] Implement poor-man's submodule support in pre-commit hook
Date: Wed, 20 Dec 2006 12:11:07 +0000
Message-ID: <200612201211.10163.andyparkins@gmail.com>
References: <200612200901.30584.andyparkins@gmail.com> <200612201008.49045.andyparkins@gmail.com> <emb8ev$egb$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 20 Dec 2006 12:11:28 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=dxwfKGAhoM5c7Tgo9r7+bm9p+N3tWHlXkgNs4TCrysUxw8hssFJqhLKn6QFzVo5hvSZXIBmOd9LzsRkAIviDY1KCYD/Tod18KPNv60/4pEF408v+PjhSBNonAOV4tVtndUCLPfbQorzMS0E5IPtC2BOe58Zf4LGN3YbeWN+tFaQ=
User-Agent: KMail/1.9.5
In-Reply-To: <emb8ev$egb$1@sea.gmane.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34922>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gx0I5-0001rA-T2 for gcvg-git@gmane.org; Wed, 20 Dec
 2006 13:11:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752313AbWLTMLS (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 07:11:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754806AbWLTMLS
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 07:11:18 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:32851 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1752313AbWLTMLR (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec
 2006 07:11:17 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2202612uga for
 <git@vger.kernel.org>; Wed, 20 Dec 2006 04:11:16 -0800 (PST)
Received: by 10.66.232.11 with SMTP id e11mr10404396ugh.1166616675563; Wed,
 20 Dec 2006 04:11:15 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id 59sm12550575ugf.2006.12.20.04.11.14; Wed, 20 Dec 2006 04:11:15 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Wednesday 2006 December 20 11:59, Jakub Narebski wrote:

> Do you want "git rev-parse --show-prefix" or "git rev-parse --show-cdup",
> or "git rev-parse --git-dir" perhaps? (Although here rev in rev-parse is
> misnomer).

--show-cdup was the one.  Thanks so much.  I tried git-var, never even thought 
of git-rev-parse.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
