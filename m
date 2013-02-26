From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH/RFC] mingw: rename WIN32 cpp macro to NATIVE_WINDOWS
Date: Mon, 25 Feb 2013 23:08:52 -0500
Message-ID: <512C3554.8020902@gmail.com>
References: <50EB8EB5.6080204@gmail.com> <CALxABCYHRp17rcoOca1xWG9S19fq2rotz8FEKo09jNdrgMLiyQ@mail.gmail.com> <CALxABCavvW77djKQnbQsjCBcahmMfrP24SDz609NG-94_ifZ9Q@mail.gmail.com> <50F303D8.20709@gmail.com> <50F5A435.5090408@ramsay1.demon.co.uk> <20130120101007.GD16339@elie.Belkin> <50FEDB08.6030901@ramsay1.demon.co.uk> <51031C43.5030307@gmail.com> <7v38xo3irh.fsf@alter.siamese.dyndns.org> <51032481.4030707@redhat.com> <20130126010359.GH3341@elie.Belkin> <5106C382.20009@ramsay1.demon.co.uk> <7vliac3nbg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Eric Blake <eblake@redhat.com>,
	Alex Riesen <raa.lkml@gmail.com>,
	Jason Pyeron <jpyeron@pdinc.us>,
	=?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Stephen & Linda Smith <ischis2@cox.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 26 05:16:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UABxs-0008MT-CM
	for gcvg-git-2@plane.gmane.org; Tue, 26 Feb 2013 05:16:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759714Ab3BZEQC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 23:16:02 -0500
Received: from mail-qe0-f50.google.com ([209.85.128.50]:51189 "EHLO
	mail-qe0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759275Ab3BZEQA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 23:16:00 -0500
Received: by mail-qe0-f50.google.com with SMTP id w7so2186178qeb.37
        for <git@vger.kernel.org>; Mon, 25 Feb 2013 20:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=s9BKSYQkOPKwedoEVIPbXPhUNW6AzvuCBZXe/8nlJq4=;
        b=Dj3R/dcXjR1lttRIwHIzjpOstN41iUh76BKSPHrv3zVd2Xm9FKnZC82IsqxuKUDCpc
         plrJqiSNt28bMPO9z2wvTDK0xncMqVqY6j0bqZus7mfalscLwaky4DRgP8LjppcFliAL
         Bga58gubHtXioU+crb3Aq21ry/pHFe/vpI4JcNEpGAkB4oqnkAdDbz6gaVMu4VGEFqnV
         /JKcWKlkKrI9m7PfbOiOLA4Q7EirNc0LNW4i7TOi3SsMsFqYByawlsKZAA6SceaEtFqQ
         knkMZvXcA5/jqsCqQtTQDNuRhmy8Tpe0rvsTel1EOJyUyBvtwuz+zMZXZRrP7QXMwaip
         sD7w==
X-Received: by 10.229.179.84 with SMTP id bp20mr3485747qcb.117.1361851735971;
        Mon, 25 Feb 2013 20:08:55 -0800 (PST)
Received: from mark-laptop.lan (pool-173-79-125-63.washdc.fios.verizon.net. [173.79.125.63])
        by mx.google.com with ESMTPS id g6sm20748209qav.6.2013.02.25.20.08.53
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 25 Feb 2013 20:08:54 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130110 Thunderbird/17.0.2
In-Reply-To: <7vliac3nbg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217125>

On 02/25/2013 01:44 AM, Junio C Hamano wrote:
> I was in "find leftover bits" mode today and found this thread 
> hanging. Has anything come out of this thread, or there is nothing to 
> improve in this area? 

The patch passed my simple tests (build, run a few commands), but I 
didn't get around to a full test. And of course, I am testing on current 
Cygwin where git compiles and runs correctly anyway.

Mark
