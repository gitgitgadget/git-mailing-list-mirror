From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH 4/4] prune-packed: migrate to parse-options
Date: Thu, 09 Jul 2009 08:55:50 -0700
Message-ID: <4A561306.9010908@gmail.com>
References: <1247030141-11695-1-git-send-email-bebarino@gmail.com> <1247030141-11695-2-git-send-email-bebarino@gmail.com> <1247030141-11695-3-git-send-email-bebarino@gmail.com> <1247030141-11695-4-git-send-email-bebarino@gmail.com> <1247030141-11695-5-git-send-email-bebarino@gmail.com> <alpine.DEB.1.00.0907091250120.4339@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 09 17:56:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOvye-0005nu-Kr
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 17:56:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759868AbZGIPz6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 11:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759611AbZGIPz5
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 11:55:57 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:65324 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756304AbZGIPz5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2009 11:55:57 -0400
Received: by bwz25 with SMTP id 25so271466bwz.37
        for <git@vger.kernel.org>; Thu, 09 Jul 2009 08:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=rDvSx0w2CwuU9jrZkO+MwAu8isltQCbUG3xkUxy+Gb0=;
        b=bmDL9jZWAl3LRz7mKJLRJRX09/MOxeCkMtpaTduGqx6MHYG0VKtWI95wx7FjNX7Ayh
         xxz1npsaVNgsArU2eWCQ2Lguvin+QCpX4k9hHmzDfKRdgRt5GcXC3oSaVQkgO0+M9zbu
         egzDHW1BfbMX33KP5D4d96iD/R12EF1J3tTuE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=GDBoJADP3SSR2KAQ4HN05ocUudmIWWSX6etZGTEG6HBGfOM1aV67eSLPPtd5Nn7lYL
         56wJl4wKyryNNtZkj7B8NerxBcbAF+e1AZSYg/452B72AdaSeRvuLOkfCATc3xBokjMs
         CqVGHKmkcIODq2iXJhOWLYT9NHa83vFUEHeFc=
Received: by 10.204.116.15 with SMTP id k15mr858104bkq.118.1247154955339;
        Thu, 09 Jul 2009 08:55:55 -0700 (PDT)
Received: from ?10.10.0.4? (cpe-66-75-25-79.san.res.rr.com [66.75.25.79])
        by mx.google.com with ESMTPS id 12sm18320821fks.51.2009.07.09.08.55.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Jul 2009 08:55:54 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22 (X11/20090629)
In-Reply-To: <alpine.DEB.1.00.0907091250120.4339@intel-tinevez-2-302>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122984>

Johannes Schindelin wrote:
> Hi,
>
> I reviewed all four patches, and like them.  Just a minor nit:
>
> On Tue, 7 Jul 2009, Stephen Boyd wrote:
>   
>> Add --dry-run and --quiet to be more consistent with the rest of git.
>>     
>
> You should say here that you add the _long_ options (the short options 
> were supported already); I almost expected you to sneak in additional 
> features with the parseoptification.
>
> Same goes for 3/4, I guess.
>   


Sure, this sounds reasonable. I'll send follow up commit message fixups.
