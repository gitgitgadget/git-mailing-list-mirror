From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH RFC] rebase: add --revisions flag
Date: Wed, 9 Dec 2009 10:08:26 +0100
Message-ID: <fabb9a1e0912090108k338baaacg3ce2889dcf937cf2@mail.gmail.com>
References: <20091208144740.GA30830@redhat.com> <fabb9a1e0912081229l7990a148j9cd2daa338662dd@mail.gmail.com> 
	<200912090630.28506.chriscool@tuxfamily.org> <200912090752.51609.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <christian@couder.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Dec 09 10:08:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIIXV-0004bk-Qm
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 10:08:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752411AbZLIJIm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Dec 2009 04:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752377AbZLIJIl
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Dec 2009 04:08:41 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:56868 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752144AbZLIJIj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2009 04:08:39 -0500
Received: by pwj9 with SMTP id 9so2218606pwj.21
        for <git@vger.kernel.org>; Wed, 09 Dec 2009 01:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=O9ayD5j7bpe/3DGplyEYaEmSkuRhkujpWJO+n7YJFqY=;
        b=ALCHPBLvLDPyje7JBnIH1SBs71abD3y7d/2L4NOyxG3cly1fhc5Kb2+F0iRCJrjS0N
         xFiDEmFWuUMk0SdWhFizZUFoj3K/6sUCoHedMSIebUzNFIF2Ky+85ZdR4t2LD/zi94Y5
         lkAbKPnBWxkeySObSSyhmFCTnurOOxZBDvGTc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=cTM0ZX3LcsDBjFNuhLI4iaC906VmYBmwnL0PZ7y2o6jl+AYKGDCbIEHCQaCvHqN4/8
         IEFS0eN/ohYmBDXSqrEhSRZHJiFlDCUTjNaKk6Z4yH2oPciwz+ULTPlYdm6G6Taw70Ev
         BuIGFaPTrixmC01qFAiAGUu/6VjbQJmgkeeA4=
Received: by 10.142.118.3 with SMTP id q3mr1026346wfc.248.1260349726104; Wed, 
	09 Dec 2009 01:08:46 -0800 (PST)
In-Reply-To: <200912090752.51609.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134950>

Heya,

On Wed, Dec 9, 2009 at 07:52, Christian Couder <chriscool@tuxfamily.org> wrote:

<snip>

> After that I plan to work on cherry-pick and that could be useful to
> implement something like "git cherry-pick A..B".

Ah, okay, thanks for the update!

-- 
Cheers,

Sverre Rabbelier
