X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: Tracking a repository for content instead of history
Date: Wed, 13 Dec 2006 04:48:12 +0700
Message-ID: <fcaeb9bf0612121348q35549a4cof0adb85e0391b92c@mail.gmail.com>
References: <200612121235.09984.andyparkins@gmail.com>
	 <200612121326.24508.andyparkins@gmail.com>
	 <Pine.LNX.4.63.0612121527070.2807@wbgn013.biozentrum.uni-wuerzburg.de>
	 <200612121538.41197.andyparkins@gmail.com>
	 <fcaeb9bf0612121346s3c82bcdbh522c17f4ae9f279b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 12 Dec 2006 21:48:22 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TsEagFmLqI306AobX/BixsJXWhZaLWbns/g8kSea2Ssabhl9MuvGy2gQ1NmEPv0MDAGCMF4eaoWzcU78choRJ4PvMgBpZvZrH/Drw3N1HTs5Fm/O+85lvC67mr1kL9cNXAtOznWgil4Pkr34qmXCy/dUfyGsLGTq2ugM6hUZw5g=
In-Reply-To: <fcaeb9bf0612121346s3c82bcdbh522c17f4ae9f279b@mail.gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34148>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuFU1-0006Sz-Ub for gcvg-git@gmane.org; Tue, 12 Dec
 2006 22:48:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932447AbWLLVsP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 16:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932449AbWLLVsP
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 16:48:15 -0500
Received: from an-out-0708.google.com ([209.85.132.250]:19014 "EHLO
 an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S932447AbWLLVsO (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec
 2006 16:48:14 -0500
Received: by an-out-0708.google.com with SMTP id b33so465423ana for
 <git@vger.kernel.org>; Tue, 12 Dec 2006 13:48:13 -0800 (PST)
Received: by 10.78.117.10 with SMTP id p10mr41458huc.1165960092533; Tue, 12
 Dec 2006 13:48:12 -0800 (PST)
Received: by 10.78.100.8 with HTTP; Tue, 12 Dec 2006 13:48:12 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On 12/13/06, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> Hm.. I'm no git:// expert. But is it possible doing as follow?
> 1. git-archive <base>
> 2. reconstruct commit, blobs and trees from the archive
> 3. tell git server that you have one commit, you need another commit
> (maybe heads only, i'm not sure here)
> 4. get the pack from git server, create new commit and a diff

Ok. Stupid idea. The pack may base on objects that I don't have.

-- 
