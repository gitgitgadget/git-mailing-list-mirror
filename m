From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Numeric constants as strings
Date: Mon, 19 Feb 2007 10:14:21 +0000
Message-ID: <200702191014.23055.andyparkins@gmail.com>
References: <200702190916.35813.andyparkins@gmail.com> <7virdy8p25.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 19 11:14:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJ5Xc-0002Nn-9y
	for gcvg-git@gmane.org; Mon, 19 Feb 2007 11:14:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbXBSKOb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 05:14:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbXBSKOb
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 05:14:31 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:10647 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820AbXBSKOa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 05:14:30 -0500
Received: by nf-out-0910.google.com with SMTP id o25so2380210nfa
        for <git@vger.kernel.org>; Mon, 19 Feb 2007 02:14:29 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=NldjuMc5MzU5lOTWTyzikxeA7YvviSawXZyb/8HT57K9IvONku7LOVojKy57yKStkm1eNOVTkQmx/gIPtOSYoYjLwZZpEzrOrYt4EyVLlecm+gr1X36AWGwX0tJvuAQJ0uiLMx3BfNfwG03TDmkQgo1FuI967Lr17idCQiiAP1g=
Received: by 10.49.93.4 with SMTP id v4mr5543763nfl.1171880069526;
        Mon, 19 Feb 2007 02:14:29 -0800 (PST)
Received: from davejones ( [194.70.53.227])
        by mx.google.com with ESMTP id n22sm25916473nfc.2007.02.19.02.14.27;
        Mon, 19 Feb 2007 02:14:27 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <7virdy8p25.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40115>

On Monday 2007 February 19 09:38, Junio C Hamano wrote:

> > #define HASH_WIDTH_ASCII 40
> > -               printf("%-40s %s%s (%d subtrees)\n",
> > +               printf("%-" HASH_WIDTH_ASCII "s %s%s (%d subtrees)\n",
> >
> > This compiles, but I suspect that it's not going to do what I
> > want it to do.
>
> Doesn't writing "foo" "bar" (two string literals next to each other)
> tell the compiler to concatenate them?

It's not a string literal though.

It's
 #define HASH_WIDTH_ASCII 40
rather than
 #define HASH_WIDTH_ASCII "40"

I'm wondering how to turn the first into the second using the preprocessor.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
