From: Brent Goodrick <bgoodr@gmail.com>
Subject: Re: CR codes from git commands
Date: Wed, 21 Jan 2009 20:00:45 -0800
Message-ID: <e38bce640901212000w5b1b8a91tfdd0abbebde162a0@mail.gmail.com>
References: <18805.64312.289059.660023@hungover.brentg.com>
	 <alpine.DEB.1.00.0901201757520.5159@intel-tinevez-2-302>
	 <18806.44057.477379.215492@hungover.brentg.com>
	 <alpine.DEB.1.00.0901210930370.7929@racer>
	 <18807.13411.984420.252378@hungover.brentg.com>
	 <alpine.DEB.1.00.0901211636340.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 22 05:02:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPqlf-0001Ky-O7
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 05:02:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756490AbZAVEAs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 23:00:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756488AbZAVEAr
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 23:00:47 -0500
Received: from el-out-1112.google.com ([209.85.162.178]:28354 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756483AbZAVEAq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 23:00:46 -0500
Received: by el-out-1112.google.com with SMTP id b25so347708elf.1
        for <git@vger.kernel.org>; Wed, 21 Jan 2009 20:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9ZocVPdZbbPV3mF4gT5OQicYOQd6AO0XvlClkAGucpM=;
        b=Djxgm02SUYsg/JytVjqZ/GRHq6ISLVOMQTwX+NdOldAkntuSXiCLZhme27uUbCLjkr
         XKtYQXV9eUwzqppPqC0GIgPm3wS+5JwGfrMd7DWckyVCSC3HwQf7KC/bTNBtJE/NPUae
         H7G6I8MudwVTtNiGgWRvUdLGAci9oWAnH0hLw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=e7K9Qt8+yDwmmtYRQrun6bJ79beqvDckBF/3oGHeLRZYpCV++wkFDrgpkBoazEAU/a
         tLK8u8iYmuGvTYJdf50t2zIYy5QiqGhja4Mj3fXkTXHeqhFHghw1AIIOXEotPXRwa1+B
         y2oL5Ou7Oyk58RiwlNtLv5LMF6ZPimGEUle+0=
Received: by 10.90.68.20 with SMTP id q20mr431746aga.11.1232596845474; Wed, 21 
	Jan 2009 20:00:45 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0901211636340.3586@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106716>

On Wed, Jan 21, 2009 at 7:38 AM, Johannes Schindelin
> In my test I performed one minute ago, "git pull | cat" did not show any
> CR.  Maybe it is the "git" instead of "get" :-)
<snip>
> > Thanks.  The fix should be to arrange it so that I can set something so
> > that a bare call such as (but just "git pull"):
> >
> >   git pull
> >
> > will emit no CR codes at all, ever, regardless of if there is a tty.
> > Even if it is an env var, but a config setting would be ok too.
>
> I would actually think that it should not be an env var or config setting
> if piping it to "cat" does what you want: if the output is a tty, I think
> it is safe to assume that you want to see the progress, and if you don't,
> "| cat" is not an unreasonable thing to ask for.

You might not be able to see those CR codes from your terminal,
because ... well ... its a terminal which will process them.  And if
you can't reproduce it in your environment, you'll have to duplicate
my environment, and at that is well beyond what I would ask anyone to
do. Thanks for your effort in looking into it.  If I get annoyed
enough with it, I'll debug the code myself and propose a patch (but
don't hold your breath because I'm still learning this complex tool).

Thanks!
Brent
