From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: 2.6.21-rc1: known regressions (part 2)
Date: Mon, 5 Mar 2007 18:14:50 +0200
Message-ID: <20070305161450.GA4972@mellanox.co.il>
References: <20070227103021.GA2250@kernel.dk> <20070227103407.GA17819@elte.hu>
	<20070227105922.GD2250@kernel.dk> <20070227111515.GA4271@kernel.dk>
	<20070301093450.GA8508@elte.hu> <20070301104117.GA22788@elte.hu>
	<20070301145204.GA25304@elte.hu>
	<Pine.LNX.4.64.0703011536450.12485@woody.linux-foundation.org>
	<20070302072100.GB30634@elte.hu> <20070302080441.GA12785@elte.hu>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Daniel Walker <dwalker@mvista.com>,
   Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
   linux-pm@lists.osdl.org,
   Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
   Adrian Bunk <bunk@stusta.de>, Pavel Machek <pavel@ucw.cz>,
   Jens Axboe <jens.axboe@oracle.com>, Thomas Gleixner <tglx@linutronix.de>,
   Linus Torvalds <torvalds@linux-foundation.org>,
   Andrew Morton <akpm@linux-foundation.org>, git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: linux-pm-bounces@lists.osdl.org Mon Mar 05 17:14:33 2007
Return-path: <linux-pm-bounces@lists.osdl.org>
Envelope-to: gll-linux-pm@gmane.org
Received: from smtp.osdl.org ([65.172.181.24])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOFpX-0004Tu-Q8
	for gll-linux-pm@gmane.org; Mon, 05 Mar 2007 17:14:32 +0100
Received: from fire-2.osdl.org (localhost [127.0.0.1])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l25GEFq8030133;
	Mon, 5 Mar 2007 08:14:16 -0800
Received: from p02c11o142.mxlogic.net (p02c11o142.mxlogic.net [208.65.145.65])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l25GE8q8030121
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <linux-pm@lists.osdl.org>; Mon, 5 Mar 2007 08:14:09 -0800
Received: from unknown [194.90.237.34] (EHLO mtlexch01.mtl.com)
	by p02c11o142.mxlogic.net (mxl_mta-4.0.2-2)
	with ESMTP id 4d14ce54.2680847280.655.00-011.p02c11o142.mxlogic.net
	(envelope-from <mst@mellanox.co.il>); 
	Mon, 05 Mar 2007 09:14:12 -0700 (MST)
Received: from mellanox.co.il ([10.4.4.6]) by mtlexch01.mtl.com with Microsoft
	SMTPSVC(6.0.3790.1830); Mon, 5 Mar 2007 18:16:53 +0200
Received: by mellanox.co.il (sSMTP sendmail emulation);
	Mon,  5 Mar 2007 18:13:03 +0200
Content-Disposition: inline
In-Reply-To: <20070302080441.GA12785@elte.hu>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 05 Mar 2007 16:16:53.0837 (UTC)
	FILETIME=[B047FFD0:01C75F41]
X-TM-AS-Product-Ver: SMEX-7.0.0.1526-3.6.1039-15036.000
X-TM-AS-Result: No--4.715600-4.000000-4
X-Spam: [F=0.3758793268; S=0.375(2007010901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Received-SPF: pass (localhost is always allowed.)
X-Spam-Status: No, hits=-1.894 required=5 tests=AWL,OSDL_HEADER_LISTID_KNOWN,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-BeenThere: linux-pm@lists.osdl.org
X-Mailman-Version: 2.1.8
Precedence: list
List-Id: Linux power management <linux-pm.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41457>

> Quoting Ingo Molnar <mingo@elte.hu>:
>  git-bisect good      0539771d7236b425f285652f6f297cc7939c8f9a
> =

>  81450b73dde07f473a4a7208b209b4c8b7251d90 is first bad commit

I have confirmed these two on my system.

-- =

MST
