From: "Heinrich Nirschl" <heinrich.nirschl@gmail.com>
Subject: Re: git-svn crashing perl
Date: Sat, 18 Oct 2008 18:05:44 +0200
Message-ID: <394ab6ec0810180905t5faca9cbnc7b73267a72deddc@mail.gmail.com>
References: <b2cdc9f30810180642n22b800ddg244555bf788a83bc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Alex Bennee" <kernel-hacker@bennee.com>
X-From: git-owner@vger.kernel.org Sat Oct 18 18:07:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrEKS-0000GS-Ek
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 18:07:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbYJRQFr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Oct 2008 12:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751056AbYJRQFq
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Oct 2008 12:05:46 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:53219 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751033AbYJRQFq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Oct 2008 12:05:46 -0400
Received: by gxk9 with SMTP id 9so2269855gxk.13
        for <git@vger.kernel.org>; Sat, 18 Oct 2008 09:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=KbFHD04L6XqreV06FdTUDxi+sXQG6+xw5NMeNfax7nM=;
        b=MgwUF/1p1NS3OLI16YDD40A7KDmYFWzlBh+7M77Bz2lgD//+Pm+XHwfP1Ich9/nXQo
         vEIuFjvzuf1VCcVubQT9/KcQNGUsZ2Qqtf5bIjKQC9veCw6I8VJLLTHAtDqPKo5HTuZ2
         n0MluWIu7FT28iHWOIohy9Alwr88DeIY9dqH4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=UnQYUqHe5XH/g4FkSm0OnwGdFDwa8z9LVPhyo82fPEiPOseIU5VIgnb+7RZ85CnRYr
         YKZk4q1L0rcE18vrfGew6YY5zGhGBmK3rxo3r49GaU+Zi9g+8fBr75uDPiGpvtPEu6ms
         f74HNm+0IZWVCw5IkI3ODpnH2CnTE1HcJnSV0=
Received: by 10.90.101.17 with SMTP id y17mr5731870agb.55.1224345944824;
        Sat, 18 Oct 2008 09:05:44 -0700 (PDT)
Received: by 10.90.88.20 with HTTP; Sat, 18 Oct 2008 09:05:44 -0700 (PDT)
In-Reply-To: <b2cdc9f30810180642n22b800ddg244555bf788a83bc@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98557>

On Sat, Oct 18, 2008 at 3:42 PM, Alex Bennee <kernel-hacker@bennee.com> wrote:
> Hi,
>
> Doing a git-sv fetch --fetch-all is generating a SEGV in perl while I
> try and update my repo. Although I can look at the backtrace in perl
> it doesn't really tell me much. Any tips on how I can get more info?
>

This seems to be a problem of the subversion perl bindings. See for example:
http://subversion.tigris.org/issues/show_bug.cgi?id=3007
