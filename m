From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Cloning empty repositories, was Re: What is the idea for bare repositories?
Date: Wed, 14 Nov 2007 15:05:56 +0100
Message-ID: <vpqfxz8c46z.fsf@bauges.imag.fr>
References: <86k5on8v6p.fsf@lola.quinscape.zz>
	<20071112131927.GA1701@c3sl.ufpr.br>
	<Pine.LNX.4.64.0711121355380.4362@racer.site>
	<200711121719.54146.wielemak@science.uva.nl>
	<Pine.LNX.4.64.0711121624330.4362@racer.site>
	<vpq3avbv2ju.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0711121715090.4362@racer.site>
	<18232.35893.243300.179076@lisa.zopyra.com>
	<Pine.LNX.4.64.0711121727130.4362@racer.site>
	<vpq7iknqrtp.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0711121755460.4362@racer.site>
	<vpqy7d3pck0.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0711121804400.4362@racer.site>
	<vpqoddzpc88.fsf@bauges.imag.fr>
	<7v4pfr2kmh.fsf@gitster.siamese.dyndns.org>
	<87myth58r5.fsf@osv.gnss.ru> <fhettp$rtk$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 15:07:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsIst-0005ii-IA
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 15:06:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753650AbXKNOGK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 09:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753619AbXKNOGI
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 09:06:08 -0500
Received: from harmonie.imag.fr ([147.171.130.40]:38333 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752592AbXKNOGH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 09:06:07 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id lAEE5u53027966;
	Wed, 14 Nov 2007 15:05:56 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IsIsO-0004gU-Fz; Wed, 14 Nov 2007 15:05:56 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IsIsO-000125-Dd; Wed, 14 Nov 2007 15:05:56 +0100
In-Reply-To: <fhettp$rtk$1@ger.gmane.org> (Jakub Narebski's message of "Wed\, 14 Nov 2007 14\:41\:13 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Wed, 14 Nov 2007 15:05:56 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64985>

Jakub Narebski <jnareb@gmail.com> writes:

> Sergei Organov wrote:
>
>> Just a wild idea. Doesn't it make sense to introduce perfect ultimate
>> common ancestor of the universe, probably calling it "the NULL commit"?
>> At first glance it seems that it can help to avoid corner cases
>> automagically.
>
> No. Sometimes you want unrelated branches in repository ('html', 'man',
> 'todo' branches in git.git), sometimes multiple roots are natural (merging
> in a project, like git-mailtools, gitweb, gitk, git-gui in git.git).

There's no contradiction IMHO. At least bzr and Mercurial have the
notion of "null revision" that is a kind of virtual ancestor of the
first revision of a project, and AFAICT, they supprot having unrelated
branches in the same repository, and merging originally unrelated
projects together (not sure for Mercurial, but bzr can do it).

It just depends on the definition of "starting a project". Either you
say you start the project with "init", in which case all projects
start with the same thing, or you say you start with the first
"commit" in which case every project start with something different.

Anyway, we can't modify existing git projects now (adding an ancestor
to the initial revision would change each sha1 sum), so adding this
concept to git now would probably break all of it :-\.

-- 
Matthieu
