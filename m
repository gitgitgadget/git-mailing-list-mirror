From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: newbie question
Date: Mon, 06 Jul 2009 14:11:53 +0200
Message-ID: <4A51EA09.2000309@drmicha.warpmail.net>
References: <e4a904790907031139rc61c2e0t6b9dbbc0c3dc379e@mail.gmail.com> <7vvdm9r2pi.fsf@alter.siamese.dyndns.org> <slrnh4t8jo.b72.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 06 14:12:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNn3U-0001AA-Cn
	for gcvg-git-2@gmane.org; Mon, 06 Jul 2009 14:12:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754082AbZGFMMK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2009 08:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753699AbZGFMMJ
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jul 2009 08:12:09 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:34420 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752683AbZGFMMI (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jul 2009 08:12:08 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 8DA723AE15F;
	Mon,  6 Jul 2009 08:12:11 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 06 Jul 2009 08:12:14 -0400
X-Sasl-enc: aiU+BwIK8XcIaEcWEmwBmr8NOcweKy7894I8IfT/8MRz 1246882331
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 07FAD94CB;
	Mon,  6 Jul 2009 08:12:10 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.1pre) Gecko/20090703 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <slrnh4t8jo.b72.sitaramc@sitaramc.homelinux.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122783>

Sitaram Chamarty venit, vidit, dixit 04.07.2009 02:29:
> On 2009-07-03 19:22:49, Junio C Hamano <gitster@pobox.com> wrote:
> 
>>     $ git branch --with $commit ;# on which branches is the bad commit in?
> 
> --with?  Did --contains get an alternative form?
> 

No, it always had one :)

git log -S'"with"' --pretty=oneline
694a577519a762d12b8a53e76b6f1dd3ccf25e7d git-branch --contains=commit

Cheers,
Michael
