From: John Goerzen <jgoerzen@complete.org>
Subject: Re: [PATCH] Fix dcommit, rebase when rewriteRoot is in use
Date: Sat, 8 Mar 2008 15:28:21 -0600
Message-ID: <200803081528.21295.jgoerzen@complete.org>
References: <1205006470-18882-1-git-send-email-jgoerzen@complete.org> <7v3ar1sz8x.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, normalperson@yhbt.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 08 22:29:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JY6bP-0005ma-7k
	for gcvg-git-2@gmane.org; Sat, 08 Mar 2008 22:29:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751672AbYCHV2d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 16:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751520AbYCHV2d
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 16:28:33 -0500
Received: from b01s02mr.corenetworks.net ([64.85.160.192]:36952 "EHLO
	glockenspiel.complete.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498AbYCHV2c (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2008 16:28:32 -0500
Received: from 63-245-179-205.kitusa.com ([63.245.179.205] helo=erwin.lan.complete.org)
	by glockenspiel.complete.org with esmtps
	(with TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(TLS peer CN erwin.complete.org, certificate verified)
	(Exim 4.63)
	id 1JY6af-0007IB-JW; Sat, 08 Mar 2008 15:28:29 -0600
Received: from katherina.lan.complete.org ([10.200.0.4])
	by erwin.lan.complete.org with esmtps
	(with TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(No TLS peer certificate)
	(Exim 4.67)
	id 1JY6ab-0008Lk-Hn; Sat, 08 Mar 2008 15:28:21 -0600
Received: from jgoerzen by katherina.lan.complete.org with local (Exim 4.69)
	(envelope-from <jgoerzen@complete.org>)
	id 1JY6ab-0005cX-AE; Sat, 08 Mar 2008 15:28:21 -0600
User-Agent: KMail/1.9.7
In-Reply-To: <7v3ar1sz8x.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
X-Spam-Status: No (score 0.1): AWL=0.077
X-Virus-Scanned: by Exiscan on glockenspiel.complete.org at Sat, 08 Mar 2008 15:28:29 -0600
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76588>

On Saturday 08 March 2008 3:05:18 pm Junio C Hamano wrote:
> John Goerzen <jgoerzen@complete.org> writes:
> > Problem described here:
> >
> > http://thread.gmane.org/gmane.comp.version-control.git/76561
> >
> > Signed-off-by: John Goerzen <jgoerzen@complete.org>
>
> While I am sure Eric and git-svn users would appreciate a fix, please do
> not write a commit log message like this.
>
> Having a pointer to additional material is a very good practice, and will
> be appreciated by the readers, but giving a pointer and nothing else means
> that you are forcing your readers to hunt for out-of-line information.

Thanks for the note.  Some projects really hate long commit messages, and 
some love them, and I wasn't sure what type of project this is.

Would you like me to rewrite and re-submit this, or are you editing and 
committing?

-- John
