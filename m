X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Use new .git/config for storing "origin" shortcut repository
Date: Sun, 26 Nov 2006 08:56:01 +0000
Message-ID: <200611260856.03057.andyparkins@gmail.com>
References: <ekafpm@sea.gmane.org> <200611260003.31025.andyparkins@gmail.com> <Pine.LNX.4.63.0611260141390.30004@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 26 Nov 2006 08:58:57 +0000 (UTC)
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=lawK47QQyOWApXrT0vVBiPWH+3DfAzjLlumvQv0n7AfYlntFZ32qOD6bT5UIeNSjmhgQMAu/t4GUyAC1haxDK8MhsnsM+Gpd/9MrLqzV4SHlB9p767S4JKjGQ2hKX4JL6DXulbTrxEXlDOT3gifbc4pUXzZuct8boe3lTfv1CF0=
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.63.0611260141390.30004@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32334>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoFqg-0001Oa-T8 for gcvg-git@gmane.org; Sun, 26 Nov
 2006 09:58:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967346AbWKZI6t (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 26 Nov 2006
 03:58:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967344AbWKZI6t
 (ORCPT <rfc822;git-outgoing>); Sun, 26 Nov 2006 03:58:49 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:9029 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S967346AbWKZI6t
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 26 Nov 2006 03:58:49 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1807823nfa for
 <git@vger.kernel.org>; Sun, 26 Nov 2006 00:58:48 -0800 (PST)
Received: by 10.78.41.7 with SMTP id o7mr12069527huo.1164531527747; Sun, 26
 Nov 2006 00:58:47 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164]) by
 mx.google.com with ESMTP id 39sm19233420hui.2006.11.26.00.58.47; Sun, 26 Nov
 2006 00:58:47 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Sunday 2006, November 26 00:48, Johannes Schindelin wrote:

> This hunk is wrong: "git-repo-config remote.bla.fetch b" will _overwrite_
> remoter.bla.fetch. To avoid that, you have to use "git repo-config
> remote.bla.fetch b ^$". (The last argument is a regular expression which
> has to be matched by the value-to-be-oreplaced.)

This is in git-clone; the config is empty.  What is there to overwrite?

I'll fix it anyway.


Andy

-- 
Dr Andrew Parkins, M Eng (Hons), AMIEE
