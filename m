From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: [patch] KVM: T60 resume fix
Date: Mon, 5 Mar 2007 12:23:07 +0200
Message-ID: <20070305102307.GA5029@mellanox.co.il>
References: <20070227105922.GD2250@kernel.dk> <20070227111515.GA4271@kernel.dk>
	<20070301093450.GA8508@elte.hu> <20070301104117.GA22788@elte.hu>
	<20070301145204.GA25304@elte.hu>
	<Pine.LNX.4.64.0703011536450.12485@woody.linux-foundation.org>
	<20070302072100.GB30634@elte.hu> <20070302080441.GA12785@elte.hu>
	<20070302102018.GA11549@elte.hu> <20070302102216.GA13575@elte.hu>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Daniel Walker <dwalker@mvista.com>,
   Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
   linux-pm@lists.osdl.org,
   Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
   Avi Kivity <avi@qumranet.com>, Adrian Bunk <bunk@stusta.de>,
   Pavel Machek <pavel@ucw.cz>, Jens Axboe <jens.axboe@oracle.com>,
   Thomas Gleixner <tglx@linutronix.de>,
   Linus Torvalds <torvalds@linux-foundation.org>,
   Andrew Morton <akpm@linux-foundation.org>, git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: linux-pm-bounces@lists.osdl.org Mon Mar 05 11:25:13 2007
Return-path: <linux-pm-bounces@lists.osdl.org>
Envelope-to: gll-linux-pm@gmane.org
Received: from smtp.osdl.org ([65.172.181.24])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOANS-0005WJ-6U
	for gll-linux-pm@gmane.org; Mon, 05 Mar 2007 11:25:12 +0100
Received: from fire-2.osdl.org (localhost [127.0.0.1])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l25AOpq8018773;
	Mon, 5 Mar 2007 02:24:56 -0800
Received: from dev.mellanox.co.il (dev.mellanox.co.il [194.90.237.44])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l25AOZq8018755
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <linux-pm@lists.osdl.org>; Mon, 5 Mar 2007 02:24:38 -0800
Received: from mellanox.co.il ([194.90.237.34])
	by dev.mellanox.co.il (8.13.1/8.13.1) with SMTP id l25AMMUf029293;
	Mon, 5 Mar 2007 12:22:27 +0200
Received: by mellanox.co.il (sSMTP sendmail emulation);
	Mon,  5 Mar 2007 12:23:07 +0200
Content-Disposition: inline
In-Reply-To: <20070302102216.GA13575@elte.hu>
User-Agent: Mutt/1.5.11
Received-SPF: pass (localhost is always allowed.)
X-Spam-Status: No, hits=-3.325 required=5 tests=AWL,OSDL_HEADER_LISTID_KNOWN,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41433>

> with this fix applied my laptop does not hang during resume.

On the off chance that this is relevant, could you post
your .config please?

-- =

MST
