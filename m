From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Numeric constants as strings
Date: Mon, 19 Feb 2007 11:02:53 +0000
Message-ID: <200702191103.00431.andyparkins@gmail.com>
References: <200702190916.35813.andyparkins@gmail.com> <slrnetitgs.sbe.mdw@metalzone.distorted.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Mark Wooding <mdw@distorted.org.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 19 12:03:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJ6Ib-0004UL-59
	for gcvg-git@gmane.org; Mon, 19 Feb 2007 12:03:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbXBSLDI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 06:03:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbXBSLDI
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 06:03:08 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:60493 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932071AbXBSLDF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 06:03:05 -0500
Received: by nf-out-0910.google.com with SMTP id o25so2391454nfa
        for <git@vger.kernel.org>; Mon, 19 Feb 2007 03:03:04 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=fm+95csRi4bI+pwOkSpWWBdrst6+wpFGkvZV57XElCzZ6/r+JXM8+ZnzFZqB0t1YG0eQvVN4XHNdGfmymqgwHNHcMOWHtc+ae2z4EoEsmPY6BiG5elYwaCcmdmPz7z2YOQk7XHYSwVpUAPi6fZCEv8eHChz7N1RYTJIUONwDvmM=
Received: by 10.82.187.16 with SMTP id k16mr10586635buf.1171882983630;
        Mon, 19 Feb 2007 03:03:03 -0800 (PST)
Received: from davejones ( [194.70.53.227])
        by mx.google.com with ESMTP id c10sm26120555nfb.2007.02.19.03.03.01;
        Mon, 19 Feb 2007 03:03:01 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <slrnetitgs.sbe.mdw@metalzone.distorted.org.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40119>

On Monday 2007 February 19 10:04, Mark Wooding wrote:

> #define STRINGIFY(foo) STRINGIFY_REALLY(foo)
> #define STRINGIFY_REALLY(foo) #foo
>   printf("%-" STRINGIFY(HASH_WIDTH_ASCII) "s %s%s (%d subtrees)\n",

Ah ha!  Magical.  You've taught me something there.  Thanks.


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
