X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: svn versus git
Date: Fri, 15 Dec 2006 00:10:15 +0700
Message-ID: <fcaeb9bf0612140910t6aff44e1m9570b20850a41b87@mail.gmail.com>
References: <200612132200.41420.andyparkins@gmail.com>
	 <20061213225627.GC32568@spearce.org>
	 <200612140908.36952.andyparkins@gmail.com>
	 <7vodq695ha.fsf@assigned-by-dhcp.cox.net>
	 <fcaeb9bf0612140708w6bc691f6k2e08fbab2a651421@mail.gmail.com>
	 <Pine.LNX.4.63.0612141630240.3635@wbgn013.biozentrum.uni-wuerzburg.de>
	 <fcaeb9bf0612140832v1c80bf7dgd61897111292d31@mail.gmail.com>
	 <Pine.LNX.4.63.0612141754420.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 14 Dec 2006 17:10:25 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dm/L4rxbzTRU7pf+XbEx6QS2fprhXt8x/vYn+yYkd2nCKAX8nfcyBHiA91f9PDhIBUfC1/UtFlHbEp8vWnSRj1pQxq7FzlYdd3n0LsNoMvpvHbKo3nVjjj5e7MPfU9dQG4+dnO2ZrrDU9ZZdoEG6IHs3JH9fF4+p7R/qLh9jzew=
In-Reply-To: <Pine.LNX.4.63.0612141754420.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34375>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Guu6B-0005k2-A9 for gcvg-git@gmane.org; Thu, 14 Dec
 2006 18:10:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750973AbWLNRKT (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 12:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750998AbWLNRKT
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 12:10:19 -0500
Received: from an-out-0708.google.com ([209.85.132.249]:35378 "EHLO
 an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1750997AbWLNRKR (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec
 2006 12:10:17 -0500
Received: by an-out-0708.google.com with SMTP id b33so186095ana for
 <git@vger.kernel.org>; Thu, 14 Dec 2006 09:10:17 -0800 (PST)
Received: by 10.78.97.7 with SMTP id u7mr879356hub.1166116215948; Thu, 14 Dec
 2006 09:10:15 -0800 (PST)
Received: by 10.78.100.8 with HTTP; Thu, 14 Dec 2006 09:10:15 -0800 (PST)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Hi,

On 12/14/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > - have you seen the patch for git-show today, which would include this
> > > functionality?
> >
> > I didn't. From the patch, it seems git-show can show the index via
> > ::file syntax. If so, I'd like withdraw my opinion. '::file' syntax is
> > not intuitive though. Perhaps you should mention that it can show
> > index (and how) in the git-show document
>
> Well, you can reference blobs that way, but not trees.

Oh, yeah. Isn't this a good oppotunity to add --index option to git-show?
git-show --index will show the index. git-show --index file will show
the file content. This makes git-show a little unconsistent though as
it may or may not require argument <object>.

Another option is treat '::' alone specially -- call git-ls-files.
-- 
