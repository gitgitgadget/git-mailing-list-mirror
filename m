From: "Francis Moreau" <francis.moro@gmail.com>
Subject: Re: git-bisect: weird usage of read(1)
Date: Mon, 11 Aug 2008 18:29:51 +0200
Message-ID: <38b2ab8a0808110929i47f7e4dt5287d149d10afbaf@mail.gmail.com>
References: <38b2ab8a0808110657y24ac9526wca4acea3bddaec00@mail.gmail.com>
	 <alpine.DEB.1.00.0808111615260.24820@pacific.mpi-cbg.de.mpi-cbg.de>
	 <38b2ab8a0808110718x2f63608ga3d2d77e317ce4eb@mail.gmail.com>
	 <3f4fd2640808110859r148550d2h833dae05b9e6544e@mail.gmail.com>
	 <38b2ab8a0808110923u21d543f0qbc9dee0f99c97311@mail.gmail.com>
	 <3f4fd2640808110926w13104a08l687c8accc29e332@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Reece Dunn" <msclrhd@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Aug 11 18:30:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSaIJ-0005LA-00
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 18:30:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbYHKQ3x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 12:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbYHKQ3w
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 12:29:52 -0400
Received: from hs-out-0708.google.com ([64.233.178.251]:43571 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204AbYHKQ3w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 12:29:52 -0400
Received: by hs-out-0708.google.com with SMTP id 4so185813hsl.5
        for <git@vger.kernel.org>; Mon, 11 Aug 2008 09:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=3BFxHb3anTPS8qgRqZR6HWUHe1BxrTz7vGjMr9iLg38=;
        b=Z+8pVrk4KMo7/eIaWiyAZFj03DW+0jJDWtNQO/in0nH7brgMGTpNikzbSXfNs/XuBT
         SJiYELWaxE2DSrg55XDaxugBm1Et+LhVgxbGYqwzM78G2/xXvLp4Oiww3XAenLYxQgyf
         bVogHUqNIq1CdbGihviOX/hVjrS0lOFFCFCyg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=xLJ4heQNZzieVd0Nj0l1jHHhB43lhvwILsB+b4gsTmR0InHPFpq5LyNDpuLIW0Kk4b
         zZPHIVDfviccXCjIWdJ0r5r8dOmF22TJOIZGLD7jQQsNSyUQpYMaIx9WaWesswgc3JmF
         TEiK3CDe8FvydW6+sWm00QNc2OyU3LorvGGqM=
Received: by 10.90.92.14 with SMTP id p14mr10856174agb.48.1218472191117;
        Mon, 11 Aug 2008 09:29:51 -0700 (PDT)
Received: by 10.90.98.3 with HTTP; Mon, 11 Aug 2008 09:29:51 -0700 (PDT)
In-Reply-To: <3f4fd2640808110926w13104a08l687c8accc29e332@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91959>

On Mon, Aug 11, 2008 at 6:26 PM, Reece Dunn <msclrhd@googlemail.com> wrote:
> 2008/8/11 Francis Moreau <francis.moro@gmail.com>:
>> On Mon, Aug 11, 2008 at 5:59 PM, Reece Dunn <msclrhd@googlemail.com> wrote:
>>> $ $(read yesno) && echo yes || echo no
>>> n
>>> yes
>>> $ $(read yesno) && echo yes || echo no
>>> y
>>> yes
>>
>> funny, seeing these 2 cases I'm wondering why Bash is not complaining...
>
> I don't know; it could be an issue with cygwin.
>
> I'll try it on a Linux box later and post the results then for comparison.
>

I got the same result on Linux...

-- 
Francis
