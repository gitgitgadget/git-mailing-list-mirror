From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: [PATCH] Makefile: add a note about the NO_MMAP setting on IRIX
 and IRIX64
Date: Thu, 08 Oct 2009 19:15:54 -0500
Message-ID: <RLFF8Ml2w45o_YXX91uLQRAO7nrcr120NMK5ClTrG9qOvZhTxRRN_w@cipher.nrlssc.navy.mil>
References: <wTau-ugyVF7kG6Pxm7DRuWdrZABot_lbCcrG1e9aKIiNkU3X9L4ELEaLmN_rFVebheOs8fQEyx028yJUR9W-0w@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Oct 09 02:18:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mw3Bh-0008Lz-PQ
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 02:18:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756320AbZJIARK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2009 20:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755715AbZJIARI
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Oct 2009 20:17:08 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:53357 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754945AbZJIARH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2009 20:17:07 -0400
Received: by mail.nrlssc.navy.mil id n990FsmD025793; Thu, 8 Oct 2009 19:15:54 -0500
In-Reply-To: <wTau-ugyVF7kG6Pxm7DRuWdrZABot_lbCcrG1e9aKIiNkU3X9L4ELEaLmN_rFVebheOs8fQEyx028yJUR9W-0w@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 09 Oct 2009 00:15:54.0462 (UTC) FILETIME=[AAA257E0:01CA4875]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129725>

Brandon Casey wrote:
> From: Brandon Casey <drafnel@gmail.com>
> 
> When git is compiled with the MIPSpro 7.4.4m compiler, and NO_PTHREADS is
> set, and NO_MMAP is _not_ set, then git segfaults when trying to access the
> first entry in a reflog.  If NO_PTHREADS is not set (which implies that the
> pthread library is linked in), or NO_MMAP _is_ set, then the segfault is
> not encountered.  The conservative choise has been made to set NO_MMAP in
                                        ^^^

I misspelled 'choice'.  Doesn't seem worth a resend.  If you can fix it before
you apply, that would be great.  If you forget, no big deal.

-brandon
