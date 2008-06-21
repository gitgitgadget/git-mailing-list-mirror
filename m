From: Jan Engelhardt <jengelh@medozas.de>
Subject: Re: about c8af1de9 (git status uses pager)
Date: Sat, 21 Jun 2008 23:45:46 +0200 (CEST)
Message-ID: <alpine.LNX.1.10.0806212343560.18093@fbirervta.pbzchgretzou.qr>
References: <alpine.LNX.1.10.0806212319410.22036@fbirervta.pbzchgretzou.qr> <19f34abd0806211430x3d7195d8idc61b7103f899947@mail.gmail.com> <7vzlpe8nyo.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Vegard Nossum <vegard.nossum@gmail.com>,
	Bart Trojanowski <bart@jukie.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 21 23:46:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAAux-0005xn-52
	for gcvg-git-2@gmane.org; Sat, 21 Jun 2008 23:46:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753238AbYFUVps (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jun 2008 17:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753210AbYFUVps
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jun 2008 17:45:48 -0400
Received: from sovereign.computergmbh.de ([85.214.69.204]:49135 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753183AbYFUVpr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jun 2008 17:45:47 -0400
Received: by sovereign.computergmbh.de (Postfix, from userid 25121)
	id C9F3618036065; Sat, 21 Jun 2008 23:45:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by sovereign.computergmbh.de (Postfix) with ESMTP id B1DBE1C01214F;
	Sat, 21 Jun 2008 23:45:46 +0200 (CEST)
In-Reply-To: <7vzlpe8nyo.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (LNX 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85730>


On Saturday 2008-06-21 23:42, Junio C Hamano wrote:

>"Vegard Nossum" <vegard.nossum@gmail.com> writes:
>
>> On Sat, Jun 21, 2008 at 11:21 PM, Jan Engelhardt <jengelh@medozas.de> wrote:
>>>
>>> Since git 1.5.6, `git status` always invokes a pager, which is really
>>> annoying when the output is less than the number of terminal rows
>>> available. Can I turn that off somehow or do I need to send a reverting
>>> patch?
>>
>> I think it would work to set PAGER="less -F" (a.k.a. --quit-if-one-screen)?
>
>Probably better with LESS=FRSX, which is what git uses as a sane default
>if nothing is set.
>
I went with Vegard's suggestion to change the pager command in
~/.gitconfig, since I have the $LESS environment variable already
defined as "-MSi", and I do not want to change that; because if I am
going to run less (often at the end of a pipe), I certainly do not
want it to just quit on me. So -F in $LESS is a no-no.

Since I need "-MRSi" for git anyhow, tweaking ~/.gitconfig was easy.
