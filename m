From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH 3/3] Teach "git branch" about --new-workdir
Date: Wed, 25 Jul 2007 12:05:43 +0100
Message-ID: <200707251205.48235.andyparkins@gmail.com>
References: <46A5B5F5.6000202@trolltech.com> <46A6F21D.2010306@trolltech.com> <Pine.LNX.4.64.0707251024390.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marius Storm-Olsen <marius@trolltech.com>,
	Alex Riesen <raa.lkml@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 25 13:06:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDegq-0005Qa-PW
	for gcvg-git@gmane.org; Wed, 25 Jul 2007 13:06:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759413AbXGYLFz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 07:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758838AbXGYLFy
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 07:05:54 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:12224 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758739AbXGYLFx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2007 07:05:53 -0400
Received: by ug-out-1314.google.com with SMTP id j3so325436ugf
        for <git@vger.kernel.org>; Wed, 25 Jul 2007 04:05:52 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=F1ngnbpVdqugvk55GdJ2l8ascKZ1ObJEfr7o38LGnvaXfMcYoXowaYfuoV/44AlvxNWRUkoPjZFZHyebwdprnpa/yAD1JQ45fSDEOaT/Qgyp3rHEwixoDWwLtLq+T+HtWSz/3R4l4PXQOGjKu8meoyoGPpDOuY0sbSbdisZ5asM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=R9Q6V05iirfqk4SHybtZR+EKR+S+vlPIVS5UdfyOD5g0PqWSH0yBgeq9P3I3NcRV++J2a6FQJ0d7RqtZZvhjqonyCaAYupPy/WGpjFYbR0LqYpzOO0cBIjoN4HPPpNdgOabuV0rSA2TYfC/yTr9NCY/e83i8RDyI62DoZLMUA9c=
Received: by 10.66.224.3 with SMTP id w3mr1315656ugg.1185361552407;
        Wed, 25 Jul 2007 04:05:52 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTPS id b33sm1154975ika.2007.07.25.04.05.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 25 Jul 2007 04:05:51 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <Pine.LNX.4.64.0707251024390.14781@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53682>

On Wednesday 2007 July 25, Johannes Schindelin wrote:

> So this leaves me with the question: do Windows users really want a proper
> native Windows support for Git?  If the answer is yes, why don't they _do_
> (as in "not talk") something about it?

I don't disagree with you at all - it is completely ridiculous for Windows 
users to moan about lack of Windows support without contributing any help.  
However, I think there is a good reason.

I think it's a chicken and egg problem.  The only reason I started making 
(small) contributions to git was because I was using it already.  I didn't 
set out with the goal "to improve git"; I set out looking for a DVCS.  
Luckily for me, I use Linux so git worked pretty well for me straight away.

The same is not true for Windows users.  Even if we ignore the fact that 
Windows users are notoriously less open-source savvy; it's unlikely that 
we'll get any Windows contributions until there are some threshold number of 
developers using git on Windows.

Open-source is all about scratching an itch, I can't see how Windows 
developers can get a gitch to scratch without being users of git first.  On 
the positive side though, there surely must come a point when the Windows 
port is "good enough" that it will start to gather users and hence 
developers.  Until then, I suppose it's just a matter of shouting "patch" 
every time a windows user asks for a feature :-)


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
