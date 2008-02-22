From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [PATCH] git.el: Add a git-grep command
Date: Fri, 22 Feb 2008 10:15:29 +0100
Message-ID: <87wsox9wsu.fsf@lysator.liu.se>
References: <87odaa4tcl.fsf@lysator.liu.se>
	<20080222073157.GA6630@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Alexandre Julliard <julliard@winehq.org>
To: Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Fri Feb 22 10:16:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSU0d-0008G3-TU
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 10:16:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752717AbYBVJPY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Feb 2008 04:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbYBVJPX
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 04:15:23 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:34832 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752067AbYBVJPU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 04:15:20 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 89E54200A207;
	Fri, 22 Feb 2008 10:15:19 +0100 (CET)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 22535-01-92; Fri, 22 Feb 2008 10:15:19 +0100 (CET)
Received: from krank (dns.vtab.com [62.20.90.195])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 1C772200A1E1;
	Fri, 22 Feb 2008 10:15:19 +0100 (CET)
Received: by krank (Postfix, from userid 1000)
	id 904C37B4078; Fri, 22 Feb 2008 10:15:29 +0100 (CET)
In-Reply-To: <20080222073157.GA6630@diana.vm.bytemark.co.uk> ("Karl
 =?utf-8?Q?Hasselstr=C3=B6m=22's?= message of "Fri\, 22 Feb 2008 08\:31\:57
 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74707>

Karl Hasselstr=C3=B6m <kha@treskal.com> writes:

> On 2008-02-19 14:03:18 +0100, David K=C3=A5gedal wrote:
>
>> This works for me, but before including it someone else should try
>> it. It might only work in Emacs 22, for instance.
>
> It works for me (also using emacs 22).
>
> I was a bit confused about the filename pattern selection, though: th=
e
> promt suggested "ch", which, when I accepted it, was converted to
> "*.[ch]". However, manually specifying "*.c" works as well. I'm not
> sure if this is specific to your patch or something affecting all gre=
p
> stuff in emacs (though I can't recall seeing it before).

This isn't invented by me, but is "standard" in the grep commands in
Emacs 22.  See the grep-files-aliases variable and the documentation
of rgrep.

--=20
David K=C3=A5gedal
