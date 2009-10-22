From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: ks/precompute-completion (was Re: What's cooking in git.git (Oct
 2009, #04; Wed, 21))
Date: Thu, 22 Oct 2009 11:56:14 -0700
Message-ID: <4AE0AACE.4000205@gmail.com>
References: <7veiovly35.fsf@alter.siamese.dyndns.org> <4AE0190E.8020803@gmail.com> <fabb9a1e0910221011r957246dx3162cd675ff16800@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Kirill Smelkov <kirr@mns.spb.ru>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 22 20:56:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N12pm-0001UO-2f
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 20:56:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756800AbZJVS4Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 14:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756797AbZJVS4Q
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 14:56:16 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:42638 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756579AbZJVS4P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 14:56:15 -0400
Received: by fxm18 with SMTP id 18so9541230fxm.37
        for <git@vger.kernel.org>; Thu, 22 Oct 2009 11:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=/5pUphezacbLvWM7UNZrul7lMVR2YgmzABZxn6H0RLQ=;
        b=has/SA9bxXpgZ/MGEINReQOktqcTdhly6LBj9BPnOCT8DAXBCH7RMsXaDvgD4mKGMK
         ebR351YHWCp85ky9FhqPHaEd2oi3npKmQENC5Q9NCC5uZ947GV/Ci3MzyXNAGSbgCec/
         V79kq6/tnxH2CdKvcwVkS7lxq2+B/47SvaZyk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=UKuxciZoEPcfFAG+i61sjrbshQD4JLs61QUf4zL2Pgcg47bfcCZqHGcIbzMKkotB+K
         FD6SqrD1J8A9PEbD/fDXq5CtAIQhQwbXMV/d9yB9210UeYX5mkmaxluwG9W5sHFfVIvs
         fyP3/4LaTDRXEnBWpghC86JJUcDfZrInr7tV0=
Received: by 10.204.36.202 with SMTP id u10mr1903484bkd.196.1256237779735;
        Thu, 22 Oct 2009 11:56:19 -0700 (PDT)
Received: from ?192.168.0.5? (cpe-76-174-15-88.socal.res.rr.com [76.174.15.88])
        by mx.google.com with ESMTPS id k29sm2421526fkk.55.2009.10.22.11.56.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 22 Oct 2009 11:56:18 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (X11/20090827)
In-Reply-To: <fabb9a1e0910221011r957246dx3162cd675ff16800@mail.gmail.com>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sverre Rabbelier wrote:
> Heya,
>
> I would really like it if running 'make && make install' in git.git
> would also build the completion script, I don't want to have to
> remember to run 'cd contrib/completion && make' every time we get new
> completion options :P.

Perhaps a top-level completion rule would work? I don't know if building
completion for every user would be appropriate.
