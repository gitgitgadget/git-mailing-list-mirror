From: Vitaly <vitaly.berov@gmail.com>
Subject: Re: git clone: very long "resolving deltas" phase
Date: Wed, 07 Apr 2010 18:37:00 +0400
Message-ID: <4BBC988C.2030606@gmail.com>
References: <loom.20100406T161552-321@post.gmane.org>	 <vpqljd062xb.fsf@bauges.imag.fr> <4BBB5346.6070607@gmail.com>	 <4BBB53F5.9010106@op5.se>	 <q2mec874dac1004060850r5eaa41fak2ba9889d07794651@mail.gmail.com>	 <v2qecffb261004060856qcb769a06vf40ad2a75a3aa4fd@mail.gmail.com>	 <alpine.LFD.2.00.1004061705390.7232@xanadu.home>	 <4BBC1E15.9040403@gmail.com>	 <20100407080049.GA14041@LK-Perkele-V2.elisa-laajakaista.fi>	 <alpine.LFD.2.00.1004070952290.7232@xanadu.home> <s2kfabb9a1e1004070729j617d1f98r295723a54a30cd6d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>,
	Andreas Ericsson <ae@op5.se>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 07 16:37:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzWNo-0005Lh-Ag
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 16:37:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932678Ab0DGOh2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 10:37:28 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:51675 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932675Ab0DGOh1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 10:37:27 -0400
Received: by bwz1 with SMTP id 1so881701bwz.21
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 07:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=aQk2jfxazaHMEgZoKgSdggudisGpDPVPQCOdz2I8MWI=;
        b=H+LUivY9MeOhlMLMCkGM7fImfP2qu7gAjD2Ye2/QStGJGaJdFf4WnX7ucBEyAPgdl5
         8ViV+SyjYnOY92f4IJWPm6n0/zpg8h4WtxQ+mk4BDfAcXmtGAKEWcOhXIZW4pJn9jaTn
         +0KU/XGe3pcoJ87TanUqx7XH7DXlVByXjpwoE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=v8jXQag37mPYNRL62YSRABiyvahPrf1VPy9WngNxtcuX9coFRcRddMDSSTkM2K9OVl
         Pxqrb6mepydX7lLKsMFbupBNR58il7WvKGXLn2bfdReKdHsxAF+2+yQbSrR6SGtm4t6t
         si9+riWHq1Zdf5tQ4Xg8vV7izUJPF3QjZ2W2c=
Received: by 10.204.23.193 with SMTP id s1mr2291120bkb.151.1270651044757;
        Wed, 07 Apr 2010 07:37:24 -0700 (PDT)
Received: from [172.16.11.219] ([195.218.191.171])
        by mx.google.com with ESMTPS id 13sm6939642bwz.15.2010.04.07.07.37.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 07 Apr 2010 07:37:24 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9pre) Gecko/20100217 Shredder/3.0.3pre
In-Reply-To: <s2kfabb9a1e1004070729j617d1f98r295723a54a30cd6d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144226>

On 04/07/2010 06:29 PM, Sverre Rabbelier wrote:
> Heya,
>
> On Wed, Apr 7, 2010 at 09:08, Nicolas Pitre<nico@fluxnic.net>  wrote:
>    
>> This shouldn't happen since commit 92392b4a which provide a cap on
>> memory usage during the delta resolution process.
>>      
> Which made me think of asking:
>
> Vitaly, what version of git are you running? Both client and server side please.
>    
git version 1.7.0.4, both sides.
