From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: serious problem with `git format-patch' & `git am'
Date: Fri, 27 Feb 2009 09:47:49 -0600
Message-ID: <zE3C931NyNaTaadZOgAI_rGf6gmkKr-3ZHRVXh87mHpCMs-0hfnhYg@cipher.nrlssc.navy.mil>
References: <20090225.230352.177616203.wl@gnu.org> <6HVVE8kW9V0CsNfW21a_Tqpt2s-IrJbt2_qdAvQ8r1tetEhb6jr18g@cipher.nrlssc.navy.mil> <m3ljrsvg0e.fsf@localhost.localdomain> <7viqmwpr2x.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, Werner LEMBERG <wl@gnu.org>,
	git@vger.kernel.org, keithp@keithp.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 27 16:50:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ld4yK-0006xh-3s
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 16:49:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755632AbZB0Ps1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 10:48:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755610AbZB0Ps1
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 10:48:27 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:50430 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755253AbZB0Ps0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 10:48:26 -0500
Received: by mail.nrlssc.navy.mil id n1RFloH1011370; Fri, 27 Feb 2009 09:47:50 -0600
In-Reply-To: <7viqmwpr2x.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 27 Feb 2009 15:47:50.0647 (UTC) FILETIME=[BEBF1070:01C998F2]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111678>


Junio,

I think you are the author of git-am.sh.

What does this line do?

git-am.sh line 375:

    case "$keep_subject" in -k)  SUBJECT="[PATCH] $SUBJECT" ;; esac

It appears to do nothing.  It has existed since the beginning of git-am.sh,
and there has never been another reference to $keep_subject in this script.
Is it possible that $keep_subject is supposed to be $keep?

-brandon
