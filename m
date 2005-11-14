From: Marco Costalba <mcostalba@yahoo.it>
Subject: Re: GIT character codecs
Date: Sun, 13 Nov 2005 22:31:25 -0800 (PST)
Message-ID: <20051114063126.27817.qmail@web26306.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 14 07:33:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbXsW-0003Vo-Sl
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 07:31:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbVKNGb1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 01:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750937AbVKNGb1
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 01:31:27 -0500
Received: from web26306.mail.ukl.yahoo.com ([217.146.176.17]:30050 "HELO
	web26306.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750892AbVKNGb1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 01:31:27 -0500
Received: (qmail 27819 invoked by uid 60001); 14 Nov 2005 06:31:26 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=VkZn1fLRpiG6Wp9RTBlDjn3PB4KEN2/Stheen1NfXER0h7+/ioImbtLSI0gb/3Gp8EvUjpxZiCz/4A188NmaiHc22HpVFrDpVqkawMd2Vj39sQIpUwrBGeXqIkgUlc42TwZPw/ZrXTluUAYJvd9yT3+/Y49YSoAGoVed7uTLKfE=  ;
Received: from [151.44.24.112] by web26306.mail.ukl.yahoo.com via HTTP; Sun, 13 Nov 2005 22:31:25 PST
To: Matthias Urlichs <smurf@smurf.noris.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11769>

Matthias Urlichs wrote:

>Hi, Junio C Hamano wrote:
>
>>I suspect you could just take the default from LANG and LC_CTYPE
>>to cover 98% of the cases, and to cover the rest 2% the
>>problematic cases have a per-window override menu.
>
>
>Or, if you want to be super-flexible, just try to decode as UTF-8.
>Success? fine -- otherwise use whatever your application's default is
>set to, or your local encoding (which may of course also be UTF-8), or
>fall back to 8859-15.
>

How it is possible to test for success?

The codec could see everything decodable, but It's only from the context,
i.e. the user who reads, that it is possible to realize it's the wrong codec.  

Anyhow, as I posted previous in this thread, qgit-0.97.2 now has a codec selector
 as a persistent setting, defaulting to local codec.


  Marco



		
__________________________________ 
Yahoo! FareChase: Search multiple travel sites in one click.
http://farechase.yahoo.com
