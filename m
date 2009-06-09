From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] send-email: Refuse to send cover-letter template subject
Date: Tue, 9 Jun 2009 10:19:05 +0200
Message-ID: <200906091019.11000.trast@student.ethz.ch>
References: <7fedc4b76fed03e4db6a2bb7453609c9cd02928a.1244496564.git.trast@student.ethz.ch> <7v4ouqwa42.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 10:19:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDwYg-0000nY-OH
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 10:19:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759279AbZFIITQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 04:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759258AbZFIITP
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 04:19:15 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:41694 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755628AbZFIITN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2009 04:19:13 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 9 Jun 2009 10:18:57 +0200
Received: from thomas.localnet ([129.132.153.233]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 9 Jun 2009 10:18:57 +0200
User-Agent: KMail/1.11.3 (Linux/2.6.27.21-0.1-default; KDE/4.2.3; x86_64; ; )
In-Reply-To: <7v4ouqwa42.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
X-OriginalArrivalTime: 09 Jun 2009 08:18:57.0821 (UTC) FILETIME=[EFAA74D0:01C9E8DA]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121153>

Junio C Hamano wrote:
> Thomas Rast <trast@student.ethz.ch> writes:
> 
> > Every so often, someone sends out an unedited cover-letter template.
> > Add a simple check to send-email that refuses to send if the subject
> > contains "*** SUBJECT HERE ***", with an option --force to override.
> 
> Good ;-).  More valuable to detect would be an empty "blurb" section
> (i.e. not "unedited *** BLURB HERE ***" string, but literally, there is
> nothing said in the message other than the shortstat).

Wouldn't that be AI complete?  As in, whatever regex (or similar) you
might cook up could probably be matched by *someone's* style of patch
descriptions, and then it suddenly becomes rather hard to tell them
apart.

I was really only trying to prevent the case where the user formatted
several times in a row because he noticed mistakes in the patches, and
forgot to re-edit the cover letter.  At least that's how I once sent
out one with a real description but the template subject.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
