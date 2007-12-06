From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: Re: [PATCH] gc --aggressive: make it really aggressive
Date: Thu, 06 Dec 2007 07:30:59 -0800
Message-ID: <1196955059.13633.3.camel@brick>
References: <4aca3dc20712051947t5fbbb383ua1727c652eb25d7e@mail.gmail.com> 	 <20071205.202047.58135920.davem@davemloft.net> 	 <4aca3dc20712052032n521c344cla07a5df1f2c26cb8@mail.gmail.com> 	 <20071205.204848.227521641.davem@davemloft.net> 	 <4aca3dc20712052111o730f6fb6h7a329ee811a70f28@mail.gmail.com> 	 <alpine.LFD.0.9999.0712052132450.13796@woody.linux-foundation.org> 	 <Pine.LNX.4.64.0712061201580.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Berlin <dberlin@dberlin.org>, David Miller <davem@davemloft.net>, ismail@pardus.org.tr,  gcc@gcc.gnu.org, git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: gcc-return-142746-gcc=m.gmane.org@gcc.gnu.org Thu Dec 06 16:31:41 2007
Return-path: <gcc-return-142746-gcc=m.gmane.org@gcc.gnu.org>
Envelope-to: gcc@gmane.org
Received: from sourceware.org ([209.132.176.174])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1J0IhQ-0007vD-8g
	for gcc@gmane.org; Thu, 06 Dec 2007 16:31:40 +0100
Received: (qmail 12639 invoked by alias); 6 Dec 2007 15:31:21 -0000
Received: (qmail 12630 invoked by uid 22791); 6 Dec 2007 15:31:21 -0000
X-Spam-Check-By: sourceware.org
Received: from rv-out-0910.google.com (HELO rv-out-0910.google.com) (209.85.198.186)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 06 Dec 2007 15:31:10 +0000
Received: by rv-out-0910.google.com with SMTP id f5so271290rvb         for <gcc@gcc.gnu.org>; Thu, 06 Dec 2007 07:31:08 -0800 (PST)
Received: by 10.141.153.16 with SMTP id f16mr2039426rvo.1196955068651;         Thu, 06 Dec 2007 07:31:08 -0800 (PST)
Received: from ?192.168.1.101? ( [216.19.190.48])         by mx.google.com with ESMTPS id k41sm62899rvb.2007.12.06.07.31.00         (version=TLSv1/SSLv3 cipher=RC4-MD5);         Thu, 06 Dec 2007 07:31:07 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0712061201580.27959@racer.site>
X-Mailer: Evolution 2.12.1
X-IsSubscribed: yes
Mailing-List: contact gcc-help@gcc.gnu.org; run by ezmlm
Precedence: bulk
List-Id: <gcc.gcc.gnu.org>
List-Unsubscribe: <mailto:gcc-unsubscribe-gcc=m.gmane.org@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc@gcc.gnu.org>
List-Help: <http://gcc.gnu.org/ml/>
Sender: gcc-owner@gcc.gnu.org
Delivered-To: mailing list gcc@gcc.gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67295>

Wow

/usr/bin/time git repack -a -d -f --window=250 --depth=250


23266.37user 581.04system 7:41:25elapsed 86%CPU (0avgtext+0avgdata
0maxresident)k
0inputs+0outputs (419835major+123275804minor)pagefaults 0swaps

-r--r--r-- 1 hharrison hharrison  29091872 2007-12-06 07:26
pack-1d46ca030c3d6d6b95ad316deb922be06b167a3d.idx
-r--r--r-- 1 hharrison hharrison 324094684 2007-12-06 07:26
pack-1d46ca030c3d6d6b95ad316deb922be06b167a3d.pack


That extra delta depth really does make a difference.  Just over a
300MB pack in the end, for all gcc branches/tags as of last night.

Cheers,

Harvey
