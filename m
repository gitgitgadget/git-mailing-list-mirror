From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: git remote show origin (URL)
Date: Mon, 11 Jul 2011 18:24:38 +0200
Message-ID: <CA+gHt1AxfgB=zJ2hVZ-7gZzyPFDuTyFW_NqiepobTWHRsafAhw@mail.gmail.com>
References: <1310400505376-6571492.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: frankkany <frankkany@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 11 18:25:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgJI8-0002Hn-4e
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jul 2011 18:25:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758074Ab1GKQY7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jul 2011 12:24:59 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:51238 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757945Ab1GKQY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2011 12:24:58 -0400
Received: by pzk9 with SMTP id 9so3276472pzk.19
        for <git@vger.kernel.org>; Mon, 11 Jul 2011 09:24:58 -0700 (PDT)
Received: by 10.68.32.193 with SMTP id l1mr6069082pbi.177.1310401498073; Mon,
 11 Jul 2011 09:24:58 -0700 (PDT)
Received: by 10.68.41.134 with HTTP; Mon, 11 Jul 2011 09:24:38 -0700 (PDT)
In-Reply-To: <1310400505376-6571492.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176867>

Hello,

On Mon, Jul 11, 2011 at 6:08 PM, frankkany <frankkany@gmail.com> wrote:
> On box (A), when using "git remote show origin", I'm used to seeing something
> like the following next to the FETCH/PUSH URL:
> "git@somegitrepo.com:somefolder/someproject.git"
>
> The URL is actually pingable.
>
> On box (B), when using "git remote show origin" on an unfamiliar project,
> the FETCH/PUSH URL is: "hidden-repos:repositories/mysteryproject.git".
>
> How can I find where the actual url/directory where "hidden-repos" is
> pointing?

Maybe it is using an url.<base>.insteadOf that is set to
"hidden-repos:", check it with "git config -l".

But here the output of "git remote show $repo" is with the actual url,
not with the "hidden" ones, so not sure if it is your case.

HTH,
Santi
