From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] make 'git clone' ask the remote only for objects it cares about
Date: Sat, 26 Sep 2009 09:21:07 +0200
Message-ID: <m2iqf62mu4.fsf@whitebox.home>
References: <m2tz0j154o.fsf@igel.home>
	<alpine.LFD.2.00.0908082246020.440@xanadu.home>
	<m2k51dzb39.fsf@linux-m68k.org> <4ABD0669.7050309@redhat.com>
	<vpqvdj6izt6.fsf@bauges.imag.fr>
	<alpine.LFD.2.00.0909251551290.4997@xanadu.home>
	<4ABD25FE.2040902@redhat.com>
	<alpine.LFD.2.00.0909251629330.4997@xanadu.home>
	<4ABD4F7B.4030701@redhat.com>
	<alpine.LFD.2.00.0909252045290.4997@xanadu.home>
	<alpine.LFD.2.00.0909252314260.4997@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Jason Merrill <jason@redhat.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org, Hin-Tak Leung <hintak.leung@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sat Sep 26 09:21:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrRao-0006Uw-Qu
	for gcvg-git-2@lo.gmane.org; Sat, 26 Sep 2009 09:21:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbZIZHVI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Sep 2009 03:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbZIZHVI
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Sep 2009 03:21:08 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:33696 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083AbZIZHVH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Sep 2009 03:21:07 -0400
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id D98741C0005C;
	Sat, 26 Sep 2009 09:21:08 +0200 (CEST)
X-Auth-Info: QzhepBDKkwoHECLm9uzZYIhwiol+qB3pzdQUwuB4/vY=
Received: from whitebox.home (DSL01.83.171.176.100.ip-pool.NEFkom.net [83.171.176.100])
	by mail.mnet-online.de (Postfix) with ESMTP id 8F40E901EA;
	Sat, 26 Sep 2009 09:21:08 +0200 (CEST)
Received: by whitebox.home (Postfix, from userid 501)
	id CBD381E5370; Sat, 26 Sep 2009 09:21:07 +0200 (CEST)
X-Yow: I just forgot my whole philosophy of life!!!
In-Reply-To: <alpine.LFD.2.00.0909252314260.4997@xanadu.home> (Nicolas Pitre's
	message of "Fri, 25 Sep 2009 23:54:42 -0400 (EDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129144>

Nicolas Pitre <nico@fluxnic.net> writes:

> The fact that the git repository on gcc.gnu.org has lots of stuff in 
> "remote" branches that don't get cloned by default is a separate 
> configuration/policy issue on that server which might need (or not) to 
> be looked into.  For instance at least, as a bare repository, it should 
> have all the git files in gcc.git/ directly instead of gcc.git/.git/.

The remote is just a git-svn tree.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
