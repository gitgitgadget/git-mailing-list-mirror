From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 13/14] daemon: use select() instead of poll()
Date: Sat, 16 Jan 2010 13:36:20 +0100
Message-ID: <201001161336.20703.j6t@kdbg.org>
References: <1263591033-4992-1-git-send-email-kusmabite@gmail.com> <201001161138.36535.j6t@kdbg.org> <40aa078e1001160305y17b46a6dtc4959e5255c7acae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Sat Jan 16 13:37:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NW7uA-00066V-RI
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 13:37:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751962Ab0APMhX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jan 2010 07:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751909Ab0APMhW
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jan 2010 07:37:22 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:32282 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751587Ab0APMhW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jan 2010 07:37:22 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 1AC91CDF83;
	Sat, 16 Jan 2010 13:37:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id C8A4B19F6CB;
	Sat, 16 Jan 2010 13:36:20 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <40aa078e1001160305y17b46a6dtc4959e5255c7acae@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137228>

On Samstag, 16. Januar 2010, Erik Faye-Lund wrote:
> ...but __WSAFDIsSet() seems to be every bit as official on Windows as
> FD_ISSET() (documented in msdn, without any notes not to use it), so I
> still don't really see the point.

I didn't know nor check whether it is documented, but assumed from the '__' 
that it must be internal. Being documented makes a big difference. I'm fine 
with either solution.

-- Hannes
