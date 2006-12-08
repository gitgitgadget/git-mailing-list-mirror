X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH] Install git-sh-setup.sh into $(prefix)/share/git-core. Call with explicit path.
Date: Sat, 9 Dec 2006 02:11:03 +0700
Message-ID: <fcaeb9bf0612081111h53699ecbr5fb72e17526993d5@mail.gmail.com>
References: <elc6g3$v1m$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 8 Dec 2006 19:11:13 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=T8fIsvJIz6G1jXiasGRAAwEfLiFL7iX5mR/l+gOyqk12hoXx1xSc4wxTQW4kP3Mnbt5O4KeJsbMDZz4kYFaJ4gjDwUqDtUlmzRpCa1zrsOEZFQjid27tDQyB958TTVBczEa5bBGIcJtMozxBhKVpNa/clPUOItrNVQspc1Z3gv0=
In-Reply-To: <elc6g3$v1m$1@sea.gmane.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33721>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gsl7n-0006d7-Dl for gcvg-git@gmane.org; Fri, 08 Dec
 2006 20:11:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967775AbWLHTLH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 14:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968827AbWLHTLG
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 14:11:06 -0500
Received: from wr-out-0506.google.com ([64.233.184.231]:32019 "EHLO
 wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S967775AbWLHTLF (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec
 2006 14:11:05 -0500
Received: by wr-out-0506.google.com with SMTP id i7so1112490wra for
 <git@vger.kernel.org>; Fri, 08 Dec 2006 11:11:05 -0800 (PST)
Received: by 10.78.201.15 with SMTP id y15mr1787637huf.1165605063332; Fri, 08
 Dec 2006 11:11:03 -0800 (PST)
Received: by 10.78.118.16 with HTTP; Fri, 8 Dec 2006 11:11:03 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On 12/9/06, Han-Wen Nienhuys <hanwen@xs4all.nl> wrote:
>
> git-sh-setup isn't a 'normal' binary, in that it should be called by
> bash only and not run in a subshell. Therefore, it should not be installed
> in a executable directory, but rather in $prefix/share/git-core/

Executables should not go to $prefix/share I think. Maybe $prefix/libexec?
BTW, I think you touched a larger issue: plumbling/porcelain separation.
-- 
