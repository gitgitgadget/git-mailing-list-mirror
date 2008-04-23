From: Fedor Sergeev <Fedor.Sergeev@Sun.COM>
Subject: Re: What's cooking in git.git (topics)
Date: Wed, 23 Apr 2008 13:16:23 +0400 (Russian Standard Time)
Message-ID: <alpine.WNT.1.10.0804231313550.2728@theodor>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org>
 <46dff0320804221859x7641144fua34df89fcc686aa2@mail.gmail.com>
 <alpine.WNT.1.10.0804231124270.2728@theodor>
 <200804231047.41315.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7BIT
Cc: Ping Yin <pkufranky@gmail.com>,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 11:18:39 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Job7d-0006xY-WC
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 11:18:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbYDWJRv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 05:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750873AbYDWJRv
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 05:17:51 -0400
Received: from brmea-mail-3.Sun.COM ([192.18.98.34]:60856 "EHLO
	brmea-mail-3.sun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832AbYDWJRv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 05:17:51 -0400
Received: from fe-amer-09.sun.com ([192.18.109.79])
	by brmea-mail-3.sun.com (8.13.6+Sun/8.12.9) with ESMTP id m3N9Hnxt014241
	for <git@vger.kernel.org>; Wed, 23 Apr 2008 09:17:49 GMT
Received: from conversion-daemon.mail-amer.sun.com by mail-amer.sun.com
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 id <0JZR00F01TS6R900@mail-amer.sun.com>
 (original mail from Fedor.Sergeev@Sun.COM) for git@vger.kernel.org; Wed,
 23 Apr 2008 03:17:49 -0600 (MDT)
Received: from localhost ([92.255.85.22])
 by mail-amer.sun.com (Sun Java System Messaging Server 6.2-8.04 (built Feb 28
 2007)) with ESMTPSA id <0JZR005P4TTCDHE0@mail-amer.sun.com>; Wed,
 23 Apr 2008 03:17:49 -0600 (MDT)
In-reply-to: <200804231047.41315.robin.rosenberg.lists@dewire.com>
X-X-Sender: fs77888@mail-amer.sun.com
User-Agent: Alpine 1.10 (WNT 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80203>

On Wed, 23 Apr 2008, Robin Rosenberg wrote:

> onsdagen den 23 april 2008 09.47.57 skrev Fedor Sergeev:
>> If one manages to hack on repository one can modify it enormous amount of
>> ways, including spoofing on SHA (providing wrong contents for it - does
>> git verify that when getting a pack?), utilizing bugs in git etc...
>
> The pack transfer protocol does not transfer the SHA of objects, only the
> contents is transferred. The SHA-1 is (has to be since it is not sent)
> reconstructed on the receiving end.

Thats nice. Then I agree its difficult to spoil superproject out of 
submodule other than it just does not checkout.

regards,
   Fedor.
