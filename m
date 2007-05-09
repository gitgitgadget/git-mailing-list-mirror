From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: git rebase chokes on directory -> symlink -> directory
Date: Wed, 09 May 2007 09:58:23 -0700
Message-ID: <4641FDAF.3090608@zytor.com>
References: <463FCD7C.4020009@zytor.com> <20070508215009.GA2670@steel.home>	 <46413565.3090503@zytor.com> <81b0412b0705090050i644a18c2g12c74462ab88163a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 09 18:58:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlpUn-0001Ce-ML
	for gcvg-git@gmane.org; Wed, 09 May 2007 18:58:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756477AbXEIQ63 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 12:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756384AbXEIQ63
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 12:58:29 -0400
Received: from terminus.zytor.com ([192.83.249.54]:39383 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756297AbXEIQ62 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 12:58:28 -0400
Received: from tazenda.hos.anvin.org (c-67-169-144-158.hsd1.ca.comcast.net [67.169.144.158])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.8/8.13.7) with ESMTP id l49GwN6w025990
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 9 May 2007 09:58:24 -0700
User-Agent: Thunderbird 2.0.0.0 (X11/20070419)
In-Reply-To: <81b0412b0705090050i644a18c2g12c74462ab88163a@mail.gmail.com>
X-Enigmail-Version: 0.95.0
X-Virus-Scanned: ClamAV 0.88.7/3223/Tue May  8 16:17:59 2007 on terminus.zytor.com
X-Virus-Status: Clean
X-Spam-Status: No, score=1.8 required=5.0 tests=AWL,BAYES_00,
	DATE_IN_FUTURE_96_XX,RCVD_IN_NJABL_DUL,RCVD_IN_SORBS_DUL autolearn=no
	version=3.1.8
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.1.8 (2007-02-13) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46750>

Alex Riesen wrote:
> On 5/9/07, H. Peter Anvin <hpa@zytor.com> wrote:
>>
>> Mine stops already at the directory -> symlink checkin (the above is the
>> symlink -> directory one), but your trick of using "git checkout" as a
>> trick to resolve things helped for both... eventually :-/
>>
> 
> Hmm. What Git version do you have?

Not sure anymore, because I ran a systemwide upgrade late last night.
*Now* I have git-1.5.1.4, but I think I had 1.5.1.2 before.

>> Either way, it's still a bug that it stops for either checkin, ...
> 
> Right. And because it is a bug, I'd like to have it fixed.
> So, what did you do in that fixup?

I'm sorry, I'm not sure I understand the question, in particular, I'm
getting the feeling I'm not sure what "that fixup" refers to.

	-hpa
