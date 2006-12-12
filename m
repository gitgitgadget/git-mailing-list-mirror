X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: Collection of stgit issues and wishes
Date: Tue, 12 Dec 2006 09:43:52 +0000
Message-ID: <b0943d9e0612120143j7d0c1026rab046c8f44ec43ca@mail.gmail.com>
References: <20061208221744.GA3288@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 12 Dec 2006 09:44:08 +0000 (UTC)
Cc: "GIT list" <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fmwoAYoA3kVikl3tbJ7Dh5Em3Fu52fZS62kwVvx8iDXuFhT7pAQTusMQh4lTKHMjxX5oYnmS2EHmwTc6XYMpNMO6HGO9pmMSjhmGYSeeoLv5yxPXvhjifp9cBYw2N/dX7tTU+DYr8uvCJ2FenvxV2v7zElCWOqZvTSCDN0HHEAo=
In-Reply-To: <20061208221744.GA3288@nan92-1-81-57-214-146.fbx.proxad.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34073>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gu4B7-0004Il-0w for gcvg-git@gmane.org; Tue, 12 Dec
 2006 10:44:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751000AbWLLJnx (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 04:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751016AbWLLJnx
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 04:43:53 -0500
Received: from nz-out-0506.google.com ([64.233.162.232]:35568 "EHLO
 nz-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with
 ESMTP id S1751000AbWLLJnx (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec
 2006 04:43:53 -0500
Received: by nz-out-0102.google.com with SMTP id s1so951823nze for
 <git@vger.kernel.org>; Tue, 12 Dec 2006 01:43:52 -0800 (PST)
Received: by 10.65.219.5 with SMTP id w5mr7716911qbq.1165916632265; Tue, 12
 Dec 2006 01:43:52 -0800 (PST)
Received: by 10.65.126.2 with HTTP; Tue, 12 Dec 2006 01:43:52 -0800 (PST)
To: "Yann Dirson" <ydirson@altern.org>
Sender: git-owner@vger.kernel.org

On 08/12/06, Yann Dirson <ydirson@altern.org> wrote:
> - shortcuts (st -> status, etc.), possibly making use of the git alias
> system ?

Did this last night as it was pretty easy and without the GIT alias
system (which I am not familiar with). The idea is that if it cannot
find an exact match, it tries to look for all the commands starting
with the passed argument. If more than one command is found, it
reports an "ambiguous command".

-- 
