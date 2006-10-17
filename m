From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 15:44:36 +0200
Message-ID: <vpqejt73vln.fsf@ecrins.imag.fr>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<Pine.LNX.4.64.0610161625370.3962@g5.osdl.org>
	<45345AEF.6070107@utoronto.ca> <200610171030.35854.jnareb@gmail.com>
	<vpqejt76vgz.fsf@ecrins.imag.fr>
	<BAYC1-PASMTP02ADC5BEF688E61583283CAE0E0@CEZ.ICE>
	<vpqbqob5euu.fsf@ecrins.imag.fr>
	<BAYC1-PASMTP10E107E5EB0F7E69167F41AE0E0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: bazaar-ng-bounces@lists.canonical.com Tue Oct 17 15:48:42 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZpIy-0002Pi-Gm
	for gcvbg-bazaar-ng@m.gmane.org; Tue, 17 Oct 2006 15:48:28 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1GZpIc-0005wv-8g; Tue, 17 Oct 2006 14:48:07 +0100
Received: from imag.imag.fr ([129.88.30.1])
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <Matthieu.Moy@imag.fr>) id 1GZpGF-0005n5-Ms
	for bazaar-ng@lists.canonical.com; Tue, 17 Oct 2006 14:46:27 +0100
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.6/8.13.6) with ESMTP id k9HDibo4012149
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 17 Oct 2006 15:44:38 +0200 (CEST)
Received: from ecrins.imag.fr ([129.88.43.124])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50) id 1GZpFE-000198-Tk; Tue, 17 Oct 2006 15:44:36 +0200
Received: from moy by ecrins.imag.fr with local (Exim 4.50)
	id 1GZpFE-0002S0-Qp; Tue, 17 Oct 2006 15:44:36 +0200
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP10E107E5EB0F7E69167F41AE0E0@CEZ.ICE> (Sean's message
	of "Tue\, 17 Oct 2006 08\:57\:23 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6
	(imag.imag.fr [129.88.30.1]);
	Tue, 17 Oct 2006 15:44:38 +0200 (CEST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29070>

Sean <seanlkml@sympatico.ca> writes:

>> Yes, but you will have to do a merge at some point, right ? While I'm
>> keeping a purely linear history (not that it is good in the general
>> case, but for "projects" on which I'm the only developper, I find it
>> good. For example, my ${HOME}/etc/).
>
> Well if you're committing changes from multiple different machines,
> how is that different from having say 3 different developers committing
> changes to the central repo?

The workflow is different.

If I commit broken changes on a repository shared by multiple
developers, they'll insult me, and they'll be right. While I find
nothing wrong in commiting broken changes to my ${HOME}/etc/ when
leaving the office, and fix it from home.

> How does bzr avoid a merge when you're pushing changes from 3
> separate machines?

Err, the same way people have been doing for years ;-). If you don't
have local commits, "bzr update" will work in the same way as "cvs
update", it keeps your local changes, without recording history. Like
"git pull" does if you have uncommited changes I think.
