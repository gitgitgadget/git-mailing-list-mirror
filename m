From: Andreas Ericsson <ae@op5.se>
Subject: Re: Request for detailed documentation of git pack protocol
Date: Thu, 04 Jun 2009 09:17:27 +0200
Message-ID: <4A277507.2060409@op5.se>
References: <200905122329.15379.jnareb@gmail.com> <200906031851.12160.jnareb@gmail.com> <20090603165613.GJ3355@spearce.org> <200906032220.00238.jnareb@gmail.com> <20090603202429.GO3355@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Scott Chacon <schacon@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jun 04 09:19:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MC7Ec-0004ay-0x
	for gcvg-git-2@gmane.org; Thu, 04 Jun 2009 09:19:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650AbZFDHRN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2009 03:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbZFDHRM
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jun 2009 03:17:12 -0400
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:34484 "HELO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751080AbZFDHRL (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Jun 2009 03:17:11 -0400
Received: from source ([209.85.218.211]) by na3sys009aob106.postini.com ([74.125.148.12]) with SMTP
	ID DSNKSid09yFs0kys1Lew8Exf1cJeclHma3OP@postini.com; Thu, 04 Jun 2009 00:17:14 PDT
Received: by bwz7 with SMTP id 7so464386bwz.36
        for <git@vger.kernel.org>; Thu, 04 Jun 2009 00:17:11 -0700 (PDT)
Received: by 10.103.240.15 with SMTP id s15mr1090000mur.102.1244099831269;
        Thu, 04 Jun 2009 00:17:11 -0700 (PDT)
Received: from clix.int.op5.se (c-8537e055.366-1-64736c20.cust.bredbandsbolaget.se [85.224.55.133])
        by mx.google.com with ESMTPS id 23sm8325709mun.16.2009.06.04.00.17.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Jun 2009 00:17:10 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <20090603202429.GO3355@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120681>

Shawn O. Pearce wrote:
> 
> Servers MUST accept include-tag without error or warning, even if the
> server does not understand or support the option.
> 
> Servers SHOULD pack the tags if their referrant is packed and the
> client has requested include-tag.
> 
> Clients MUST be prepared for the case where a server has ignored
> include-tag and has not actually sent tags in the pack.  In such
> cases the client SHOULD issue a subsequent fetch to acquire the
> tags that include-tag would have otherwise given the client.
> 

How is "no tags present" signalled? Without such a signal, the client
must always issue a subsequent request every time there are no tags
embedded in the received pack, as it can't know if the server ignored
the option silently or if there just aren't any new tags.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Register now for Nordic Meet on Nagios, June 3-4 in Stockholm
 http://nordicmeetonnagios.op5.org/

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
