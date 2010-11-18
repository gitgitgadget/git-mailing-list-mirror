From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: Versioning configuration files on a server: fatal: Unable to
 create '//etc/.git/index.lock': No such file or directory
Date: Thu, 18 Nov 2010 17:00:10 +0100
Message-ID: <AANLkTikbb-PaZoWG4yCtpmMnU-PQiO0wtaXGT+KReOto@mail.gmail.com>
References: <AANLkTi=UPWTeZP9uF+FGtsSs7wH3AmwdeLtsPJQnKvez@mail.gmail.com>
 <20101117112042.GX22067@login.drsnuggles.stderr.nl> <20101118155211.GE22067@login.drsnuggles.stderr.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Albert Strasheim <fullung@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 18 17:00:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJ6uf-00078f-Iw
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 17:00:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757046Ab0KRQAd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Nov 2010 11:00:33 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:50352 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758396Ab0KRQAc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Nov 2010 11:00:32 -0500
Received: by vws13 with SMTP id 13so1731326vws.19
        for <git@vger.kernel.org>; Thu, 18 Nov 2010 08:00:31 -0800 (PST)
Received: by 10.229.241.9 with SMTP id lc9mr737025qcb.112.1290096031158; Thu,
 18 Nov 2010 08:00:31 -0800 (PST)
Received: by 10.229.105.76 with HTTP; Thu, 18 Nov 2010 08:00:10 -0800 (PST)
In-Reply-To: <20101118155211.GE22067@login.drsnuggles.stderr.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161678>

On Thu, Nov 18, 2010 at 4:52 PM, Matthijs Kooijman <matthijs@stdin.nl> wrote:
> Hi all,
>
>> I've been using git for exactly this purpose succesfully for a while now
>> (git 1.5.6.5 from Debian stable and I think also 1.7.2.3 from Debian
>> testing).
> Coming back to the testing machine I was using this on, I see this
> problem as well now. I'm pretty sure it wasn't there before, which would
> mean it was introduced by a recent upgrade.
>
> Checking the logs shows that I was running 1.7.1 before, and now 1.7.2.3
> is broken. Downgrading to 1.7.1 indeed removes the problem.
>
> I've rummaged around in the source a bit, haven't found the cause yet
> (and I'm out of time now).

Alternatively, you could try to bisect, with "git bisect", between
these two commits, 1.7.2.3=bad and 1.7.1=good. It is roughly 10 steps.

HTH,
Santi
