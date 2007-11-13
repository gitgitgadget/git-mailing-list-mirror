From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH 0/11] Miscellaneous MinGW port fallout
Date: Tue, 13 Nov 2007 21:10:28 +0100
Message-ID: <200711132110.29136.johannes.sixt@telecom.at>
References: <1194984306-3181-1-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 21:11:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is268-0003XE-OO
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 21:11:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756071AbXKMUKd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 15:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755818AbXKMUKc
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 15:10:32 -0500
Received: from smtp3.srv.eunet.at ([193.154.160.89]:49507 "EHLO
	smtp3.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754758AbXKMUKc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 15:10:32 -0500
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp3.srv.eunet.at (Postfix) with ESMTP id DC64810ACB9;
	Tue, 13 Nov 2007 21:10:30 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id DF81958441;
	Tue, 13 Nov 2007 21:10:29 +0100 (CET)
User-Agent: KMail/1.9.3
In-Reply-To: <1194984306-3181-1-git-send-email-johannes.sixt@telecom.at>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64860>

On Tuesday 13 November 2007 21:04, Johannes Sixt wrote:
> [PATCH 09/11] Allow a relative builtin template directory.
> [PATCH 10/11] Introduce git_etc_gitconfig() that encapsulates access
> 	of ETC_GITCONFIG.
> [PATCH 11/11] Allow ETC_GITCONFIG to be a relative path.
>
> These need probably some discussion. They avoid that $(prefix) is
> hardcoded and so allows that an arbitrary installation directory.

... and so allow that the compiled binaries are installed in any directory 
that the user chooses.

-- Hannes
