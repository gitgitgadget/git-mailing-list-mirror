From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: getting list of objects for packing
Date: Fri, 31 Oct 2008 15:23:40 -0700 (PDT)
Message-ID: <m3y704flrf.fsf@localhost.localdomain>
References: <TtAUShKh7lOR5rkf1iyWwpMOWoYpT8Mnw-t3Wemdy3tTCd0XiQHdag@cipher.nrlssc.navy.mil>
	<alpine.LFD.2.00.0810311625450.13034@xanadu.home>
	<JhY9the71dfsAJuojZF2S4BG-SEkshM7XxIWGPBeY9M@cipher.nrlssc.navy.mil>
	<7v7i7o8nc5.fsf@gitster.siamese.dyndns.org>
	<fAUegZ3bxPo8HquZjUM9syW-giYefuAzBtb1XXHQ-TwbmvJvMZvmDA@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>,
	Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Oct 31 23:27:00 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw2QM-0006My-RS
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 23:24:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752186AbYJaWXo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 18:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751921AbYJaWXo
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 18:23:44 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:10283 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751096AbYJaWXo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 18:23:44 -0400
Received: by ug-out-1314.google.com with SMTP id 39so1385342ugf.37
        for <git@vger.kernel.org>; Fri, 31 Oct 2008 15:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=QUTvjrwDRHKrTO0rxKt17N+HGk43IJzASq3qmcBNbgg=;
        b=DvVSXCOXWkVOWK4z/KIn+b/QXJlYhXNVephHawyPea5o4E62aBCLIbzhv6+mkpLnTo
         /pf0Ai39krnWKYJayZqw4y5ROAj/RVM6IqnoRoiPoYe4EaBVF7S1RZtTKC5kxcXuUjmw
         DEsaoR9ToZhW8SRbYzJy25vgnrcTfl9PgXy34=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=nwMIGohO30nQ+bNrxIxXg3yCUqDw7/cX0N2qiWR7qEDCvWYDNqryZgzhv2SC3zkXwh
         HJ9+4UCwPVoiWW8b5LuvUxMIX9SdMaFV5PFfvxN5telkTTnBiS6DLJXctIWVGZYWmjcZ
         hT3+SSwiFbVmhunWpSAUj+MZ/3CkkyTL7SYWA=
Received: by 10.210.42.13 with SMTP id p13mr6916811ebp.97.1225491822001;
        Fri, 31 Oct 2008 15:23:42 -0700 (PDT)
Received: from localhost.localdomain (abwk207.neoplus.adsl.tpnet.pl [83.8.234.207])
        by mx.google.com with ESMTPS id 10sm4742651eyd.6.2008.10.31.15.23.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 31 Oct 2008 15:23:40 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m9VMMlx1031927;
	Fri, 31 Oct 2008 23:22:52 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m9VMMDwx031915;
	Fri, 31 Oct 2008 23:22:13 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <fAUegZ3bxPo8HquZjUM9syW-giYefuAzBtb1XXHQ-TwbmvJvMZvmDA@cipher.nrlssc.navy.mil>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99660>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> Junio C Hamano wrote:

> > Yeah, but wasn't the purpose of your whole exercise to list objects that
> > do not delta nor compress well with each other, in which case the delta
> > compression order (aka name hash) would not matter, no?
> 
> The script I wrote actually starts up two pack-objects instances and I was
> writing the objects I wanted to pack _normally_ to one, and the ones that I
> did not want compressed/deltafied to the other (which was started with
> --no-reuse-object --window=0 --depth=0 --compression=0).
> 
> I didn't mentioned that fact in my first email, but I'm very glad Nico
> made his point.

Wasn't there some gitattribute which prohibited deltification of some
files (`delta` or something)?  Or wasn't this patch accepted, as I
cannot find such attribute in documentation (gitattributes(5))...
... err, it was added in commit a74db82e15cd8a2c53a4a83e9a36dc7bf7a4c750
(Teach "delta" attribute to pack-objects.) by Junio C Hamano in May
19, _without_ documentation.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
