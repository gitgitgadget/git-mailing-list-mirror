X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Fast access git-rev-list output: some OS knowledge required
Date: Wed, 6 Dec 2006 20:34:31 +0100
Message-ID: <e5bfff550612061134r3725dcbu2ff2dd6284fcd651@mail.gmail.com>
References: <e5bfff550612061124jcd0d94em47793710866776e7@mail.gmail.com>
	 <20061206192800.GC20320@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 6 Dec 2006 19:34:44 +0000 (UTC)
Cc: "Git Mailing List" <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DAUa16phKq78LwI4W4QRwYD9qzAlQB7w9gLZ7k9mLblK1d6Iio0el0qaFtrzU0s8NL+u2EQxo6Fj1RClyxOuFPSCs6yXsLuLQONpt77MdJlVA3iUdDaG7fH7asiR1c52acOeoX8qV/qYI3pagM+UWMaxXcOOaGj1N0Ir70T+QQU=
In-Reply-To: <20061206192800.GC20320@spearce.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33511>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gs2XM-0002CM-1I for gcvg-git@gmane.org; Wed, 06 Dec
 2006 20:34:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937460AbWLFTed (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 14:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937503AbWLFTed
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 14:34:33 -0500
Received: from nz-out-0506.google.com ([64.233.162.233]:58121 "EHLO
 nz-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with
 ESMTP id S937469AbWLFTec (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec
 2006 14:34:32 -0500
Received: by nz-out-0102.google.com with SMTP id s1so200287nze for
 <git@vger.kernel.org>; Wed, 06 Dec 2006 11:34:31 -0800 (PST)
Received: by 10.35.129.19 with SMTP id g19mr2080240pyn.1165433671713; Wed, 06
 Dec 2006 11:34:31 -0800 (PST)
Received: by 10.35.93.11 with HTTP; Wed, 6 Dec 2006 11:34:31 -0800 (PST)
To: "Shawn Pearce" <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

On 12/6/06, Shawn Pearce <spearce@spearce.org> wrote:
> Marco Costalba <mcostalba@gmail.com> wrote:
> > The time it takes to read, without processing, the whole Linux tree
> > with this approach it's almost _double_ of the time it takes 'git
> > rev-list' to write to a file:
> >
> > 3) Other suggestions?  ;-)
>
> The revision listing machinery is fairly well isolated behind some
> pretty clean APIs in Git.  Why not link qgit against libgit.a and
> just do the revision listing in process?
>

Where can I found some documentation (yes I know RTFS, but...) or,
better, an example of using the API to read git-rev-list output?

if it is possible I also would like to avoid to mess with internal git
API's, of course *if it is possible*  ;-)

Thanks
