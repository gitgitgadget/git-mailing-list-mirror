From: "Ondrej Certik" <ondrej@certik.cz>
Subject: Re: importing mercurial patch
Date: Tue, 11 Nov 2008 13:18:37 +0100
Message-ID: <85b5c3130811110418l11be8084sf0f47a1095755747@mail.gmail.com>
References: <85b5c3130811110258h53d389co97a3c33e10667ae8@mail.gmail.com>
	 <alpine.DEB.1.00.0811111258260.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Nov 11 13:20:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzsDr-0000VL-A9
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 13:19:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755564AbYKKMSk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 07:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755546AbYKKMSk
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 07:18:40 -0500
Received: from ey-out-2122.google.com ([74.125.78.25]:58751 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755496AbYKKMSj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 07:18:39 -0500
Received: by ey-out-2122.google.com with SMTP id 6so1154820eyi.37
        for <git@vger.kernel.org>; Tue, 11 Nov 2008 04:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=t3F/mmkg+HAXyMfsX30oqSJt1gRYyaj5KOpr8BPfJ2A=;
        b=KfAip6nXlYWwxafNhmdCbpSTdkVWaLRTJzQ3RvJdbPlIFaGR5kNQoh66mA2NeZDGbm
         ML4MuX/n9QvUgY0hW5MHvrDMJAle906QnGDQvItj/c2dV/kjSu7rKwhbJTcGySUi2mLu
         8nkAVHngzvSURbDPUVIGT1+YMhrcC9Culiu18=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=DNfD9tU1e4d9d9aD+/nWlQFdQG0O23hRFzmfzyrrBKN4lTK0CqzN5BAzkMiJAXyp4N
         PP3oWMpW44qJYVv1YKLXM5T6x9cJvir1E14HRw4Bm6UqwEdXIVMdMYdvuRC0I3tl4YZs
         ofaRMsthuoAKFyUfw2PmeyUajJaH3l3ElLx/g=
Received: by 10.86.79.19 with SMTP id c19mr8268812fgb.41.1226405917503;
        Tue, 11 Nov 2008 04:18:37 -0800 (PST)
Received: by 10.86.99.20 with HTTP; Tue, 11 Nov 2008 04:18:37 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0811111258260.30769@pacific.mpi-cbg.de>
Content-Disposition: inline
X-Google-Sender-Auth: f395d0361de17e17
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100643>

On Tue, Nov 11, 2008 at 1:00 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Tue, 11 Nov 2008, Ondrej Certik wrote:
>
>> I'd like git to be able to import mercurial-exported patches.
>
> Have you seen
>
>        http://repo.or.cz/w/fast-export.git/
>
> ?
>
> I had many problems with it, so many that I started to write my own
> hg-fast-export together with Dirkjan Ochtman, a very nice Mercurial guy
> (actually, he started writing it, and I tried to fix it, but it still does
> not work due to merge mishandling).
>
> But then I saw that finally, they started work on it again.  It is
> somewhat sloppy, having a large part in Python and a large part in shell,
> which could have been avoided, but at least it works.

Yes, I use fast-export to convert from hg to git on the fly. But as I
understood it, you need to have the whole repository converted. So if
someone sends the patch in the mercurial format, I just want to apply
it to git, instead of applying it to hg first and then converting.
Well, you are right, that this is definitely one way of doing it.

But imho if git supported mercurial patches, life would be a lot easier.

Ondrej
