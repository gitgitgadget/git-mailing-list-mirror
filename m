From: Marco Costalba <mcostalba@yahoo.it>
Subject: Re: [RFC] Patches exchange is bad?
Date: Tue, 16 Aug 2005 14:47:07 -0700 (PDT)
Message-ID: <20050816214707.6842.qmail@web26302.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 16 23:48:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E59HA-0001uS-QU
	for gcvg-git@gmane.org; Tue, 16 Aug 2005 23:47:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbVHPVrN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Aug 2005 17:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932485AbVHPVrN
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Aug 2005 17:47:13 -0400
Received: from web26302.mail.ukl.yahoo.com ([217.146.176.13]:45946 "HELO
	web26302.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932381AbVHPVrN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2005 17:47:13 -0400
Received: (qmail 6844 invoked by uid 60001); 16 Aug 2005 21:47:07 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=FrErK2Rxha+O8dz98LwZi4Ch5n1s5mVyquGOInHByaiONpnH0jsGxxZ/qlpvhQPSM7kOzVu0sWqA5s6z60V1ltsjLRoiztlFHE2ANoIOUe7UYZKipaM8TWWepIYUvpcmaTCOe35OHwfTgv23WC4hpvb5Nh/GnAgoaIpQ2z6eJfw=  ;
Received: from [151.38.74.63] by web26302.mail.ukl.yahoo.com via HTTP; Tue, 16 Aug 2005 14:47:07 PDT
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:

>
>I would like to know a bit about "git format-patch" adding extra
>info that you needed to get rid of.  It shouldn't be necessary.
>

As example, in the rev d5a63b99835017d2638e55a7e34a35a3c1e80f1f from git
the original subject is:

'   Alternate object pool mechanism updates.'

while, after the round-trip git-format-patch + git applymbox I have

'   [PATCH] Alternate object pool mechanism updates.'

The extra '[PATCH]' in the subject was introduced by git-format-patch --mbox.


Perpahs I have made something wrong.


Marco



		
____________________________________________________
Start your day with Yahoo! - make it your home page 
http://www.yahoo.com/r/hs 
 
