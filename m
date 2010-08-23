From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 13/17] Documentation: remove stray backslash in
 show-branch discussion
Date: Mon, 23 Aug 2010 17:06:21 +0530
Message-ID: <20100823113618.GA14959@kytes>
References: <20100820101902.GA10356@burratino>
 <20100820103706.GM10407@burratino>
 <201008231318.30768.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	=?iso-8859-1?B?RnLpZOlyaWMgQnJp6HJl?= <fbriere@fbriere.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Aug 23 13:38:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnVM8-00062C-BK
	for gcvg-git-2@lo.gmane.org; Mon, 23 Aug 2010 13:38:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751470Ab0HWLiT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Aug 2010 07:38:19 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:64337 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329Ab0HWLiR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Aug 2010 07:38:17 -0400
Received: by pvg2 with SMTP id 2so2217239pvg.19
        for <git@vger.kernel.org>; Mon, 23 Aug 2010 04:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=srquQUJDIEbDuqzBCNL7XdVQYt3XBAltp3Ec3RLqFOw=;
        b=vTdaBv24bQCKK5BK6bldIgtWK9TaLQZuXEnuLjcWmSNOTXuPv/UweqiAkm3wJMpNOo
         UKDkfpviKfMZXapD6o/YBI+qs/CYm+oxMj+VlU9j4CfIBH4nYBcjqYu8+apA1vPi/uFP
         deXfV+iYtlZ9HIl0L2vV7nUvYiD/OHcXlqC28=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=gk9n8aTe9J1S/wmnZhRyayaUYOZeRtgszajtAsgnJBgA034XlJ0R0In6SJFG0macs5
         nUy71Yuc4n96dwWnOYQ3b4jEJwHUsGXfXBaIBPG5occksTaOYvY/ry3gTGyaeOP9Sxlx
         z1RSTjTW+axEJSj4hUPm0w1uCGWOuum99OMn4=
Received: by 10.142.222.8 with SMTP id u8mr3793284wfg.214.1282563497555;
        Mon, 23 Aug 2010 04:38:17 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id v38sm8392642wfh.0.2010.08.23.04.38.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 23 Aug 2010 04:38:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201008231318.30768.trast@student.ethz.ch>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154217>

Hi,

Thomas Rast writes:
> Jonathan Nieder wrote:
> > diff --git a/Documentation/git-show-branch.txt b/Documentation/git-show-branch.txt
> > index 81ba296..01fc157 100644
> > --- a/Documentation/git-show-branch.txt
> > +++ b/Documentation/git-show-branch.txt
> > @@ -168,7 +168,7 @@ $ git show-branch master fixes mhf
> >  ------------------------------------------------
> >  
> >  These three branches all forked from a common commit, [master],
> > -whose commit message is "Add \'git show-branch\'". The "fixes"
> > -branch adds one commit "Introduce "reset type" flag to "git reset"".
> > -The "mhf" branch adds many other commits. The current branch
> > -is "master".
> > +whose commit message is "Add {apostrophe}git show-branch{apostrophe}".
> > +The "fixes" branch adds one commit "Introduce "reset type" flag to
> > +"git reset"". The "mhf" branch adds many other commits.
> > +The current branch is "master".
> 
> What does this apply on?  I tried 'git am -3' but it says
> 
>   Applying: Documentation: remove stray backslash in show-branch discussion
>   Using index info to reconstruct a base tree...
>   error: patch failed: Documentation/git-show-branch.txt:168
>   error: Documentation/git-show-branch.txt: patch does not apply
>   Did you hand edit your patch?
>   It does not apply to blobs recorded in its index.
>   Cannot fall back to three-way merge.
>   Patch failed at 0013 Documentation: remove stray backslash in show-branch discussion

This series has already been merged into 'pu': jn/doc-backslash in
d4394935b3. Did you try applying to 'master'?

-- Ram
