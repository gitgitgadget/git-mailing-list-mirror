From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: Undocumented git-diff syntax
Date: Mon, 11 Oct 2010 15:59:18 +0200
Message-ID: <AANLkTinqPiGf1nbo0oOvDD5edgLBdO8xZfjGeFC4q0MU@mail.gmail.com>
References: <20101011150342.292ad725@chalon.bertin.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Yann Dirson <dirson@bertin.fr>
X-From: git-owner@vger.kernel.org Mon Oct 11 15:59:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5Iuo-0007DH-J7
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 15:59:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754660Ab0JKN7k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Oct 2010 09:59:40 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:53351 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754431Ab0JKN7k convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Oct 2010 09:59:40 -0400
Received: by qwf7 with SMTP id 7so1833925qwf.19
        for <git@vger.kernel.org>; Mon, 11 Oct 2010 06:59:39 -0700 (PDT)
Received: by 10.229.94.137 with SMTP id z9mr5108914qcm.271.1286805579342; Mon,
 11 Oct 2010 06:59:39 -0700 (PDT)
Received: by 10.229.20.78 with HTTP; Mon, 11 Oct 2010 06:59:18 -0700 (PDT)
In-Reply-To: <20101011150342.292ad725@chalon.bertin.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158761>

On Mon, Oct 11, 2010 at 3:03 PM, Yann Dirson <dirson@bertin.fr> wrote:
[...]
>
> Another thought: if we can already compare arbitrary blobs, maybe it =
would not be so hard to
> extend it to take arbitrary contents that are not stored as blobs yet=
 ? =A0(a quick hack would be to
> insert an object for them, but that does not look too clean...). =A0A=
s a use-case, I'm often found generating diffs from within custom scrip=
ts, from contents derived from a git repo, but can't use all the bells =
and whistles (--color, --color-words, etc), just because I have to use =
plain diff;
> that makes the output of those scripts very inconsistent with native =
git commands.

Are you talking about "git diff --no-index"?

HTH,
Santi
