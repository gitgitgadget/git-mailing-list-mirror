From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [msysGit] [PATCH v4 6/8] mingw: wrap SSL_set_(w|r)fd to call _get_osfhandle
Date: Mon, 19 Oct 2009 20:20:39 +0200
Message-ID: <200910192020.40179.j6t@kdbg.org>
References: <1255966929-1280-1-git-send-email-kusmabite@gmail.com> <1255966929-1280-6-git-send-email-kusmabite@gmail.com> <1255966929-1280-7-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com, git@vger.kernel.org,
	"Erik Faye-Lund" <kusmabite@gmail.com>
To: "Erik Faye-Lund" <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Oct 19 20:20:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzwqZ-0007dB-5P
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 20:20:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757213AbZJSSUb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 14:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757184AbZJSSUb
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 14:20:31 -0400
Received: from [93.83.142.38] ([93.83.142.38]:63779 "EHLO dx.sixt.local"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755570AbZJSSUa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2009 14:20:30 -0400
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 702C619F65C;
	Mon, 19 Oct 2009 20:20:40 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <1255966929-1280-7-git-send-email-kusmabite@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130722>

On Montag, 19. Oktober 2009, Erik Faye-Lund wrote:
> SSL_set_fd (and friends) expects a OS file handle on Windows, not
> a file descriptor as on UNIX(-ish).
>
> This patch makes the Windows version of SSL_set_fd behave like the
> UNIX versions, by calling _get_osfhandle on it's input.
>
> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>

Acked-by: Johannes Sixt <j6t@kdbg.org>

-- Hannes
