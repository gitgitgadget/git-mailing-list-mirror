From: =?ISO-8859-1?Q?=C9ric_Piel?= <Eric.Piel@tremplin-utc.net>
Subject: Re: [PATCHv2] lis3lv02d: support both one- and two-byte sensors
Date: Wed, 11 Feb 2009 00:54:53 +0100
Message-ID: <499213CD.6080903@tremplin-utc.net>
References: <1234309249-13672-1-git-send-email-giuseppe.bilotta@gmail.com>	 <499211D0.3090705@tremplin-utc.net> <cb7bb73a0902101551o30dde0aesaeba399f1ab732af@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Pavel Machek <pavel@suse.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 00:56:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LX2So-0006jY-JB
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 00:56:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754619AbZBJXzB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 18:55:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754187AbZBJXzA
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 18:55:00 -0500
Received: from mailservice.tudelft.nl ([130.161.131.5]:15466 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752351AbZBJXy7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 18:54:59 -0500
X-Greylist: delayed 500 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Feb 2009 18:54:59 EST
Received: from localhost (localhost [127.0.0.1])
	by rav.antivirus (Postfix) with ESMTP id 8F82133D5D;
	Wed, 11 Feb 2009 00:54:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at tudelft.nl
X-Spam-Flag: NO
X-Spam-Score: -12.589
X-Spam-Level: 
X-Spam-Status: No, score=-12.589 tagged_above=-99 required=5
	tests=[BAYES_00=-2.599, PROLO_LEO3=0.01, TUD_REL01=-10]
Received: from mailservice.tudelft.nl ([127.0.0.1])
	by localhost (tudelft.nl [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id vAu9vPMG+KW0; Wed, 11 Feb 2009 00:54:57 +0100 (CET)
Received: from smtp-a.tudelft.nl (smtp-a.tudelft.nl [130.161.129.18])
	by mx2.tudelft.nl (Postfix) with ESMTP id 0442333CE7;
	Wed, 11 Feb 2009 00:54:57 +0100 (CET)
Received: from [192.168.10.167] (63-103-dsl.ipact.nl [84.35.103.63])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-a.tudelft.nl (Postfix) with ESMTP id B8E6BB3A62;
	Wed, 11 Feb 2009 00:54:56 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.19) Gecko/20081231 Mandriva/2.0.0.19-1mdv2009.1 (2009.1) Thunderbird/2.0.0.19 Mnenhy/0.7.6.666
In-Reply-To: <cb7bb73a0902101551o30dde0aesaeba399f1ab732af@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109353>

Giuseppe Bilotta schreef:

> Well, the previous one works, but I admit it's horribly convoluted.
> I'll double check with this one and resubmit (I'll only resubmit the
> one based on Pavel's "don't touch anything on init" probably though,
> hope it's ok)
Sure, only modified v3 is ok.
BTW, now that this is working. Could you double check the correct axes 
set up. In particular, is it x_inverted or y_inverted, and what about z 
axis...

Thanks,
Eric
