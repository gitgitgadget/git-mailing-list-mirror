From: Thomas Harning <harningt@gmail.com>
Subject: Re: Git Notes - Track rebase/etc + reverse-lookup for bugs ideas
Date: Mon, 10 Nov 2008 15:26:52 -0500
Message-ID: <74EBEC20-FC39-444E-8B96-31E5B36894B8@gmail.com>
References: <6A0F154C-B9FE-4770-BF70-82A5BEBF907C@gmail.com> <20081110191134.GA3329@sigill.intra.peff.net> <alpine.DEB.1.00.0811102049460.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 10 21:28:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzdMs-0005PY-Pv
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 21:28:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752014AbYKJU1A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 15:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751962AbYKJU1A
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 15:27:00 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:42404 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752002AbYKJU07 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 15:26:59 -0500
Received: by ug-out-1314.google.com with SMTP id 39so517826ugf.37
        for <git@vger.kernel.org>; Mon, 10 Nov 2008 12:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=jl8kJzlEf496humD1dOgTOU7d+AL+cixe7oAwy9/XGk=;
        b=ZfwjOSQKIECensRyEOvRF7wcOKgutuLTb6uMBdz5JYVDu5MZdU2ksE0+kJlO+whFhR
         zuAJwpaEOz2oediqTvjYSSWdV1u0VyPvQWqr3VVXuIFTgvI1DFgClFLTGZhUHWrmX9UX
         NofUMAT3Ac/5kCbb5Nazb/UPq3G3S2ugmmo+s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=hS81fTdDZWVlXzv4fNHJgQfFu4NNAAJ20Rg+7IwrdAOfK42j04bHFLdGAaedsE5HSd
         IdKeuoEQ8tkfD6sC8V2/s+MtfIkP+2/gGQuF+7uDYvYtJb0YrSPHuu9AlXwLJhJug3JI
         Xsi3/C1fzCpVqEDfbSS7z7ChXjOkchKd4VEoA=
Received: by 10.67.116.16 with SMTP id t16mr2370932ugm.51.1226348817517;
        Mon, 10 Nov 2008 12:26:57 -0800 (PST)
Received: from ?10.1.10.196? ([75.149.208.122])
        by mx.google.com with ESMTPS id e34sm8740652ugd.55.2008.11.10.12.26.54
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 10 Nov 2008 12:26:56 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0811102049460.30769@pacific.mpi-cbg.de>
X-Mailer: Apple Mail (2.929.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100561>


On Nov 10, 2008, at 2:51 PM, Johannes Schindelin wrote:

> Hi,
>
> On Mon, 10 Nov 2008, Jeff King wrote:
>
>> On Mon, Nov 10, 2008 at 12:37:20PM -0500, Thomas Harning wrote:
>>
>>> Just wondering, has there been any looking into whether the git- 
>>> notes
>>> concept can track rebases?
>>
>> Not that I know of, but then again, I'm not sure exactly what you  
>> mean
>> by "track rebases".
>
> I guess he means that you could have something like this
>
> 	rebased from <SHA-1>
>
> in the notes for any given commit, so that _if_ you have the commit,  
> e.g.
> gitk could show that connection (maybe dashed in the graphical history
> display, and as a "Rebased from:" link).
What I intended is that if notes are attached to 'A',  A` (after a  
rebase) will have the exact same note.
