X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Re: git and bzr
Date: Thu, 30 Nov 2006 09:30:33 +0000
Message-ID: <200611300930.33537.alan@chandlerfamily.org.uk>
References: <45357CC3.4040507@utoronto.ca> <456E8147.9070304@gmx.net> <fcaeb9bf0611300101s51a53b75lc7e771b067ba6e33@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 30 Nov 2006 09:30:59 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.5
In-Reply-To: <fcaeb9bf0611300101s51a53b75lc7e771b067ba6e33@mail.gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32712>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpiFd-000787-Ek for gcvg-git@gmane.org; Thu, 30 Nov
 2006 10:30:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759225AbWK3Jai (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 04:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759226AbWK3Jai
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 04:30:38 -0500
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk
 ([82.44.22.127]:14546 "EHLO home.chandlerfamily.org.uk") by vger.kernel.org
 with ESMTP id S1759225AbWK3Jah (ORCPT <rfc822;git@vger.kernel.org>); Thu, 30
 Nov 2006 04:30:37 -0500
Received: from kanger.home ([192.168.0.21]) by home.chandlerfamily.org.uk
 with esmtp (Exim 4.63) (envelope-from <alan@chandlerfamily.org.uk>) id
 1GpiFY-000470-IC for git@vger.kernel.org; Thu, 30 Nov 2006 09:30:36 +0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Thursday 30 November 2006 09:01, Nguyen Thai Ngoc Duy wrote:
> On 11/30/06, Raimund Bauer <ray007@gmx.net> wrote:
> > * Carl Worth wrote, On 30.11.2006 01:05:
> > > Let's help people do exactly that by making the behavior of "git
> > > commit -a" be the default for "git commit".
> >
> > Maybe we could do that _only_ if the index matches HEAD, and otherwise
> > keep current behavior?
>
> I hate the if clause. Suppose I prefer update-index way, I would have
> to check whether HEAD matches index everytime I do a commit to make
> sure it won't do the other way.

No you won't.   

If you don't use update-index, then index will match HEAD and you will commit 
changes in the working tree.  That is the way for newbies

As soon as you do the first update-index the index will no longer match HEAD, 
so commit will do the same as it does now.

And if you are not sure which you have done then presumably you do what you do 
now, or git commit -a or git commit -i as you need.

-- 
Alan Chandler
