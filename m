From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: git gui: Possible to see which commands are executed?
Date: Tue, 20 May 2008 22:05:20 +0200
Message-ID: <bd6139dc0805201305k61807561k8026b4c6509e4041@mail.gmail.com>
References: <48301B17.30309@dirk.my1.cc> <20080519022125.GV29038@spearce.org>
	 <4833206E.1080300@dirk.my1.cc> <20080520194403.GC29038@spearce.org>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "=?ISO-8859-1?Q?Dirk_S=FCsserott?=" <newsletter@dirk.my1.cc>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue May 20 22:06:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyY6A-0002x8-9d
	for gcvg-git-2@gmane.org; Tue, 20 May 2008 22:06:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762014AbYETUFX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2008 16:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761163AbYETUFX
	(ORCPT <rfc822;git-outgoing>); Tue, 20 May 2008 16:05:23 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:33565 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762362AbYETUFV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2008 16:05:21 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1898090wfd.4
        for <git@vger.kernel.org>; Tue, 20 May 2008 13:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=bxxVXfhVyBJii/DYk+CrsX6LAx94uZQcxcipg2A06DE=;
        b=cHq15hiPMyRb/FmPvmeJTMvymiV5MNbojm78qYY+DbYrShRzqznRL/cIOObWyyREDiHah+bks+8YZt1eUQIcH2W9Fq3CSpBSzkczuXwjvb5CkmIrYoMp1bW0qnuG2meu52pG0xjbTAdzCtc0ALageBCAVOf3jUz0B9RhAKfRo3g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ipzUK3c7Sc86JwWcmRfq5DyQxK6Uf5fePU4V7Zzo/62qKIMoTJ3+i0x2wQyNKUdhPUoBplXdC2OnspZCdBvlpJqzU/nY5JV4TXin80sN5hHUEMHrPTlDP25F7IesuNnb31mEB1+7sTVC5/8Y7m5HsjT/LgcrfTH+rVw9XjtaMTg=
Received: by 10.142.141.21 with SMTP id o21mr3504658wfd.199.1211313920562;
        Tue, 20 May 2008 13:05:20 -0700 (PDT)
Received: by 10.143.33.6 with HTTP; Tue, 20 May 2008 13:05:20 -0700 (PDT)
In-Reply-To: <20080520194403.GC29038@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82493>

On Tue, May 20, 2008 at 9:44 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> Junio defers almost all git-gui things to me, as I am the current
> maintainer of git-gui.  You are right, it doesn't really hurt to
> include it, and now that it is written, the hard part is already
> done.  I'll apply it to my main git-gui tree and ask Junio to
> include it in a future version of Git.

Hmmm, maybe you should include in big red letters that the output from
--trace in no way or form represents commands that a user should use
daily? I can hear the questions on #git already "I don't understand,
I've used git-gui for months now, but the command it tells me to use
make no sense!".
Even better of course would be to not only print the plumbing commands
but also the porcelain commands!

-- 
Cheers,

Sverre Rabbelier
