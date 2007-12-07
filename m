From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git and GCC
Date: Thu, 6 Dec 2007 21:21:35 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712062120100.13796@woody.linux-foundation.org>
References: <4aca3dc20712051947t5fbbb383ua1727c652eb25d7e@mail.gmail.com>  <20071205.202047.58135920.davem@davemloft.net>  <4aca3dc20712052032n521c344cla07a5df1f2c26cb8@mail.gmail.com>  <20071205.204848.227521641.davem@davemloft.net>   <4aca3dc20712052111o730f6fb6h7a329ee811a70f28@mail.gmail.com>  <alpine.LFD.0.9999.0712052132450.13796@woody.linux-foundation.org>  <4aca3dc20712061004g43f5902cw79bf633917d3ade9@mail.gmail.com>  <1196995353.22471.20.camel@brick>   <alpine.LFD.0.9999.0712061857060.13796@woody.linux-foundation.org> <9e4733910712062006l651571f3w7f76ce64c6650dff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Harvey Harrison <harvey.harrison@gmail.com>,         Daniel Berlin <dberlin@dberlin.org>,         David Miller <davem@davemloft.net>, ismail@pardus.org.tr,         gcc@gcc.gnu.org, git@vger.kernel.org
To: Jon Smirl <jonsmirl@gmail.com>
X-From: gcc-return-142786-gcc=m.gmane.org@gcc.gnu.org Fri Dec 07 06:22:38 2007
Return-path: <gcc-return-142786-gcc=m.gmane.org@gcc.gnu.org>
Envelope-to: gcc@gmane.org
Received: from sourceware.org ([209.132.176.174])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1J0VfY-0000Wp-OX
	for gcc@gmane.org; Fri, 07 Dec 2007 06:22:37 +0100
Received: (qmail 2515 invoked by alias); 7 Dec 2007 05:22:18 -0000
Received: (qmail 2503 invoked by uid 22791); 7 Dec 2007 05:22:17 -0000
X-Spam-Check-By: sourceware.org
Received: from smtp2.linux-foundation.org (HELO smtp2.linux-foundation.org) (207.189.120.14)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 07 Dec 2007 05:22:11 +0000
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55]) 	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lB75Lbdi022171 	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO); 	Thu, 6 Dec 2007 21:21:38 -0800
Received: from localhost (localhost [127.0.0.1]) 	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lB75LZ6d031437; 	Thu, 6 Dec 2007 21:21:35 -0800
In-Reply-To: <9e4733910712062006l651571f3w7f76ce64c6650dff@mail.gmail.com>
X-MIMEDefang-Filter: lf$Revision: 1.188 $
Mailing-List: contact gcc-help@gcc.gnu.org; run by ezmlm
Precedence: bulk
List-Id: <gcc.gcc.gnu.org>
List-Unsubscribe: <mailto:gcc-unsubscribe-gcc=m.gmane.org@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc@gcc.gnu.org>
List-Help: <http://gcc.gnu.org/ml/>
Sender: gcc-owner@gcc.gnu.org
Delivered-To: mailing list gcc@gcc.gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67378>



On Thu, 6 Dec 2007, Jon Smirl wrote:
> >
> >         time git blame -C gcc/regclass.c > /dev/null
> 
> jonsmirl@terra:/video/gcc$ time git blame -C gcc/regclass.c > /dev/null
> 
> real    1m21.967s
> user    1m21.329s

Well, I was also hoping for a "compared to not-so-aggressive packing" 
number on the same machine.. IOW, what I was wondering is whether there is 
a visible performance downside to the deeper delta chains in the 300MB 
pack vs the (less aggressive) 500MB pack.

		Linus
