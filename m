X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Ed <ed.since.06@gmail.com>
Subject: Re: Unprivileged User
Date: Fri, 1 Dec 2006 01:08:08 -0500
Message-ID: <2b9545a0611302208s43d7644do1ddd050d49c50014@mail.gmail.com>
References: <2b9545a0611292154r4334d1afn1f49bbd3be2c3374@mail.gmail.com>
	 <ekm6si$psp$1@sea.gmane.org> <7vwt5djmt5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 1 Dec 2006 06:08:25 +0000 (UTC)
Cc: jnareb@gmail.com, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lXAmZgmYXvzlvTxrbUwJr4NdAxgCr3ensxlBIT1pynPpB8fPrTWTiMZjwk2y4PbAk+WJyn4KuYhNxTqDi8HPkR34VQBwDBouyrToIDSxxAFzLrQgozCGOV65sfZn4RhpOueQBJDN0LhwgccsU+Ngjy28gmJd9xQ6mEc4KYK14hQ=
In-Reply-To: <7vwt5djmt5.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32852>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq1ZL-00009z-LS for gcvg-git@gmane.org; Fri, 01 Dec
 2006 07:08:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759100AbWLAGIL (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 01:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759102AbWLAGIL
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 01:08:11 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:31625 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S1759097AbWLAGIK
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 01:08:10 -0500
Received: by nf-out-0910.google.com with SMTP id o25so3462090nfa for
 <git@vger.kernel.org>; Thu, 30 Nov 2006 22:08:09 -0800 (PST)
Received: by 10.78.185.16 with SMTP id i16mr4459074huf.1164953288732; Thu, 30
 Nov 2006 22:08:08 -0800 (PST)
Received: by 10.78.206.11 with HTTP; Thu, 30 Nov 2006 22:08:08 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Thanks, I looked at the perl script and did it explicitly and it
works... I am on mac os x, but I do not know why that would affect the
behaviour of getpwuid...

On 11/30/06, Junio C Hamano <junkio@cox.net> wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>
> > Ed wrote:
> >
> >> From gitweb it says that my git project's owner is: Unprivileged User
> > ...
> > Actually gitweb uses uid/user the repository (the $GIT_DIR), unless you
> > provide it with an index file.
>
> This is a shot in the dark, but by any chance is this repository
> owned by nobody, which is mapped to "Unprivileged User" by
> /etc/passwd?  Googling for "Unprivileged User" and "getpwent"
> tells me that on OSX boxes nobody seems to map to that Gecos
> name.
>
> To explicitly set the names of list of projects and their
> owners, set up $projects_list text file.  A hint for its format
> is found around line 1111 in gitweb/gitweb.perl script.
>
> Hopefully somebody has documentation for gitweb configuration
> so that people do not have to refer to the source to find things
> out, but I do not know of a URL offhand...
>
>
>
