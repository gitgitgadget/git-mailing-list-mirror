From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] daemon: send stderr of service programs to the syslog
Date: Tue, 16 Jun 2009 22:27:00 +0200
Message-ID: <200906162227.00377.j6t@kdbg.org>
References: <200906142238.51725.j6t@kdbg.org> <200906152339.43607.j6t@kdbg.org> <4A36C086.5010306@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Tue Jun 16 22:27:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGfFU-0008FW-Vr
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 22:27:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760973AbZFPU1E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2009 16:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758718AbZFPU1C
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jun 2009 16:27:02 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:31602 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757829AbZFPU1B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2009 16:27:01 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 65A71CDF8A;
	Tue, 16 Jun 2009 22:27:00 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 71E8F5BDA8;
	Tue, 16 Jun 2009 22:27:00 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <4A36C086.5010306@zytor.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121712>

On Montag, 15. Juni 2009, H. Peter Anvin wrote:
> Johannes Sixt wrote:
> > The progress indicator can be helped . But there is now another anoyance:
> > If the client terminates the connection early, this is now logged as:
> >
> > fatal: unable to run 'git-upload-pack'
>
> We probably do want to log that the client has disconnected.

Any client, or only clients that disconnect early? Is this useful besides 
debugging?

I think git-daemon's --verbose is intended to log all client connects and 
disconnects. This here is about a *new* message that would be logged 
without --verbose.

-- Hannes
