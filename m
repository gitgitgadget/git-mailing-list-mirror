From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [PATCH 7/7] git-blame.el: Autoupdate while editing
Date: Fri, 09 Feb 2007 12:05:51 +0100
Message-ID: <87veiboak0.fsf@morpheus.local>
References: <87ejozpwp0.fsf@morpheus.local> <eqhfqv$bnu$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 09 12:10:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFTeF-0002nO-4Q
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 12:10:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423023AbXBILKc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 9 Feb 2007 06:10:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423038AbXBILKc
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Feb 2007 06:10:32 -0500
Received: from main.gmane.org ([80.91.229.2]:57331 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423023AbXBILKb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Feb 2007 06:10:31 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1HFTdi-0001fM-4I
	for git@vger.kernel.org; Fri, 09 Feb 2007 12:10:02 +0100
Received: from c83-253-22-207.bredband.comhem.se ([83.253.22.207])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Feb 2007 12:10:02 +0100
Received: from davidk by c83-253-22-207.bredband.comhem.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Feb 2007 12:10:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c83-253-22-207.bredband.comhem.se
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:LMRmeosKdcl1Qhr559ZcmjNeDmQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39176>

Jakub Narebski <jnareb@gmail.com> writes:

> [Cc: git@vger.kernel.org]
>
> David K?gedal wrote:
>
>> This adds the support for automatically updating the buffer while ed=
iting.
>> A configuration variable git-blame-autoupdate controls whether this =
should
>> be enabled or not.
>
> Can we use -L option of git-blame for this?

We do.

> BTW did you take a look at Font Lock modes: Fast Lock mode, Lazy Lock=
 mode,
> Just-in-time Lock mode?

I know of them (I use lazy-lock-mode, which I think is the
default). But what do you want me to look at?

--=20
David K=C3=A5gedal
