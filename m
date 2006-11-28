X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Possible BUG with git-rev-list --all in a StGit repository
Date: Tue, 28 Nov 2006 13:11:30 +0100
Message-ID: <e5bfff550611280411q737fc47s5a221bae078333b5@mail.gmail.com>
References: <e5bfff550611260827t686a5071w7f050f17f784e5d9@mail.gmail.com>
	 <7v7ixit13h.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550611262231s3eac2d11ke9fcdb0d699093f0@mail.gmail.com>
	 <e5bfff550611262238q60d466a3r230c9c4af283b76b@mail.gmail.com>
	 <7vzmadl5b0.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550611272357w33756febud0bbbe59e2e1e140@mail.gmail.com>
	 <7vd57855fy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 28 Nov 2006 12:12:49 +0000 (UTC)
Cc: catalin.marinas@gmail.com, "Git Mailing List" <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SqpCOGImHFArNdA9I2UAouKTtrhfm0PrAs8DDO13xgJGz5M9XYqY57Z2cjGTzLX8K3CGyLIVIBWIQZa6aARFCGgsOcVGOs8Km+4omfeLtb6GNt+l0CK4aPdn0FbNV2j22KOz0x3NrsnuQK51ts7MpEiyPrOftoDjzV45Nk5Qf4U=
In-Reply-To: <7vd57855fy.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32515>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gp1oW-0000on-PC for gcvg-git@gmane.org; Tue, 28 Nov
 2006 13:11:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757931AbWK1MLd (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 07:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757934AbWK1MLd
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 07:11:33 -0500
Received: from py-out-1112.google.com ([64.233.166.177]:59125 "EHLO
 py-out-1112.google.com") by vger.kernel.org with ESMTP id S1757933AbWK1MLb
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 07:11:31 -0500
Received: by py-out-1112.google.com with SMTP id a29so1282241pyi for
 <git@vger.kernel.org>; Tue, 28 Nov 2006 04:11:31 -0800 (PST)
Received: by 10.35.78.9 with SMTP id f9mr1483994pyl.1164715890971; Tue, 28
 Nov 2006 04:11:30 -0800 (PST)
Received: by 10.35.42.4 with HTTP; Tue, 28 Nov 2006 04:11:30 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On 11/28/06, Junio C Hamano <junkio@cox.net> wrote:
> "Marco Costalba" <mcostalba@gmail.com> writes:
>
> >> If you (as a Porcelain) want to get all refs under refs/heads/,
> >> there are (unfortunately) two ways to get that list.  I would
> >> suggest obtain the refs you want that way, pass them as command
> >> line arguments to rev-list.
> >
> > Unfortunatly that does not work in case a branch and a tag have the same name.
>
> I am not quite grokking what the problem you are trying to solve
> is, so this is a shot in the dark, but
>
>         git rev-list refs/heads/test refs/tags/test
>
> to disambiguate, perhaps?
>

Interesting!

I didn't think about 'full path' explicitation. If the barnches are
always and only under refs/heads this should work.

Thanks
