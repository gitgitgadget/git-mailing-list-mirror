From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 16:08:41 +0200
Message-ID: <vpqr6x711cm.fsf@ecrins.imag.fr>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<4534C5CF.3000508@op5.se> <vpqlknf3wdz.fsf@ecrins.imag.fr>
	<200610171555.56778.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, Andreas Ericsson <ae@op5.se>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: bazaar-ng-bounces@lists.canonical.com Tue Oct 17 16:09:45 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZpdZ-00070r-1e
	for gcvbg-bazaar-ng@m.gmane.org; Tue, 17 Oct 2006 16:09:45 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1GZpdV-0007Pp-Bo; Tue, 17 Oct 2006 15:09:41 +0100
Received: from imag.imag.fr ([129.88.30.1])
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <Matthieu.Moy@imag.fr>) id 1GZpdA-0007Oo-QN
	for bazaar-ng@lists.canonical.com; Tue, 17 Oct 2006 15:09:24 +0100
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.6/8.13.6) with ESMTP id k9HE8fbx017430
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 17 Oct 2006 16:08:42 +0200 (CEST)
Received: from ecrins.imag.fr ([129.88.43.124])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50) id 1GZpcX-0001gH-Gn; Tue, 17 Oct 2006 16:08:41 +0200
Received: from moy by ecrins.imag.fr with local (Exim 4.50)
	id 1GZpcX-0002cx-Dl; Tue, 17 Oct 2006 16:08:41 +0200
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200610171555.56778.jnareb@gmail.com> (Jakub Narebski's message
	of "Tue\, 17 Oct 2006 15\:55\:55 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6
	(imag.imag.fr [129.88.30.1]);
	Tue, 17 Oct 2006 16:08:42 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
X-BeenThere: bazaar-ng@lists.canonical.com
X-Mailman-Version: 2.1.8
Precedence: list
List-Id: bazaar-ng discussion <bazaar-ng.lists.canonical.com>
List-Unsubscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=unsubscribe>
List-Archive: <https://lists.ubuntu.com/archives/bazaar-ng>
List-Post: <mailto:bazaar-ng@lists.canonical.com>
List-Help: <mailto:bazaar-ng-request@lists.canonical.com?subject=help>
List-Subscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=subscribe>
Sender: bazaar-ng-bounces@lists.canonical.com
Errors-To: bazaar-ng-bounces@lists.canonical.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29077>

Jakub Narebski <jnareb@gmail.com> writes:

> While email can be used to exchange patches (git-format-patch to 
> generate patches, git-send-mail to send patches if you don't want to 
> use ordinary email client, git-am to apply patches) it cannot be used 
> to exchange all information (one cannot send for example tags, or merge 
> commits).

In bzr, the "bundle" appears like a patch, but it actually contain the
same information as the revision(s) it contains (I believe this
applies to hg and Darcs too). A bundle can be used almost like a
branch. That's a key point, since revision identity is not based on
content's hash, so applying a patch is very different from merging a
bundle.

> It is very usefull tool to have for "accidental" developer.

That's the key point, but patch review for non-accidental developpers
is also good :-).

> BTW. git can provide binary patch for binary files (e.g. adding favicon 
> for gitweb in git.git).

Bazaar's bundle use base64 encoding for binaries. I don't think that's
efficient binary diff (xdelta-like) though. Aaron has been fighting
quite a lot with MUA and MTA mixing up the patches (line ending in
particular) ...
