From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: VCS comparison table
Date: Wed, 18 Oct 2006 08:22:13 +0200
Message-ID: <vpqpscqm9d6.fsf@ecrins.imag.fr>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<200610172301.27101.jnareb@gmail.com> <45354AD0.1020107@utoronto.ca>
	<200610172351.17377.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: bazaar-ng-bounces@lists.canonical.com Wed Oct 18 08:23:01 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ga4pI-0006fy-31
	for gcvbg-bazaar-ng@m.gmane.org; Wed, 18 Oct 2006 08:22:52 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1Ga4pH-0008Hu-0h; Wed, 18 Oct 2006 07:22:51 +0100
Received: from imag.imag.fr ([129.88.30.1])
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <Matthieu.Moy@imag.fr>) id 1Ga4pE-0008Hp-Aa
	for bazaar-ng@lists.canonical.com; Wed, 18 Oct 2006 07:22:48 +0100
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.6/8.13.6) with ESMTP id k9I6MEvT005253
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 18 Oct 2006 08:22:15 +0200 (CEST)
Received: from ecrins.imag.fr ([129.88.43.124])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50) id 1Ga4og-0006j1-0z; Wed, 18 Oct 2006 08:22:14 +0200
Received: from moy by ecrins.imag.fr with local (Exim 4.50)
	id 1Ga4of-0004ta-U7; Wed, 18 Oct 2006 08:22:13 +0200
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200610172351.17377.jnareb@gmail.com> (Jakub Narebski's message
	of "Tue\, 17 Oct 2006 23\:51\:16 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6
	(imag.imag.fr [129.88.30.1]);
	Wed, 18 Oct 2006 08:22:15 +0200 (CEST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29194>

Jakub Narebski <jnareb@gmail.com> writes:

>>> Fast-forward is a really good idea. Perhaps you could implement it,
>>> if it is not hidden under different name?
>> 
>> We support it as 'pull', but merge doesn't do it automatically, because
>> we'd rather have merge behave the same all the time, and because 'pull'
>> throws away your local commit ordering.
>
> I smell yet another terminology conflict (although this time fault is
> on the git side), namely that in git terminology "pull" is "fetch"
> (i.e. getting changes done in remote repository since laste "fetch"
> or since "clone") followed by merge. pull = fetch + merge.

AAUI, the initial claim was that after a rebase, git can do a
fast-forward, but Aaron has missed the /after a rebase/ part.

And yes, it the bzr terminology, bzr can do a "pull" after a "graft".
I don't think there's a fundamental difference here.
