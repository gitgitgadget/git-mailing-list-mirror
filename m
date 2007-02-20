From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: git-blame.el won't run
Date: Tue, 20 Feb 2007 08:50:26 +0100
Message-ID: <87abz92rp9.fsf@morpheus.local>
References: <13283.1171492535@localhost> <87mz393mlo.fsf@morpheus.local> <24475.1171920735@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 20 08:50:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJPlr-0003ku-9B
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 08:50:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932825AbXBTHuk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 20 Feb 2007 02:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964854AbXBTHuk
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Feb 2007 02:50:40 -0500
Received: from main.gmane.org ([80.91.229.2]:43669 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932825AbXBTHuj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Feb 2007 02:50:39 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HJPli-00054H-2v
	for git@vger.kernel.org; Tue, 20 Feb 2007 08:50:34 +0100
Received: from c83-253-22-207.bredband.comhem.se ([83.253.22.207])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 20 Feb 2007 08:50:34 +0100
Received: from davidk by c83-253-22-207.bredband.comhem.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 20 Feb 2007 08:50:34 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c83-253-22-207.bredband.comhem.se
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:EnFqmgP6qeKnPu7jG5Lo8dpopVY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40208>

Xavier Maillard <zedek@gnu.org> writes:

> Hi,
>
>> Can you please set debug-on-error to t and show me the backtrace you=
 get?
>
> Nothing happens. I have to C-g after having waited for a few
> seconds.

I'm not sure my instructions were very clear.  Did you try M-x
git-blame-mode after enabling debug-on-error?

>> And does M-! git-blame work in your emacs?
>
> No it is not. It shows a help message (usage message).

But if the help message is for git-blame, it did work.  I wanted to
check that you could run git-blame from your emacs, and if it printed
a usage message, it did run.  If you want it to produce some real
output, you have to give it a file name as well.

--=20
David K=C3=A5gedal
