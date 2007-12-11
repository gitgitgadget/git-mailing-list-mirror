From: "Daniel Berlin" <dberlin@dberlin.org>
Subject: Re: Something is broken in repack
Date: Tue, 11 Dec 2007 12:28:25 -0500
Message-ID: <4aca3dc20712110928ybb84c16n40b6dbd50feddb06@mail.gmail.com>
References: <9e4733910712071505y6834f040k37261d65a2d445c4@mail.gmail.com> 	 <9e4733910712101825l33cdc2c0mca2ddbfd5afdb298@mail.gmail.com> 	 <alpine.LFD.0.99999.0712102231570.555@xanadu.home> 	 <9e4733910712102125w56c70c0cxb8b00a060b62077@mail.gmail.com> 	 <9e4733910712102129v140c2affqf2e73e75855b61ea@mail.gmail.com> 	 <9e4733910712102301p5e6c4165v6afb32d157478828@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Nicolas Pitre" <nico@cam.org>, "Junio C Hamano" <gitster@pobox.com>,  	gcc@gcc.gnu.org, "Git Mailing List" <git@vger.kernel.org>
To: "Jon Smirl" <jonsmirl@gmail.com>
X-From: gcc-return-142915-gcc=m.gmane.org@gcc.gnu.org Tue Dec 11 18:28:56 2007
Return-path: <gcc-return-142915-gcc=m.gmane.org@gcc.gnu.org>
Envelope-to: gcc@gmane.org
Received: from sourceware.org ([209.132.176.174])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1J28ub-0007vt-Jr
	for gcc@gmane.org; Tue, 11 Dec 2007 18:28:54 +0100
Received: (qmail 5560 invoked by alias); 11 Dec 2007 17:28:34 -0000
Received: (qmail 5550 invoked by uid 22791); 11 Dec 2007 17:28:33 -0000
X-Spam-Check-By: sourceware.org
Received: from wr-out-0506.google.com (HELO wr-out-0506.google.com) (64.233.184.226)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Tue, 11 Dec 2007 17:28:29 +0000
Received: by wr-out-0506.google.com with SMTP id 60so1879592wri         for <gcc@gcc.gnu.org>; Tue, 11 Dec 2007 09:28:27 -0800 (PST)
Received: by 10.142.191.2 with SMTP id o2mr3761281wff.1197394105207;         Tue, 11 Dec 2007 09:28:25 -0800 (PST)
Received: by 10.142.217.1 with HTTP; Tue, 11 Dec 2007 09:28:25 -0800 (PST)
In-Reply-To: <9e4733910712102301p5e6c4165v6afb32d157478828@mail.gmail.com>
Content-Disposition: inline
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67888>

On 12/11/07, Jon Smirl <jonsmirl@gmail.com> wrote:
>
> Total CPU time 196 CPU minutes vs 190 for gcc. Google's claims of
> being faster are not true.

Depends on your allocation patterns. For our apps, it certainly is :)
Of course, i don't know if we've updated the external allocator in a
while, i'll bug the people in charge of it.
