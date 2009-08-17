From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH 10/11] Add MSVC Project file
Date: Tue, 18 Aug 2009 00:21:59 +0200
Message-ID: <4A89D807.1080202@gnu.org>
References: <1250525103-5184-1-git-send-email-lznuaa@gmail.com>	 <4A899495.8050902@gnu.org>	 <40aa078e0908171040g5718a809o88b093fe5a4a0e28@mail.gmail.com>	 <alpine.DEB.1.00.0908172149480.8306@pacific.mpi-cbg.de>	 <3af572ac0908171317s3ef1506fpb3df11916f8a6ee9@mail.gmail.com>	 <3f4fd2640908171343s6e2796a8le0455e02fd8386d9@mail.gmail.com>	 <3af572ac0908171354i6dd231etb576859ab8941214@mail.gmail.com>	 <alpine.DEB.1.00.0908172304200.8306@pacific.mpi-cbg.de>	 <3af572ac0908171423ye08efa8m6666ddb922d5ee92@mail.gmail.com>	 <alpine.DEB.1.00.0908180005250.8306@pacific.mpi-cbg.de> <3af572ac0908171519h7b72427lba7536506d44460e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Reece Dunn <msclrhd@googlemail.com>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Frank Li <lznuaa@gmail.com>, git@vger.kernel.org,
	msysgit@googlegroups.com
To: Pau Garcia i Quiles <pgquiles@elpauer.org>
X-From: git-owner@vger.kernel.org Tue Aug 18 00:22:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdAai-0002FV-Rz
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 00:22:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753787AbZHQWWD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 18:22:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753403AbZHQWWD
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 18:22:03 -0400
Received: from mail-fx0-f215.google.com ([209.85.220.215]:64311 "EHLO
	mail-fx0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752480AbZHQWWB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 18:22:01 -0400
Received: by fxm11 with SMTP id 11so39342fxm.39
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 15:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=aU+uCkFKWTdwv9p7nv6dVhWbPwOs/Li/cbsysKipEvU=;
        b=FA7RECL1y926uOllVUV04LTZme8oI9sO5NdD52PinnmZPaqUrzMIuLDP6QPrAuUiEV
         pobdxxq8/KrBzmAzil+nxJWXOrR06DXFsqLaPuc7UHlKDDwNukHrHoOE1QZ4mylrDVSm
         yju10CR4QR5KHABk10JMYmUUj+WQPbRWu8TMc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=AtGNuqs4VgCPTtYGVuf5NWpe6q99UKbJCiRVYsxRHvlEIIE/BuNHuoQEDIFDIQpzhq
         lb2C7b/iwNyxlCFkzfuF1E1ZLeagRU02UTiJjiVWS2H/BA546f3tgVmQtteDEvN1E3vW
         UTF2BWrHITCpsg/DVrqF8nsym1nKSsx56NWZk=
Received: by 10.204.34.13 with SMTP id j13mr3129663bkd.32.1250547722229;
        Mon, 17 Aug 2009 15:22:02 -0700 (PDT)
Received: from yakj.usersys.redhat.com ([85.93.118.17])
        by mx.google.com with ESMTPS id c28sm5540238fka.19.2009.08.17.15.22.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 17 Aug 2009 15:22:01 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.1) Gecko/20090814 Fedora/3.0-2.6.b3.fc11 Lightning/1.0pre Thunderbird/3.0b3
In-Reply-To: <3af572ac0908171519h7b72427lba7536506d44460e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126302>


>> This is exactly what I mean by burden.  Why do I have to learn a new
>> system, and suffer the hassle of integrating it into the current build
>> system, which works quite well thankyouverymuch?
>
> Because it works for every platform, including Visual C++, where a
> Bourne shell is not available and where you currently need to maintain
> a different built system.

But it comes with its own share of idiosyncracies.  There are as many 
CMake haters as there are autotools haters.

I don't see CMake being used by git.git before hell freezes over.  For 
msysgit, however, it may be an interesting approach.

> Let's see what I can do.

I'm also curious.

Paolo
