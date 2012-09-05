From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: poll() emulation in git
Date: Wed, 5 Sep 2012 15:36:54 +0200
Message-ID: <00d801cd8b6b$844bbcd0$8ce33670$@schmitz-digital.de>
References: <00c001cd8b59$028e41c0$07aac540$@schmitz-digital.de>
	<50474001.5030407@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: bug-gnulib@gnu.org, git@vger.kernel.org,
	'Junio C Hamano' <gitster@pobox.com>,
	'Erik Faye-Lund' <kusmabite@gmail.com>
To: "'Paolo Bonzini'" <bonzini@gnu.org>
X-From: bug-gnulib-bounces+gnu-bug-gnulib=m.gmane.org@gnu.org Wed Sep 05 15:37:26 2012
Return-path: <bug-gnulib-bounces+gnu-bug-gnulib=m.gmane.org@gnu.org>
Envelope-to: gnu-bug-gnulib@m.gmane.org
Received: from lists.gnu.org ([208.118.235.17])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <bug-gnulib-bounces+gnu-bug-gnulib=m.gmane.org@gnu.org>)
	id 1T9FnI-0005yE-Ng
	for gnu-bug-gnulib@m.gmane.org; Wed, 05 Sep 2012 15:37:24 +0200
Received: from localhost ([::1]:55098 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bug-gnulib-bounces+gnu-bug-gnulib=m.gmane.org@gnu.org>)
	id 1T9FnF-0003U8-Lu
	for gnu-bug-gnulib@m.gmane.org; Wed, 05 Sep 2012 09:37:21 -0400
Received: from eggs.gnu.org ([208.118.235.92]:52573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jojo@schmitz-digital.de>) id 1T9Fn7-0003Th-8V
	for bug-gnulib@gnu.org; Wed, 05 Sep 2012 09:37:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jojo@schmitz-digital.de>) id 1T9Fmx-0007CY-Ii
	for bug-gnulib@gnu.org; Wed, 05 Sep 2012 09:37:13 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:55897)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jojo@schmitz-digital.de>)
	id 1T9Fmx-0007CO-8n; Wed, 05 Sep 2012 09:37:03 -0400
Received: from DualCore (dsdf-4db50426.pool.mediaWays.net [77.181.4.38])
	by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis)
	id 0M3O8y-1TQvCG2Ugi-00r1Qe; Wed, 05 Sep 2012 15:37:01 +0200
In-Reply-To: 
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQIgUOmy4ZEsU7RI7VRx80YFphUkTAI89tULlsQ0qHCAABLG8A==
Content-Language: de
X-Provags-ID: V02:K0:rJFpXToeAwt0wI6L3giAeQgB018EDKAOHS+8TGqW4m/
	w+M5qhhP3KfMsrKHMPJvxhDOX30HKoiqIXuGXRPbMWFF5SHl6G
	mi7hdZdOFj5srScizEFuBVEGwJRcnitt1OmPIslVQXvz/A82WR
	kGdLxYf7Oi12ZXg/B52NAGkfIct3qvjN61YrvW5TloETME3XDA
	PYhcZjVENB3MO03TPn7H7/RCReQgQvWwGLetkMdkaYEIjN+kfm
	ztriYD2Ch813j6AqYuAnCqDcmBc5o1M5BxnlJ3PQgq4QK6c/Pl
	9ZPAQt0JdzD+QBAtm3vPnGv4eTdYUMWvfy1lMSwvNgK8wa2VYl
	gnvcEVK6FULlmBsYpHv1X3SGT+mf9E3S5LXzhLE0mC2ZWW8Pht
	xOH/Xin8sPVWg==
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 212.227.126.186
X-BeenThere: bug-gnulib@gnu.org
X-Mailman-Version: 2.1.14
Precedence: list
List-Id: Gnulib discussion list <bug-gnulib.gnu.org>
List-Unsubscribe: <https://lists.gnu.org/mailman/options/bug-gnulib>,
	<mailto:bug-gnulib-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/bug-gnulib>
List-Post: <mailto:bug-gnulib@gnu.org>
List-Help: <mailto:bug-gnulib-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/bug-gnulib>,
	<mailto:bug-gnulib-request@gnu.org?subject=subscribe>
Errors-To: bug-gnulib-bounces+gnu-bug-gnulib=m.gmane.org@gnu.org
Sender: bug-gnulib-bounces+gnu-bug-gnulib=m.gmane.org@gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204823>

> From: Joachim Schmitz [mailto:jojo@schmitz-digital.de]
> Sent: Wednesday, September 05, 2012 2:58 PM
> To: 'Paolo Bonzini'
> Cc: 'Junio C Hamano'; 'git@vger.kernel.org'; 'Erik Faye-Lund'; 'bug-gnulib@gnu.org'
> Subject: RE: poll() emulation in git
> 
> > From: Paolo Bonzini [mailto:paolo.bonzini@gmail.com] On Behalf Of Paolo Bonzini
> > Sent: Wednesday, September 05, 2012 2:05 PM
> > To: Joachim Schmitz
> > Cc: 'Junio C Hamano'; git@vger.kernel.org; 'Erik Faye-Lund'; bug-gnulib@gnu.org
> > Subject: Re: poll() emulation in git
> >
> > Il 05/09/2012 13:24, Joachim Schmitz ha scritto:
> > > However: this poll implementation, while compiling OK, doesn't work properly.
> > > Because it uses recv(...,MSG_PEEK), it works on sockets only (returns ENOTSOCK on anything else), while the real poll() works
on all
> > > kind if file descriptors, at least that is my understanding.
> >
> > Actually recv(...,MSG_PEEK) on most Unix variants works on non-sockets
> > too.  The trick is taken from GNU Pth in turn.
> >
> > > Here on HP NonStop, when being connected via an non-interactive SSH, we get a set of pipes (stdin, stdout, stderr) instead of
a
> > > socket to talk to, so the poll() just hangs/loops.
> >
> > Does your system have a working FIONREAD ioctl for pipes?
> 
> It does have FIONREAD ioctl. Whether it works properly is to be determined...
> I'll test if you could show me how?

Oh, now I see what you aimed at, but no, that Mac OS X method doesn't work for me, I tried (at least I think I did).

And <sys/ioctl.h> has
/*
 * Normal IOCTL's supported by the socket interface
 */
#define FIONREAD        _IOR(0, 8, _ioctl_int)       /* Num of bytes to read */
#define FIONBIO         _IOW(0, 9, _ioctl_int)       /* Non-blocking I/O     */

So these seem to be supported on sockets only, I guess.
And indeed the man pages for ioctl confirms:

          Valid values for the request parameter for AF_INET or
          AF_INET6 sockets are:


          FIONREAD  Gets the number of bytes available for reading and
                    stores it at the int pointed at by arg.


So not even AF_UNIX sockets, not to mention pipes...

Bye, Jojo
