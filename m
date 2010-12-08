From: Patrick Doyle <wpdster@gmail.com>
Subject: Re: git-svn checksum mismatch
Date: Wed, 8 Dec 2010 10:36:04 -0500
Message-ID: <AANLkTinZocHeu3ho6U9oL=Q608NBJaUf-nKehppWaDYp@mail.gmail.com>
References: <AANLkTik0NBkjrPTzLp9ozMnnV+bng_u5Br1v+H4y6ed0@mail.gmail.com> <AANLkTimVyCndGZQLUnVM9CCQmDfOHYywcfzBAL2w0gbC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Reynald Borer <reynald.borer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 08 16:36:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQM4F-0008KC-FV
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 16:36:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755313Ab0LHPg0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Dec 2010 10:36:26 -0500
Received: from mail-fx0-f43.google.com ([209.85.161.43]:40712 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751669Ab0LHPgZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Dec 2010 10:36:25 -0500
Received: by fxm18 with SMTP id 18so1199228fxm.2
        for <git@vger.kernel.org>; Wed, 08 Dec 2010 07:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=eQ55de/4QHKkRQ3aPtrJDmIMJuolMHfRoVX+8EEa7Zs=;
        b=XkCIKOKtor6FMBDYyldhLpDF1sqDt1eU8bmRQxmFeAzBZwX9BJTzDq1XxbeoMBHFFu
         8A/tn3XcVp8uo47vDNLy5GaDUy83SvQQHeG1YqtnpiOP1bPq0ERPuIiQlGjLsnmCDkkz
         jGmEHJ+Sqf5siJDGf8RRWNK8flrUEHzhW2GUA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=CO4Hg7BN05n+JrZxgv5Izrfb1RxDkJFPArL/uabc/dlGdKKwZLQwPj817YAqAPjyhM
         FBz8JgbjDrZDmIrAMvUvoGhN2lC3tJN0kjGGblM3kpNcep0IcSbiSWUWh6bCEQtE611V
         9PQJk9T1ZsFlpOXQK/obajj3UlU+xd5ewgx8w=
Received: by 10.223.116.1 with SMTP id k1mr8627697faq.51.1291822584419; Wed,
 08 Dec 2010 07:36:24 -0800 (PST)
Received: by 10.223.107.131 with HTTP; Wed, 8 Dec 2010 07:36:04 -0800 (PST)
In-Reply-To: <AANLkTimVyCndGZQLUnVM9CCQmDfOHYywcfzBAL2w0gbC@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163200>

On Wed, Dec 8, 2010 at 10:17 AM, Reynald Borer <reynald.borer@gmail.com> wrote:
> Hi again,
>
> Sorry to bother you again but I am still experiencing this problem. I
> tried with a more up to date version of Git (version 1.7.3.2), and
> this is still happening. I also tried to diagnose this issue but I am
> completely lost.
>
> I am very annoyed because this is preventing me using Git on all my
> SVN repos (2 are failing on 30...)
>
> Does anyone know how I could try to solve this issue?

Tossing out a random theory with nothing to back it up...

I don't know anything about the "well known checksum mismatch
problem", but are you trying to check out the SVN repository onto a
file system that is case insensitive, such as on a Windows or (default
setup) Mac host?

If so, the repository might have files with different spellings such
as README and Readme in the same directory, which will get clobbered
on such a host.  I've run into that issue in the past in a different
context.

--wpd
