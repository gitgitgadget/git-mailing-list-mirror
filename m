From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [RFC/PATCH] rebase -i: add run command to launch a shell command
Date: Wed, 28 Jul 2010 16:12:36 +0200
Message-ID: <AANLkTinvVFvu7WvwrRC0sg8vhoepFXKewmuTr7S94LWk@mail.gmail.com>
References: <1280323784-27462-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Jul 28 16:13:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oe7NX-0007JY-0k
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 16:13:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754510Ab0G1OM6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jul 2010 10:12:58 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42808 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754465Ab0G1OM5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 10:12:57 -0400
Received: by fxm14 with SMTP id 14so1268258fxm.19
        for <git@vger.kernel.org>; Wed, 28 Jul 2010 07:12:56 -0700 (PDT)
Received: by 10.103.40.11 with SMTP id s11mr1346687muj.112.1280326376153; Wed, 
	28 Jul 2010 07:12:56 -0700 (PDT)
Received: by 10.102.58.11 with HTTP; Wed, 28 Jul 2010 07:12:36 -0700 (PDT)
In-Reply-To: <1280323784-27462-1-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152089>

On Wed, Jul 28, 2010 at 3:29 PM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> The typical usage pattern would be to run a test (or simply a compilation
> command) at given points in history.
>
> The shell command is ran, and the rebase is stopped when the command
> fails, to give the user an opportunity to fix the problem before
> continuing with "git rebase --continue".
>

I think this is a useful addition, but I would find it more useful if
I could run a command (make test) on top of all commits of a patch
series, like:

$ git run HEAD^4.. command arguments

(I'm not quite sure about the syntax). Something like "git bisect run"
but for all the commits in the range.

 I know you said "given points in history", maybe each approach is
useful for each use case.

Thanks,
Santi
