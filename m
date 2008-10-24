From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [RFC] Zit: the git-based single file content tracker
Date: Fri, 24 Oct 2008 19:48:43 +0200
Message-ID: <cb7bb73a0810241048x47481727s92c8a6f8d318e82a@mail.gmail.com>
References: <gdok16$vh2$1@ger.gmane.org> <49007623.1060606@viscovery.net>
	 <alpine.DEB.1.00.0810241943470.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Sixt" <j.sixt@viscovery.net>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Oct 24 19:50:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtQnP-0005Ii-DK
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 19:49:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752698AbYJXRsq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 13:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752411AbYJXRsp
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 13:48:45 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:3999 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041AbYJXRsp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 13:48:45 -0400
Received: by yw-out-2324.google.com with SMTP id 9so348713ywe.1
        for <git@vger.kernel.org>; Fri, 24 Oct 2008 10:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=mNLaNVk8+pBiAUywqfwTxQBmX1TSZa8fvvceJ7815GE=;
        b=t6ncBhLI6k4uFzTBLG/s1HFshR/OoYfVuGAT8ptenlAU2SXCiF42yJE0t5bkPNOpVm
         kzPi+OSLkvW0PLD99qCkF20i1oqeCIr+bubp3BoEIO8RGuztbp1Z9K31IEfC5lgDcxVQ
         oEeA+O3JiC2TIQlfcr6mUoqse4oKbCre680Ik=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=wUhmhr7vIA0na5qYVp22YUC65q9F6GBwn62jAyI5VCIp7Y/txmssf7cInDhSuGZba3
         SUCIpVPLhUT2o8C/ayIc2hbJI2Cz9FFW32g+DIA4Wx7iFrySmh+QhRBkk8rPoGnuqCX5
         5pkYlUBM0RftEBgmGYu/cKR3DIkOGw2wQXmts=
Received: by 10.150.98.18 with SMTP id v18mr5734046ybb.91.1224870523812;
        Fri, 24 Oct 2008 10:48:43 -0700 (PDT)
Received: by 10.150.145.2 with HTTP; Fri, 24 Oct 2008 10:48:43 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0810241943470.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99046>

On Fri, Oct 24, 2008 at 7:44 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Thu, 23 Oct 2008, Johannes Sixt wrote:
>
>> Giuseppe Bilotta schrieb:
>> > Zit will create a directory .zit.file to hold a git repository
>> > tracking the single file .zit.file/file, which is just a hard link to
>> > file.
>>
>> git breaks hard links, mind you! (Just in case you check out older
>> versions and you wonder why your "real" file is not updated).
>>
>> But there's a recent patch by Dscho floating around that takes care of
>> the hard link case.
>
> Yep, I still want to work on it; it breaks on one of Junio's machines.

Well, it's not needed by Zit anymore, but there was someone else
asking about on the ml recently, too 8-)



-- 
Giuseppe "Oblomov" Bilotta
