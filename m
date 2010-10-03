From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2  0/6] Extensions of core.ignorecase=true support
Date: Sun, 3 Oct 2010 10:17:34 +0200
Message-ID: <201010031017.35112.j6t@kdbg.org>
References: <20101003043221.1960.73178.stgit@SlamDunk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Sun Oct 03 10:17:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2JlR-0004Rb-RK
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 10:17:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752635Ab0JCIRk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 04:17:40 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:24303 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752523Ab0JCIRi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 04:17:38 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id A0C5B10010;
	Sun,  3 Oct 2010 10:17:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 5CC1719F5EA;
	Sun,  3 Oct 2010 10:17:35 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <20101003043221.1960.73178.stgit@SlamDunk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157844>

Thank you for the resend.

On Sonntag, 3. Oktober 2010, Joshua Jensen wrote:
>  git status and add both use an update made to name-hash.c where
>  directories, specifically names with a trailing slash, can be looked up
>  in a case insensitive manner. After trying a myriad of solutions, this
>  seemed to be the cleanest. Does anyone see a problem with embedding the
>  directory names in the same hash as the file names? I couldn't find one,
>  especially since I append a slash to each directory name.
>
>  The git add path case folding functionality is a somewhat radical
>  departure from what Git does now. It is described in detail in patch 5.
>  Does anyone have any concerns?

Since I'm not an expert in the area that is touched by this series, I'd like 
to draw the list's attention to the questions in these two paragraphs.

Junio, IIRC, the series appeared in next for some time before the 1.7.3 
release. Does this imply that you reviewed the series and deemed the 
implementation sound?

-- Hannes
