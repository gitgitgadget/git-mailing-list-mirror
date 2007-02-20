From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Change "refs/" references to symbolic constants
Date: Tue, 20 Feb 2007 09:42:17 +0000
Message-ID: <200702200942.18654.andyparkins@gmail.com>
References: <200702191839.05784.andyparkins@gmail.com> <7vlkit7vy5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 20 10:42:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJRWE-0003Zp-FB
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 10:42:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932796AbXBTJmZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Feb 2007 04:42:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbXBTJmZ
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Feb 2007 04:42:25 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:8902 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932796AbXBTJmY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Feb 2007 04:42:24 -0500
Received: by nf-out-0910.google.com with SMTP id o25so2689351nfa
        for <git@vger.kernel.org>; Tue, 20 Feb 2007 01:42:23 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Rztgqj7phnHQuM5gf9KktvnYunBCLt3rMPBP6xme/9EiNbzzxxXG/C8Tj7H/zFWa3wj6kjH/bRnSqAFiK7HY5pBpM2T1JUPu3iQPEurOFWmAJzSP3TckNyNNjk4CBe/NtHMMBktfz7YUrD21JZptctMh+6qGDSajj0LHSE6SiJc=
Received: by 10.49.55.13 with SMTP id h13mr6616861nfk.1171964543048;
        Tue, 20 Feb 2007 01:42:23 -0800 (PST)
Received: from davejones ( [194.70.53.227])
        by mx.google.com with ESMTP id x1sm30007571nfb.2007.02.20.01.42.20;
        Tue, 20 Feb 2007 01:42:21 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <7vlkit7vy5.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40217>

On Monday 2007 February 19 20:07, Junio C Hamano wrote:

> > -	if (!strncmp(path, "refs/tags/", 10)) {
> > +	if (!strncmp(path, PATH_TAGS, STRLEN_PATH_TAGS)) {
> >  		if (object->type == OBJ_TAG)
> >  			prio = 2;
> >  		else
>
> This is PATH_REFS_TAGS isn't it?

I'm uncomfortable that this one managed to get through; in view of this 
mistake if you are thinking of applying this - don't.  I'm going to review 
the patch itself line by line.

Also - I should learn how to run the tests - is "make test" good enough or is 
there something special I should do?


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
