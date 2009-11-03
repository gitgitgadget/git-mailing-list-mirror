From: Pascal Obry <pascal@obry.net>
Subject: Re: git hang with corrupted .pack
Date: Tue, 03 Nov 2009 23:34:37 +0100
Organization: Home - http://www.obry.net
Message-ID: <4AF0AFFD.1050706@obry.net>
References: <20091014042249.GA5250@hexapodia.org> <20091014142351.GI9261@spearce.org> <alpine.LFD.2.00.0910141208170.20122@xanadu.home> <20091014161259.GK9261@spearce.org> <alpine.LFD.2.00.0910141234540.20122@xanadu.home> <20091014180302.GL9261@spearce.org> <alpine.LFD.2.00.0910141435040.20122@xanadu.home> <7vbpk985t1.fsf@alter.siamese.dyndns.org> <81b0412b0910200814v269e91fbkd7841308685e1c54@mail.gmail.com> <4AF0A132.1060103@obry.net> <20091103222834.GC10505@spearce.org>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Andy Isaacson <adi@hexapodia.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Nov 03 23:34:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5RxQ-0006f2-20
	for gcvg-git-2@lo.gmane.org; Tue, 03 Nov 2009 23:34:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753774AbZKCWeT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2009 17:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751531AbZKCWeT
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 17:34:19 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:43251 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123AbZKCWeT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 17:34:19 -0500
Received: by ewy3 with SMTP id 3so2512448ewy.37
        for <git@vger.kernel.org>; Tue, 03 Nov 2009 14:34:23 -0800 (PST)
Received: by 10.213.24.28 with SMTP id t28mr690635ebb.92.1257287662916;
        Tue, 03 Nov 2009 14:34:22 -0800 (PST)
Received: from ?192.168.0.100? (AVelizy-154-1-81-3.w86-205.abo.wanadoo.fr [86.205.111.3])
        by mx.google.com with ESMTPS id 28sm1582041eyg.30.2009.11.03.14.34.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 03 Nov 2009 14:34:21 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR; rv:1.8.1.22) Gecko/20090605 Thunderbird/2.0.0.22 Mnenhy/0.7.5.0
In-Reply-To: <20091103222834.GC10505@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132005>

Shawn,

> It was fixed in 1.6.5.2 by Junio.

Hum... I was using today Git from master. Just after I send my message I 
tried 1.6.5 and it was working... I went back to master and it is now 
working... Really strange... Maybe a file did not get properly 
recompiled. I doubt it... but for sure it was failing and I build git 
every day from master! Strange!

Anyway, it was a false alarm.

Pascal.

-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|    http://www.obry.net  -  http://v2p.fr.eu.org
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver keys.gnupg.net --recv-key F949BD3B
