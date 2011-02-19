From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH 0/3] Thinning the git toplevel directory
Date: Fri, 18 Feb 2011 18:50:30 -0600
Message-ID: <20110219005030.GB27316@elie>
References: <7vmxm4onwk.fsf@alter.siamese.dyndns.org>
 <1297304069-14764-1-git-send-email-pclouds@gmail.com>
 <20110218022701.GA23435@elie>
 <AANLkTik8wUrUnjTiUxUZbg3paaQEc7UERQ6J6jUzA2u5@mail.gmail.com>
 <20110218092518.GB30648@elie>
 <4D5F0A7C.1080507@gmail.com>
 <7v39nkooem.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 19 01:50:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pqb22-0002Qo-8l
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 01:50:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753199Ab1BSAui (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Feb 2011 19:50:38 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38744 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752942Ab1BSAug (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Feb 2011 19:50:36 -0500
Received: by iwn8 with SMTP id 8so8457iwn.19
        for <git@vger.kernel.org>; Fri, 18 Feb 2011 16:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=bXNNbUNP/ykhQ8iojSt8LFA6uESkF129h2wq2CqJOF0=;
        b=Ki8PNuYYlEurtX4HAQV8Mf1Ia6wqXHKSE5RGkruZQWy5Dr9az2W/bdm9n+BmCMriCL
         8ygDaKc3xnAfTnUE4zfoRUuWBgZmbnsXnaobyYDlrvWgUjkk5iQ6CpozSgWWRhaQeTJz
         708cAIPM3fkEESZ80rpm5mfOq4R1LgT/u/1Ew=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=j6dlSN9/wfEbqhigAQBbuo9t2fJFq0Ok5iE1xwK6iXU4igRGHtkLY9zIzKmGVuPnt9
         ZaZPAPFdfuxW9fQdZEk/iq/evpHePrqEJ2z/6KF61omuyN6CoW5eplv32HPuMn/XK+Zi
         hngCyFWI/TcOUQ+dWPA1H5Wex9ZL81lR4Rlfw=
Received: by 10.231.11.68 with SMTP id s4mr1001324ibs.14.1298076636370;
        Fri, 18 Feb 2011 16:50:36 -0800 (PST)
Received: from elie (adsl-69-209-72-148.dsl.chcgil.ameritech.net [69.209.72.148])
        by mx.google.com with ESMTPS id 8sm2202434iba.22.2011.02.18.16.50.34
        (version=SSLv3 cipher=OTHER);
        Fri, 18 Feb 2011 16:50:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7v39nkooem.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167240>

Junio C Hamano wrote:
> Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:

>> - build result - objects, final binaries, generated documentation etc 
>>   The advantage besides unclutterting is possibility to have sources on
>>   read-only medium.
>
> This is somewhere between a meh to mild nak.  "git grep" knows to ignore
> untracked cruft, so this does not help nor hinder "finding" at all. Even
> though I personally tend to value seeing frotz.o sitting immediately next
> to frotz.c, some people may value read-only source tree more than that.

At the risk of becoming repetitive: it is quite possible for make to
take an O=elsewhere/ parameter to support both types.

I am also in the camp of preferring to see frotz.o next to frotz.c.
After editing frotz.c, I can do "make frotz.o" to make sure it still
compiles.
