From: Mark Adler <madler@alumni.caltech.edu>
Subject: Re: Valgrind updates
Date: Wed, 28 Jan 2009 16:15:44 -0800
Message-ID: <4D595705-7935-4AC2-91F4-1DAB3C6C7D27@alumni.caltech.edu>
References: <alpine.DEB.1.00.0901210105470.19014@racer> <20090121001551.GB18169@coredump.intra.peff.net> <alpine.DEB.1.00.0901210119510.19014@racer> <20090121003739.GA18373@coredump.intra.peff.net> <alpine.DEB.1.00.0901210216440.19014@racer> <20090121190757.GB21686@coredump.intra.peff.net> <alpine.DEB.1.00.0901212259420.3586@pacific.mpi-cbg.de> <alpine.DEB.1.00.0901270327200.26199@intel-tinevez-2-302> <alpine.LFD.2.00.0901261934450.3123@localhost.localdomain> <alpine.DEB.1.00.0901270512171.14855@racer> <20090127131404.GA11870@sirena.org.uk> <alpine.DEB.1.00.0901271742430.3586@pacific.mpi-cbg.de> <alpine.LFD.2.00.0901271006060.3123@localhost.localdomain> <69A01114-27BB-4239-8FD8-C35D1306CE25@alumni.caltech.edu> <alpine.DEB.1.00.0901290024290.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jean-loup Gailly <jloup@gzip.org>,
	Mark Brown <broonie@sirena.org.uk>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 29 01:17:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSKbM-00033M-JL
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 01:17:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761587AbZA2APr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 19:15:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763156AbZA2APq
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 19:15:46 -0500
Received: from quest.jpl.nasa.gov ([137.79.56.36]:52751 "EHLO
	quest.jpl.nasa.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763152AbZA2APp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 19:15:45 -0500
Received: from dhcp-79-54-229.jpl.nasa.gov (dhcp-79-54-229.jpl.nasa.gov [137.79.54.229])
	by quest.jpl.nasa.gov (Postfix) with ESMTP id 77A6E3142858;
	Wed, 28 Jan 2009 16:15:42 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0901290024290.3586@pacific.mpi-cbg.de>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107603>

On Jan 28, 2009, at 3:27 PM, Johannes Schindelin wrote:
> On Wed, 28 Jan 2009, Mark Adler wrote:
>> 2.  Can someone send me the input and the 58 bytes of output from  
>> this
>>   case?
>
> I did better than that already...
> http://article.gmane.org/gmane.comp.version-control.git/107391

Johannes,

Thanks for the input and code.  When I run it, the byte in question at  
offset 51 is 0x2c.  The output decompresses fine and the result  
matches the input.  If I change the 0x2c to anything else,  
decompression fails.  The 58 bytes are below.

Can you also send me the 58 bytes of output that you get when you run  
it?  Thanks.

Mark



78 01 2b 29 4a 4d 55 30 34 33 65 30 34 30 30 33
31 51 48 cb cc 49 35 64 10 60 c0 04 48 0a 8c 18
14 30 e5 91 4d 30 66 30 c0 af c0 84 c1 01 bf 02
53 86 00 2c 0a 00 86 79 13 07
