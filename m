From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: Git-aware HTTP transport
Date: Thu, 28 Aug 2008 19:38:59 +0200 (CEST)
Message-ID: <alpine.LRH.1.10.0808281937580.10660@yvahk3.pbagnpgbe.fr>
References: <20080826012643.GD26523@spearce.org> <48B36BCA.8060103@zytor.com> <20080826145857.GF26523@spearce.org> <48B4303C.3080409@zytor.com> <20080826172648.GK26523@spearce.org> <48B485F8.5030109@zytor.com> <20080828035018.GA10010@spearce.org>
 <7vhc95iwcs.fsf@gitster.siamese.dyndns.org> <20080828145706.GB21072@spearce.org> <alpine.DEB.1.10.0808281023200.2713@asgard.lang.hm> <20080828172853.GE21072@spearce.org> <alpine.DEB.1.10.0808281033070.2713@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Thu Aug 28 19:45:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYlY5-0005aG-KR
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 19:44:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755578AbYH1Rnl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 13:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755943AbYH1Rnk
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 13:43:40 -0400
Received: from kluster1.contactor.se ([91.191.140.11]:35218 "EHLO
	kluster1.contactor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756002AbYH1Rnj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 13:43:39 -0400
Received: from linux3.contactor.se (linux3.contactor.se [91.191.140.23])
	by kluster1.contactor.se (8.13.8/8.13.8/Debian-3) with ESMTP id m7SHhObM021763;
	Thu, 28 Aug 2008 19:43:24 +0200
X-X-Sender: dast@linux3.contactor.se
In-Reply-To: <alpine.DEB.1.10.0808281033070.2713@asgard.lang.hm>
User-Agent: Alpine 1.10 (LRH 962 2008-03-14)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94100>

On Thu, 28 Aug 2008, david@lang.hm wrote:

>>> except that HTTP cannot transport binary data, if you feed it binary data
>>> it then encodes it into 7-bit safe forms for transport.
>> 
>> So then how does it transport a GIF file to my browser?  uuencoded?
>
> something like that. it uses the mimetype mechanisms to identify the various 
> pieces and encodes each piece (if nothing else it needs to make sure that 
> the mimetype seperators don't appear in the data) uuencode is one of the 
> available mechanisms.

No. HTTP is 8bit clean and sends and receives binary just fine. You seem to 
think of SMTP or something.

-- 

  / daniel.haxx.se
