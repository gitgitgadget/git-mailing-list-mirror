From: "H. Peter Anvin" <hpa@kernel.org>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Wed, 27 Aug 2008 07:49:31 -0700
Organization: Linux Kernel Organization, Inc.
Message-ID: <48B5697B.3030405@kernel.org>
References: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org>	<1219664940.9583.42.camel@pmac.infradead.org>	<alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de>	<7vy72kek6y.fsf@gitster.siamese.dyndns.org>	<20080826145719.GB5046@coredump.intra.peff.net>	<7vr68b8q9p.fsf@gitster.siamese.dyndns.org>	<20080826210318.GA6305@coredump.intra.peff.net> <76718490808261924j1ddae535tdfb671dd9d3298aa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, users@kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 16:54:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYMPu-0005cd-BK
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 16:54:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754451AbYH0Oxc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 10:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754364AbYH0Oxc
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 10:53:32 -0400
Received: from terminus.zytor.com ([198.137.202.10]:32857 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753960AbYH0Oxb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 10:53:31 -0400
Received: from mail.hos.anvin.org (c-98-210-181-100.hsd1.ca.comcast.net [98.210.181.100])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.2/8.14.1) with ESMTP id m7REncLo030081
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 27 Aug 2008 07:49:39 -0700
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.14.2/8.13.8) with ESMTP id m7REncnF017101;
	Wed, 27 Aug 2008 07:49:38 -0700
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.14.2/8.13.6) with ESMTP id m7REnVww017061;
	Wed, 27 Aug 2008 07:49:32 -0700
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <76718490808261924j1ddae535tdfb671dd9d3298aa@mail.gmail.com>
X-Virus-Scanned: ClamAV 0.93.3/8098/Wed Aug 27 03:36:31 2008 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93892>

Jay Soffian wrote:
> On Tue, Aug 26, 2008 at 5:03 PM, Jeff King <peff@peff.net> wrote:
>> I was slightly negative on the change at the time of "/usr/bin vs
>> /usr/libexec/git-core" and I planned to put "git --exec-path" in my
>> PATH. But I gave the new way a try, and I have not been very bothered.
>> So let me say that I really don't care much what happens with libexec,
>> and you can hold me to that when the next flame-war breaks out if such a
>> change is implemented. Now you have three opinions. :)
> 
> +1 on removing the links and I will say this: this change finally
> motivated me to switch my login shell from tcsh (12 years I've been
> using it!) to bash so I could use the completions and I'm happier for
> it. So thank you git. :-)
> 

Speaking as a tcsh user, I'm not switching until bash gets the 
equivalent functionality as tcsh aliases, in particular the ability to 
selectively disable wildcard expansion on a command-by-command basis.

	-hpa
