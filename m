From: Marco Costalba <mcostalba@yahoo.it>
Subject: Re: [RFC] Patches exchange is bad?
Date: Wed, 17 Aug 2005 10:35:22 -0700 (PDT)
Message-ID: <20050817173522.14386.qmail@web26305.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 17 19:35:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5Rp1-0003Em-3q
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 19:35:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbVHQRfY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Aug 2005 13:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbVHQRfY
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Aug 2005 13:35:24 -0400
Received: from web26305.mail.ukl.yahoo.com ([217.146.176.16]:8313 "HELO
	web26305.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750722AbVHQRfY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2005 13:35:24 -0400
Received: (qmail 14388 invoked by uid 60001); 17 Aug 2005 17:35:22 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=D2OlLTLxwNyq/2pTaBYFOW8p76djeZRkB2v7LtcvyuZTf5h4kl242ihTY29Mh16oowWOZNHBigtJLnwVhJMtbMBWtktDrXv0KOCa/ZNTenBUDaNPtqcT9Bz63K5zC4qmoKzGPQBs9MmZaz6e55o/AQAY4MojDYrEvTzWKW34my4=  ;
Received: from [151.42.53.158] by web26305.mail.ukl.yahoo.com via HTTP; Wed, 17 Aug 2005 10:35:22 PDT
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Catalin Marinas wrote:

>
>Once you want a subset of these patches merged into MAIN, just pop
>everything from the stack and only push those you want merged, in the
>order you want (if there are some dependencies, the push will fail and
>you can correct them or the order). When you are happy with the
>patches pushed on the stack, just do a 'git pull <HEAD>' in the MAIN
>repository. After this, doing a 'stg pull <MAIN>' in the HEAD one will
>mark the patches already integrated into MAIN as empty and you can
>safely remove them ('stg clean' does this automatically).
>
>This way I found StGIT useful for maintainers as well, not only for
>contributors.
>

Sorry if the answer is silly, but I still don't know well StGIT .

What you describe it's an asymmetrical or one way scenario, new code 
goes always from HEAD to MAIN. But how is the workflow if:

1) There is more then one contributor feeding MAIN and you need to update 
the StGIT patch stack from MAIN.

2) You made something terribly wrong with HEAD (I don't know what can be 
'terribly wrong') and you need to recreate a clean base from MAIN.

In this cases, if I understand correctly, you need to clone a new StGIT archive from 
MAIN and push the interesting stuff from old/broken HEAD.

Or you can always merge back pulling from MAIN as in case of two pure git archives?


Thanks
Marco



		
____________________________________________________
Start your day with Yahoo! - make it your home page 
http://www.yahoo.com/r/hs 
 
