From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [StGit PATCH] Cogito is deprecated, so don't point to it
Date: Mon, 05 Nov 2007 13:21:13 +0100
Message-ID: <87zlxsannq.fsf@lysator.liu.se>
References: <20071105030608.6033.35208.stgit@yoghurt>
	<vpqejf510ci.fsf@bauges.imag.fr>
	<20071105120014.GA17406@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Mon Nov 05 13:21:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ip0xK-0006zq-ME
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 13:21:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754627AbXKEMVM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Nov 2007 07:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754368AbXKEMVM
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 07:21:12 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:37067 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754575AbXKEMVL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Nov 2007 07:21:11 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id ACE73200A239;
	Mon,  5 Nov 2007 13:21:10 +0100 (CET)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 24631-01-47; Mon, 5 Nov 2007 13:21:10 +0100 (CET)
Received: from krank (c83-253-242-75.bredband.comhem.se [83.253.242.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 46D02200A229;
	Mon,  5 Nov 2007 13:21:10 +0100 (CET)
Received: by krank (Postfix, from userid 1000)
	id C14677B4095; Mon,  5 Nov 2007 13:21:13 +0100 (CET)
In-Reply-To: <20071105120014.GA17406@diana.vm.bytemark.co.uk> ("Karl
 =?utf-8?Q?Hasselstr=C3=B6m=22's?= message of "Mon\, 5 Nov 2007 13\:00\:14
 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63504>

Karl Hasselstr=C3=B6m <kha@treskal.com> writes:

> On 2007-11-05 10:57:17 +0100, Matthieu Moy wrote:
>
>> Karl Hasselstr=C3=B6m <kha@treskal.com> writes:
>>
>> > -directly). For standard SCM operations, either use plain GIT comm=
ands
>> > -or the Cogito tool but it is not recommended to mix them with the
>> > -StGIT commands.
>> > +directly). For standard SCM operations, use plain GIT commands.
>>
>> Doesn't the "but it is not recommended to mix them with the StGIT
>> commands." part still hold?
>
> I'm not sure it ever held. Except possibly during merge resolution,
> but that mismatch is going away with the patch series by David K=C3=A5=
gedal
> that's sitting in kha/experimental (which changes StGit to use exactl=
y
> the same conflict representation as git).

Don't forget your new assimilate implementation.

--=20
David K=C3=A5gedal
