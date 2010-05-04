From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 4/4] Documentation/notes: nitpicks
Date: Tue, 4 May 2010 09:09:42 +0200
Message-ID: <201005040909.43247.trast@student.ethz.ch>
References: <20100503233604.GA27451@progeny.tock> <20100503234720.GD27483@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Johan Herland <johan@herland.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 04 09:10:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9CGk-00076s-Nb
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 09:10:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753924Ab0EDHKH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 May 2010 03:10:07 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:13923 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753175Ab0EDHKG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 May 2010 03:10:06 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Tue, 4 May
 2010 09:10:04 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.254.0; Tue, 4 May
 2010 09:09:43 +0200
User-Agent: KMail/1.13.2 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.2; x86_64; ; )
In-Reply-To: <20100503234720.GD27483@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146298>

Jonathan Nieder wrote:
> -A typical use of notes is to extend a commit message without having
> -to change the commit itself. Such commit notes can be shown by `git log`
> -along with the original commit message. To discern these notes from the
> +A typical use of notes is to supplement a commit message without
> +changing the commit itself. Notes can be shown by 'git log' along with
> +the original commit message. To distinguish these notes from the
>  message stored in the commit object, the notes are indented like the
>  message, after an unindented line saying "Notes (<refname>):" (or
> -"Notes:" for the default setting).
> +"Notes:" for the main notes ref).

Nitpick on your nitpick: we do not call refs/notes/commits the "main"
notes ref anywhere, and you don't seem to introduce this terminology.

The user might infer that "main" means core.notesRef, but the omission
of (<refname>) is actually hardcoded to only happen for
refs/notes/commits, so that's not correct.


[I'll review the other patches after the lecture.]

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
