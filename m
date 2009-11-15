From: Johan 't Hart <johanthart@gmail.com>
Subject: Re: Question about "git pull --rebase"
Date: Sun, 15 Nov 2009 21:32:09 +0100
Message-ID: <4B006549.8050803@gmail.com>
References: <38b2ab8a0911141239w2bab7277o66350bc742d985dd@mail.gmail.com> <4AFF3D4D.7000308@gmail.com> <m2my2noo0g.fsf@gmail.com> <4B005AEC.1000002@gmail.com> <7vlji7k0dm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Francis Moreau <francis.moro@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 15 21:32:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9llt-0000cs-66
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 21:32:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753662AbZKOUcQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2009 15:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753633AbZKOUcP
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 15:32:15 -0500
Received: from ey-out-2122.google.com ([74.125.78.25]:37506 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753626AbZKOUcP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2009 15:32:15 -0500
Received: by ey-out-2122.google.com with SMTP id 9so1715026eyd.19
        for <git@vger.kernel.org>; Sun, 15 Nov 2009 12:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:newsgroups:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=ZDYuCAik/UjKRqdBw2qmgHiI2Z87jqCFKSTy01K3pEQ=;
        b=jDxSh3idK8pbdzu2laSxrhpFZddcyDqbtgiZUuqLBy5XLrShqonRBdUDIOa5JM8yYJ
         8L01WmgUIXY4P+NbGqvujKWs5oaODuoaFt2NUvLMHgQU6cFvn4Pymc8QifaEGlm6Hdg5
         rPCjaecrMaWGJmFG015aDvktzS7Bnmy8y9UPc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:newsgroups:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=QRb5H6qgyy/YaIGQmIh6pZ8VEj2xxQbtdX8hDP1ythWoGPmSqpzYBJ0CrQvrGV35kG
         FGxZoOj1jJEyZ0vhn0ACX3uyMhBjIuLgm0xep7Cvfyx6OdPheqLrkSOR+dIqtI3t5sC9
         neRMN9LK9vgNrVb8ykyBiPAN092OQO2EQqv+Y=
Received: by 10.213.0.131 with SMTP id 3mr1390312ebb.68.1258317139656;
        Sun, 15 Nov 2009 12:32:19 -0800 (PST)
Received: from ?192.168.2.101? (dsl-083-247-086-199.solcon.nl [83.247.86.199])
        by mx.google.com with ESMTPS id 10sm287045eyd.47.2009.11.15.12.32.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 15 Nov 2009 12:32:19 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <7vlji7k0dm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132959>

Junio C Hamano schreef:
> Johan 't Hart <johanthart@gmail.com> writes:
>>> I've been somehow confused by the git-pull man page, which says:
>>>
>>>   A parameter <ref> without a colon is equivalent to <ref>: when
>>>   pulling/fetching, so it merges <ref> into the current branch without
>>>   storing the remote branch anywhere locally
>>>

> Thanks for clearing it up.
> 
> I was puzzled by the above pointing-finger because I wanted to see where a
> misinformation originated from to fix it at the source.  But still don't
> see anything wrong with it.
>

My guess is that he was confused by '<ref>:' not meaning '<ref>:<ref>'. 
But I can't speak for him ofcource :)

Refspecs confused me too at the beginning... But knowing more and more 
about git, it seems that this part of the docs look OK to me.. At most 
an example might make things a little more clear, but I doubt it is 
necessary.
