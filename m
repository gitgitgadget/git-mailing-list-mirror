From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCH] checkout: add a space between the commit and "..."
Date: Wed, 29 Sep 2010 03:49:59 +0200
Message-ID: <AANLkTimLZwG5dOy2+rP0eKTp0DmRnaTYf7h3OBsL5fhM@mail.gmail.com>
References: <20100928222332.GA28859@soprano.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jkain@nvidia.com
To: Aaron Plattner <aplattner@nvidia.com>
X-From: git-owner@vger.kernel.org Wed Sep 29 03:50:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0loV-0005Ev-Qd
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 03:50:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751543Ab0I2BuZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Sep 2010 21:50:25 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:46780 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750861Ab0I2BuZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Sep 2010 21:50:25 -0400
Received: by qyk36 with SMTP id 36so231785qyk.19
        for <git@vger.kernel.org>; Tue, 28 Sep 2010 18:50:24 -0700 (PDT)
Received: by 10.229.88.10 with SMTP id y10mr629985qcl.144.1285725019543; Tue,
 28 Sep 2010 18:50:19 -0700 (PDT)
Received: by 10.229.20.78 with HTTP; Tue, 28 Sep 2010 18:49:59 -0700 (PDT)
In-Reply-To: <20100928222332.GA28859@soprano.nvidia.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157518>

On Wed, Sep 29, 2010 at 12:23 AM, Aaron Plattner <aplattner@nvidia.com>=
 wrote:
> Switching to a detached head prints something like
>
> =A0HEAD is now at 9d14017... dir.c: squelch false uninitialized memor=
y warning

You should also change the message when going from one detached HEAD to=
 another:

$ git co HEAD^
Previous HEAD position was 7bba3dd... Merge branch 'master' into next
HEAD is now at df51bf2... Merge branch 'dm/mergetool-vimdiff' into next

>
> These dots get selected when you double-click on the abbreviated
> commit hash, which makes it annoying to copy and paste.
>
> Add a space between the abbreviated commit and the dots, to improve
> copy and pasteability.

I would change it to mimic the output of "git commit", something like:

$ git co HEAD^
[HEAD was at 7bba3dd] Merge branch 'master' into next
[HEAD is now at df51bf2] Merge branch 'dm/mergetool-vimdiff' into next

HTH,
Santi
