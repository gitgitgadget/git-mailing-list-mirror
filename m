From: Eric Blake <ebb9@byu.net>
Subject: Re: git: avoiding merges, rebasing
Date: Tue, 02 Oct 2007 06:16:25 -0600
Message-ID: <47023699.3080606@byu.net>
References: <200709301421.52192.bruno@clisp.org>	<200710020347.43733.bruno@clisp.org>	<4AD64749-F4A3-4A61-B1EE-D12523293661@lrde.epita.fr>
	<200710021350.54625.bruno@clisp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: bug-gnulib@gnu.org, git@vger.kernel.org
To: Bruno Haible <bruno@clisp.org>
X-From: bug-gnulib-bounces+gnu-bug-gnulib=m.gmane.org@gnu.org Tue Oct 02 14:15:38 2007
Return-path: <bug-gnulib-bounces+gnu-bug-gnulib=m.gmane.org@gnu.org>
Envelope-to: gnu-bug-gnulib@m.gmane.org
Received: from lists.gnu.org ([199.232.76.165])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Icgf1-0001V4-TU
	for gnu-bug-gnulib@m.gmane.org; Tue, 02 Oct 2007 14:15:36 +0200
Received: from localhost ([127.0.0.1] helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43)
	id 1Icgex-0002WH-GW
	for gnu-bug-gnulib@m.gmane.org; Tue, 02 Oct 2007 08:15:31 -0400
Received: from mailman by lists.gnu.org with tmda-scanned (Exim 4.43)
	id 1Icger-0002W2-8t
	for bug-gnulib@gnu.org; Tue, 02 Oct 2007 08:15:25 -0400
Received: from exim by lists.gnu.org with spam-scanned (Exim 4.43)
	id 1Icgep-0002U5-CW
	for bug-gnulib@gnu.org; Tue, 02 Oct 2007 08:15:23 -0400
Received: from [199.232.76.173] (helo=monty-python.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43) id 1Icgep-0002Ty-7n
	for bug-gnulib@gnu.org; Tue, 02 Oct 2007 08:15:23 -0400
Received: from sccrmhc13.comcast.net ([63.240.77.83])
	by monty-python.gnu.org with esmtp (Exim 4.60)
	(envelope-from <ebb9@byu.net>) id 1Icgep-0007SM-5X
	for bug-gnulib@gnu.org; Tue, 02 Oct 2007 08:15:23 -0400
Received: from [192.168.0.103]
	(c-67-166-125-73.hsd1.ut.comcast.net[67.166.125.73])
	by comcast.net (sccrmhc13) with ESMTP
	id <2007100212152101300h8d22e>; Tue, 2 Oct 2007 12:15:22 +0000
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US;
	rv:1.8.1.6) Gecko/20070728 Thunderbird/2.0.0.6 Mnenhy/0.7.5.666
In-Reply-To: <200710021350.54625.bruno@clisp.org>
X-Enigmail-Version: 0.95.3
X-Detected-Kernel: NetCache Data OnTap 5.x
X-BeenThere: bug-gnulib@gnu.org
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: Gnulib discussion list <bug-gnulib.gnu.org>
List-Unsubscribe: <http://lists.gnu.org/mailman/listinfo/bug-gnulib>,
	<mailto:bug-gnulib-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/pipermail/bug-gnulib>
List-Post: <mailto:bug-gnulib@gnu.org>
List-Help: <mailto:bug-gnulib-request@gnu.org?subject=help>
List-Subscribe: <http://lists.gnu.org/mailman/listinfo/bug-gnulib>,
	<mailto:bug-gnulib-request@gnu.org?subject=subscribe>
Sender: bug-gnulib-bounces+gnu-bug-gnulib=m.gmane.org@gnu.org
Errors-To: bug-gnulib-bounces+gnu-bug-gnulib=m.gmane.org@gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59688>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

[adding the git list]

According to Bruno Haible on 10/2/2007 5:50 AM:
> Hello Benoit,
> 
>>>     $ git stash
>>>     $ git pull
>>>     $ git stash apply
>>>     $ git stash clean              ; typo!
>>>     $ git stash clear              ; fatal correction to typo!
>>>
>>> and lost 20 modified files. Well, not really lost. Just took me a  
>>> while to
>> I don't really see how and why you "lost 20 modified files".
> 
> I lost modifications to 20 files. "git stash clean" moved these modifications
> into a stash named "clean", and "git stash clear" killed it.

While we're at it, I wish 'git stash clear' would take an optional
argument that says which stash(es) to clear, rather than blindly clearing
the entire stash.

Short of that, there's always manually editing .git/logs/refs/stash, to
delete the lines to the stashes you no longer need, without killing the
ones you want kept.

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHAjaY84KuGfSFAYARAjqCAJ9qRzVxWpujzTGU9zdDi1UkQiSLggCeMien
LJhXdjlNHQYv0BUMCyZQo20=
=xPKQ
-----END PGP SIGNATURE-----
