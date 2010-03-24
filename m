From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: color (red) for error messages on all git commands
Date: Thu, 25 Mar 2010 00:12:28 +0100
Message-ID: <81b0412b1003241612m41f6ae2ctaa5b89ed37b58da2@mail.gmail.com>
References: <hoe4j3$2vg$1@dough.gmane.org>
	 <fabb9a1e1003241558t4c4c5cf8t3a7d9b9856937c4f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Neal Kreitzinger <neal@rsss.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 25 00:12:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuZkb-0003IT-AK
	for gcvg-git-2@lo.gmane.org; Thu, 25 Mar 2010 00:12:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752575Ab0CXXMb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Mar 2010 19:12:31 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:53929 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751754Ab0CXXMa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Mar 2010 19:12:30 -0400
Received: by bwz1 with SMTP id 1so414169bwz.21
        for <git@vger.kernel.org>; Wed, 24 Mar 2010 16:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=jJLsUVlmHW9NWNLNNmyl8k2FZrgR5xOeM7emcqnX0wo=;
        b=sycSvGpsLO2yh/fU0AablzFVzU3q16yzQkWfq9hAHi5PKeItGMYkTRKjPRrS02MvFC
         a850sgRV06bdfapTO1Bx/jm8hIdFT52J7sXKAEyxENFn7SLKBR1r9FJZyrMKsFBg1bhG
         nZyxAYsv3xWiUWRX5UOIUw28HPB2EnIcjNpYQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=sfYE8XG4/5fkxwIoqnqZ4RQCrREWsS4JmYmBs6PaDVpBpMHsCs/E/Et8L38n/JFric
         0QuNyFW9QCVB8v8KqEOZNpRoWw0DXflVbtWLCA3nPLShATA6yapIf9jFROIeZesVIlrR
         FmeNvEROD1DnVxLO6IeI5rEdZauCnAYKGcV7o=
Received: by 10.204.174.194 with SMTP id u2mr7695468bkz.40.1269472348772; Wed, 
	24 Mar 2010 16:12:28 -0700 (PDT)
In-Reply-To: <fabb9a1e1003241558t4c4c5cf8t3a7d9b9856937c4f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143136>

On Wed, Mar 24, 2010 at 23:58, Sverre Rabbelier <srabbelier@gmail.com> =
wrote:
> On Wed, Mar 24, 2010 at 23:44, Neal Kreitzinger <neal@rsss.com> wrote=
:
>> Desired Solution: =C2=A0configure git to display all error messages =
in color,
>> e.g. red, so that the programmer does not overlook error messages.

It is considered a good behavior for a UNIX program only to display
something if there is an error. Git just tries to follow this tradition=
=2E

> That's actually something I run into as well, I am so used to git jus=
t
> doing what I want that I don't notice the error messages when they
> occur. If this is indeed desired (probably controlled by color.warnin=
g
> and color.error?) it should be fairly easy to implement (see usage.c)=
=2E

That said, I also like the idea. Don't forget to check for tty in the p=
atch.
