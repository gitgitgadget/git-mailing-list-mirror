From: "Morten Welinder" <mwelinder@gmail.com>
Subject: Re: [RFC/PATCH] Fix "grep -w"
Date: Sat, 5 Aug 2006 15:19:02 -0400
Message-ID: <118833cc0608051219q7e19800alc05870058973c2e@mail.gmail.com>
References: <7vwt9ng3t1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 05 21:19:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9Rg2-0000eQ-Pb
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 21:19:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbWHETTE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Aug 2006 15:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751474AbWHETTE
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Aug 2006 15:19:04 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:23413 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751464AbWHETTD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Aug 2006 15:19:03 -0400
Received: by nf-out-0910.google.com with SMTP id x37so1435431nfc
        for <git@vger.kernel.org>; Sat, 05 Aug 2006 12:19:02 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BnzQbmnq9H1iRfq8LAB2tRk3TgunMRTVh/Zj6mBO997wXoWIHd6yFaMIyWwpIaMOTnOwaIhimzJStmPcRavjaNYScBUu7XK4VkL2oY49o0g9A+JcC3bvPKVNVl/qxEUyh/Fp0tsMTfTSzyip/VJJtOx2c8acJXDoTCurnllUH78=
Received: by 10.78.139.5 with SMTP id m5mr1964373hud;
        Sat, 05 Aug 2006 12:19:02 -0700 (PDT)
Received: by 10.78.46.13 with HTTP; Sat, 5 Aug 2006 12:19:02 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vwt9ng3t1.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24925>

1. Are you sure that going to the end of the first match is correct?
It seems to
   me that this will skip matches.  Say you search for ".*" on a line that reads
   " xxx".

2. What about "^"?

3. What about empty matches?  That could take a while...

Morten
