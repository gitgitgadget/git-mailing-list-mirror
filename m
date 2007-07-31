From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [PATCH] git.el: Support for incremental status updates.
Date: Tue, 31 Jul 2007 11:19:56 +0200
Message-ID: <87k5shudz7.fsf@morpheus.local>
References: <87sl7ekt40.fsf@wine.dyndns.org> <20070730232226.GA2413@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 31 11:20:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFntu-0007mI-25
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 11:20:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753052AbXGaJUT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 31 Jul 2007 05:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753685AbXGaJUS
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 05:20:18 -0400
Received: from main.gmane.org ([80.91.229.2]:36542 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752409AbXGaJUQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2007 05:20:16 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IFntd-0002ap-AE
	for git@vger.kernel.org; Tue, 31 Jul 2007 11:20:05 +0200
Received: from vtab.com ([62.20.90.195])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 31 Jul 2007 11:20:05 +0200
Received: from davidk by vtab.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 31 Jul 2007 11:20:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: vtab.com
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/22.1 (gnu/linux)
Cancel-Lock: sha1:OOB1TcV18kl6Sulj+C5wfCUdEsU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54329>

Karl Hasselstr=C3=B6m <kha@treskal.com> writes:

> On 2007-07-24 12:12:47 +0200, Alexandre Julliard wrote:
>
>> +    (if node (ewoc-set-data node info) (ewoc-enter-last status info=
))))
>
> My emacs doesn't like this. When i do "a" or "U" (and quite possibly
> others that I haven't tried yet) I get
>
>   git-insert-fileinfo: Symbol's function definition is void: ewoc-set=
-data

You probably need to add a (require 'ewoc).  Try loading ewoc and run
the command again.

--=20
David K=C3=A5gedal
