From: David Chanters <david.chanters@googlemail.com>
Subject: Re: Creating CVS-style patch headers with git-diff
Date: Sat, 8 Jan 2011 15:35:39 +0000
Message-ID: <AANLkTi=_YdTsvFboQAj447SUtcxrVhM18QkvSVdpvdMJ@mail.gmail.com>
References: <AANLkTinmq=3kJmtSVutf7dHAQ0QL3fr9_E3hZ7gDe1JY@mail.gmail.com>
	<4D284F57.2000808@dbservice.com>
	<AANLkTinx9qM=fjH53UodY0G870Ne3wpFiFEgEGNXxOY7@mail.gmail.com>
	<m2vd1za0af.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tomas Carnecky <tom@dbservice.com>, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sat Jan 08 16:35:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbapW-0007Kp-Aa
	for gcvg-git-2@lo.gmane.org; Sat, 08 Jan 2011 16:35:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753084Ab1AHPfl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Jan 2011 10:35:41 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39881 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752937Ab1AHPfk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Jan 2011 10:35:40 -0500
Received: by fxm20 with SMTP id 20so17728528fxm.19
        for <git@vger.kernel.org>; Sat, 08 Jan 2011 07:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=e961I4X3ao3yfXbQQ8oEVYbedj+gSuqP5aSmN3BfsS0=;
        b=WwMaNAuNX8+zcteOD/sOoPlTV1HjfyKB5YhCGMf0gBlp4BMUYmod1b1vkiNuyYUXGg
         w4G+G9lUmoEF78iND6n3s2lI6U9PF+1De2MjdgOD4rFicygQbWxWL8eU2kDc0a1C0dGw
         dJyoJd+nSq61+iPDofRGRMqWG2xF0xFxNcxO8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Dz39JManhBge1trVWGCIJsqITpV6KeKHn3aOqGh+uJu+P1BsTkfdVgWh7r9XgsBFiv
         ypWZUUyYKAn4gvrnB94nP8s+NGQorDue70BHed7OFaIXEXRGGQgIhjAuyZRFed1yIGIu
         WDV8GpRPRcZGMdJokEQkRrhZIRohNXILBMv8Y=
Received: by 10.223.83.194 with SMTP id g2mr1389676fal.75.1294500939248; Sat,
 08 Jan 2011 07:35:39 -0800 (PST)
Received: by 10.223.86.197 with HTTP; Sat, 8 Jan 2011 07:35:39 -0800 (PST)
In-Reply-To: <m2vd1za0af.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164825>

On 8 January 2011 15:21, Andreas Schwab <schwab@linux-m68k.org> wrote:
> David Chanters <david.chanters@googlemail.com> writes:
>
>> Well, any one of those goals, really. =A0I just want to generate a p=
atch
>> that CVS won't barf on
>
> What does "CVS won't barf" mean in this context? =A0CVS does not oper=
ate
> on patches.

Sorry about that, that's poor wording on my part.  I don't mean "CVS
won't barf" -- I meant that GNU Patch can still apply the patch
without the meta-data referencing git still.  I think though this
"--no-prefix" option might just do it.

David
