X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: What's in git.git (stable)
Date: Thu, 14 Dec 2006 10:21:11 +0000
Message-ID: <200612141021.12637.andyparkins@gmail.com>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net> <200612132237.10051.andyparkins@gmail.com> <Pine.LNX.4.63.0612140116430.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 14 Dec 2006 10:21:24 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=akUw+WD8S7NXf/Ib7MuDUFDGLERAXtjIn8K6F/s0o1pz+f4IiRlSqqCxaStViNwHdgHB5y7R++gpVfI/SfOK6JKWBnHOAbFPfbWCg2HizKnk8Eh3GnXtmDK00HjfkxAZHM4f6QtNr4ybnvEL1X92ytyj7+NPtZzHJ5ZN5uj5cOI=
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.63.0612140116430.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34299>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuniM-0005HN-B4 for gcvg-git@gmane.org; Thu, 14 Dec
 2006 11:21:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751846AbWLNKVS (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 05:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751848AbWLNKVS
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 05:21:18 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:53359 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1751846AbWLNKVR (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec
 2006 05:21:17 -0500
Received: by ug-out-1314.google.com with SMTP id 44so450216uga for
 <git@vger.kernel.org>; Thu, 14 Dec 2006 02:21:16 -0800 (PST)
Received: by 10.66.219.11 with SMTP id r11mr1142230ugg.1166091676383; Thu, 14
 Dec 2006 02:21:16 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id j33sm1843470ugc.2006.12.14.02.21.15; Thu, 14 Dec 2006 02:21:15 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Thursday 2006 December 14 00:22, Johannes Schindelin wrote:

> >  * git-revert should be called git-invert.  It doesn't remove a change
> >    from history, it simply applies another commit that does the
> >    opposite of whatever commit you are "revert"ing.  That's an inversion.
>
> No. An inversion is the _opposite_. Not an undo.

That's what I'm saying, we are applying the opposite of the given commit - 
that commit is being inverted and applied again.  It most certainly isn't an 
undo, because the original commit still exists.  It's not a reversion 
because "reversion" is to regress to a previous time or state.  In that sense 
git-revert is not doing what it says on the tin.  A revert would be to remove 
all the revisions from now until the specified commit - i.e. what git-reset 
now does.

(Note: I don't think git-reset should be renamed, as it's possible to use 
git-reset to move a branch forward as well as backward).

> Besides, The fact that revert _adds_ to history is a nice way to
> document that you reverted that change. And you can even explain in the
> commit message, why you did it.

I'm not disputing that the /operation/ is useful, I'm arguing that it is 
incorrectly named.

> IMHO it is better for a newbie to see that _something_ is happening. A

I'm not arguing that we should show nothing; I'm arguing that the something we 
do show should be more clear than what is now shown.  The choice is 
therefore "show something confusing" or "show something clear".

> newbie cannot, and does not want to, understand exactly what is going on.

"newbie" doesn't mean "idiot".  Everybody wants to understand what is going 
on.

> So, think of it as our response to Windows' non-progress-bar: when you
> start up Windows, there is a progress-bar, except that it does not show
> progress, but a Knight Rider like movement, only indicating that it does
> something.

Given the choice between nothing and a non-progress "doing something" bar, I 
would of course pick the "doing something" bar.  However, given the choice 
between a "doing something" bar and a progress bar, I'd rather have the 
progress bar.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
