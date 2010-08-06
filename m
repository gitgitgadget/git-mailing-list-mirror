From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] rebase -i: add exec command to launch a shell command
Date: Fri, 6 Aug 2010 23:07:54 +0200
Message-ID: <201008062307.54841.j6t@kdbg.org>
References: <vpqwrs9nxi5.fsf@bauges.imag.fr> <1280743433-27803-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com,
	=?iso-8859-15?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Aug 06 23:08:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhU9m-00011u-5e
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 23:08:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964968Ab0HFVIl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Aug 2010 17:08:41 -0400
Received: from bsmtp5.bon.at ([195.3.86.187]:12942 "EHLO lbmfmo03.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S964790Ab0HFVIk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Aug 2010 17:08:40 -0400
Received: from bsmtp.bon.at (mta-out-vip.lix.bon.at [172.18.12.14])
	by lbmfmo03.bon.at (Postfix) with ESMTP id A3E6ECE817
	for <git@vger.kernel.org>; Fri,  6 Aug 2010 23:08:38 +0200 (CEST)
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 5FE0EA7EBE;
	Fri,  6 Aug 2010 23:07:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id E60B119F5C6;
	Fri,  6 Aug 2010 23:07:54 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <1280743433-27803-1-git-send-email-Matthieu.Moy@imag.fr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152812>

On Montag, 2. August 2010, Matthieu Moy wrote:
> The typical usage pattern would be to run a test (or simply a compilation
> command) at given points in history.

What happens if the command modifies the worktree and/or the index?

-- Hannes
