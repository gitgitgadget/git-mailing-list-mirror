X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,BODY_URI_ONLY,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Possible BUG with git-rev-list --all in a StGit repository
Date: Mon, 27 Nov 2006 07:38:30 +0100
Message-ID: <e5bfff550611262238q60d466a3r230c9c4af283b76b@mail.gmail.com>
References: <e5bfff550611260827t686a5071w7f050f17f784e5d9@mail.gmail.com>
	 <7v7ixit13h.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550611262231s3eac2d11ke9fcdb0d699093f0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 27 Nov 2006 06:38:38 +0000 (UTC)
Cc: catalin.marinas@gmail.com, "Git Mailing List" <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KDJdYx6bVFfB3HRXWqBIM5FcBNgvODnQ/bRyqZhXBHY/DauxcrO01v28sOgIZBXpvyle17RLTlC2yHYt7HZvLFVLdVPdR84xu8cvEweQ7R5Cl6TeVc8+4PtCHMgCKqeUvwN4Tr1vKSEeGE01CqoAubu/K4wOXEpSHJtLJTJzJm8=
In-Reply-To: <e5bfff550611262231s3eac2d11ke9fcdb0d699093f0@mail.gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32384>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Goa8Q-00046t-3n for gcvg-git@gmane.org; Mon, 27 Nov
 2006 07:38:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757092AbWK0Gib (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 01:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757093AbWK0Gib
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 01:38:31 -0500
Received: from py-out-1112.google.com ([64.233.166.176]:24348 "EHLO
 py-out-1112.google.com") by vger.kernel.org with ESMTP id S1757090AbWK0Gia
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 01:38:30 -0500
Received: by py-out-1112.google.com with SMTP id a29so1035276pyi for
 <git@vger.kernel.org>; Sun, 26 Nov 2006 22:38:30 -0800 (PST)
Received: by 10.35.99.17 with SMTP id b17mr12452810pym.1164609510195; Sun, 26
 Nov 2006 22:38:30 -0800 (PST)
Received: by 10.35.42.4 with HTTP; Sun, 26 Nov 2006 22:38:30 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On 11/27/06, Marco Costalba <mcostalba@gmail.com> wrote:
> >
> > You are looking at .git/refs/bases/ refs that StGIT uses for its
> > internal bookkeeping.
> >
> Ok.
>
> Anyway, getting garbage when asking for a git-rev-list --all if in a
> StGit repo at least could be considered a little integration issue.
>
> Internal bookkeeing should be, well,  _internal_  :-)
>


