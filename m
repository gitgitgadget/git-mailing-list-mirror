From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCHv3] Updated patch series for providing mechanism to list  available repositories
Date: Tue, 27 Jul 2010 09:16:58 +0200
Organization: Viscovery Software GmbH
Message-ID: <201007270916.59210.j.sixt@viscovery.net>
References: <1279725355-23016-1-git-send-email-gdb@mit.edu> <20100726232855.GA3157@burratino> <AANLkTikqA3kNif+7Bi+=xkJ2FgCFAsfCj0N5dft5pnFR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="windows-1252"
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?windows-1252?q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	gitster@pobox.com, git@vger.kernel.org
To: Greg Brockman <gdb@mit.edu>
X-From: git-owner@vger.kernel.org Tue Jul 27 09:50:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Odevr-0001Rj-BQ
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 09:50:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753518Ab0G0Hua (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jul 2010 03:50:30 -0400
Received: from bsmtp5.bon.at ([195.3.86.187]:38634 "EHLO lbmfmo03.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752821Ab0G0Hu3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 03:50:29 -0400
X-Greylist: delayed 1959 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Jul 2010 03:50:28 EDT
Received: from bsmtp.bon.at (mta-out-vip.lix.bon.at [172.18.12.14])
	by lbmfmo03.bon.at (Postfix) with ESMTP id B6ED2CDFBC
	for <git@vger.kernel.org>; Tue, 27 Jul 2010 09:17:48 +0200 (CEST)
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id CF036CDFA4;
	Tue, 27 Jul 2010 09:16:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 7A84619F5B3;
	Tue, 27 Jul 2010 09:16:59 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <AANLkTikqA3kNif+7Bi+=xkJ2FgCFAsfCj0N5dft5pnFR@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151917>

On Dienstag, 27. Juli 2010, Greg Brockman wrote:
> > Patch 1 still uses execv(), which is not available on Windows.
>
> It seems to me that the existing git-shell calls execv_git_cmd, which
> uses execvp internally.  I know ~nothing about exec on Windows, but
> presumably it doesn't have just one of execv or execvp.

Windows does have execv. The patch is OK in this regard.

-- Hannes
