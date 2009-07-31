From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Request for benchmarking: x86 SHA1 code
Date: Fri, 31 Jul 2009 13:37:17 +0200
Message-ID: <4A72D76D.3050400@drmicha.warpmail.net>
References: <20090726232154.29594.qmail@science.horizon.com>	 <20090731104602.15375.qmail@science.horizon.com> <40aa078e0907310411k54dc58fbq9a938c489df56b68@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: George Spelvin <linux@horizon.com>, git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 13:38:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWqQy-0004Wn-CH
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 13:38:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752654AbZGaLhi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2009 07:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752029AbZGaLhh
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 07:37:37 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:36408 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752654AbZGaLhb (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Jul 2009 07:37:31 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 11B103BD805;
	Fri, 31 Jul 2009 07:37:32 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Fri, 31 Jul 2009 07:37:32 -0400
X-Sasl-enc: 1mFTjRJjfLTmpY+2h+MZ9Tkpv+voJa5SM5LmNPc57n9K 1249040252
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id AB3C6CFD;
	Fri, 31 Jul 2009 07:37:31 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.2pre) Gecko/20090728 Lightning/1.0pre Shredder/3.0b4pre
In-Reply-To: <40aa078e0907310411k54dc58fbq9a938c489df56b68@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124548>

Erik Faye-Lund venit, vidit, dixit 31.07.2009 13:11:
> On Fri, Jul 31, 2009 at 12:46 PM, George Spelvin<linux@horizon.com> wrote:
>> I haven't packaged this nicely, but it's not that complicated.
>> - Download Andy's original code from
>>  http://www.openssl.org/~appro/cryptogams/cryptogams-0.tar.gz
>> - Unpack and cd to the cryptogams-0/x86 directory
>> - "patch < this_email" to create "sha1test.c", "sha1-586.h", "Makefile",
>>   and "sha1-x86.pl".
>> - "make"
> 
> $ patch < ../sha1-opt.patch.eml
> patching file `Makefile'
> patching file `sha1test.c'
> patching file `sha1-586.h'
> patching file `sha1-x86.pl'
> 
> $ make
> make: *** No rule to make target `sha1-586.o', needed by `586test'.  Stop.
> 
> What did I do wrong? :)
> Would it be easier if you pushed it out somewhere?
> 

You need to go to the x86 directory, apply the patch and run make there.
(I made the same mistake.) Also, you i586 (32bit) glibc-devel if you're
on a 64 bit system.

Michael
