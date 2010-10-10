From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 11/14] daemon: report connection from root-process
Date: Sun, 10 Oct 2010 20:58:16 +0200
Message-ID: <201010102058.16773.j6t@kdbg.org>
References: <1286716854-5744-1-git-send-email-kusmabite@gmail.com> <1286716854-5744-12-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: "Erik Faye-Lund" <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 10 20:58:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P516F-0006v4-TR
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 20:58:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752230Ab0JJS6T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Oct 2010 14:58:19 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:39569 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751861Ab0JJS6S (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 14:58:18 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 4828BCDF88;
	Sun, 10 Oct 2010 20:58:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 00EEE19F7A9;
	Sun, 10 Oct 2010 20:58:16 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <1286716854-5744-12-git-send-email-kusmabite@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158685>

On Sonntag, 10. Oktober 2010, Erik Faye-Lund wrote:
> Report incoming connections from the process that
> accept() the connection instead of the handling
> process.
>
> This enables "Connection from"-reporting on
> Windows, where getpeername(0, ...) consistently
> fails.

Is this from the process that you invoke with --serve? then this failure could 
be due to Winsockets not being initilized. Did you check that?

-- Hannes
