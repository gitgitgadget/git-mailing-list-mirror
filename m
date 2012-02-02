From: David Barr <davidbarr@google.com>
Subject: Re: How to find and analyze bad merges?
Date: Thu, 2 Feb 2012 22:41:16 +1100
Message-ID: <CAFfmPPMc1V97OPHyrZp+p4YUek1c6fCncyj0s1YU9xjxQBCsDA@mail.gmail.com>
References: <jgdgcv$h8n$1@dough.gmane.org>
	<jgdn5j$v4g$1@dough.gmane.org>
	<87haz97c2k.fsf@thomas.inf.ethz.ch>
	<4F2A70DA.6020107@native-instruments.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Norbert Nemec <norbert.nemec@native-instruments.de>
X-From: git-owner@vger.kernel.org Thu Feb 02 12:41:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rsv2b-0003Ou-FY
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 12:41:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755747Ab2BBLlS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 06:41:18 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:33750 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754793Ab2BBLlR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 06:41:17 -0500
Received: by yhoo21 with SMTP id o21so1014500yho.19
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 03:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:x-system-of-record:content-type;
        bh=KnfYP6vU7vIwIO218M/FlmZALSNCSaxMyjXRtnT5LcU=;
        b=cbXFzynCEQZcYa/eKzyIbn/sY8+SvmIw1G0pDZLEFGxLHRV19IJrtU9vuVEbw4884M
         rpFfffuKARFAJDiXo4vWMNfuTu2IdEQPyrec/chl5akKqpV4P6mLx7acXbOOImIdetmL
         hLkQLjR0ietjgiepzuZxiEi7fUTwY8Mf/gOFE=
Received: by 10.236.173.132 with SMTP id v4mr3282611yhl.78.1328182876863;
        Thu, 02 Feb 2012 03:41:16 -0800 (PST)
Received: by 10.236.173.132 with SMTP id v4mr3282592yhl.78.1328182876739; Thu,
 02 Feb 2012 03:41:16 -0800 (PST)
Received: by 10.101.197.7 with HTTP; Thu, 2 Feb 2012 03:41:16 -0800 (PST)
In-Reply-To: <4F2A70DA.6020107@native-instruments.de>
X-System-Of-Record: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189632>

On Thu, Feb 2, 2012 at 10:17 PM, Norbert Nemec
<norbert.nemec@native-instruments.de> wrote:
> To be yet more precise:
>
> My complaint is that you need this kind of sledge-hammer solutions to
> analyze the situation. I, as an semi-expert with git did manage to find the
> problem without even having to resort to bisect or manually redoing the
> merge. My complaint is about the perspective of the medium-experienced user
> who is completely puzzled by the fact that a
> "git log <filename>" silently skips the critical merge commit.

Do the -c --cc or -m flags for git log help in this case?
They alter the way merge diffs are presented, as described under Diff Formatting
in the git-log(1)  man page.
--
David Barr
