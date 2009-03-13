From: "Kelly F. Hickel" <kfh@mqsoftware.com>
Subject: RE: newb: Given a commit id, find which branches have it as an ancestor
Date: Fri, 13 Mar 2009 08:31:51 -0500
Message-ID: <63BEA5E623E09F4D92233FB12A9F794302E0F9D9@emailmn.mqsoftware.com>
References: <63BEA5E623E09F4D92233FB12A9F794302E0F9B2@emailmn.mqsoftware.com> <63BEA5E623E09F4D92233FB12A9F794302E0F9BA@emailmn.mqsoftware.com> <49BA07E5.2080701@viscovery.net> <7v3adhj2ku.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Mar 13 14:33:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Li7Vs-0004Jg-DA
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 14:33:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754471AbZCMNb4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2009 09:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754466AbZCMNbz
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 09:31:55 -0400
Received: from emailmn.mqsoftware.com ([66.192.70.108]:26236 "EHLO
	emailmn.mqsoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754366AbZCMNby convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Mar 2009 09:31:54 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <7v3adhj2ku.fsf@gitster.siamese.dyndns.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: newb: Given a commit id, find which branches have it as an ancestor
Thread-Index: AcmjrpB8eByqUN0ITA+knKlJnz1hVQAMWTmg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113185>

> -----Original Message-----
> From: Junio C Hamano [mailto:gitster@pobox.com]
> Sent: Friday, March 13, 2009 2:37 AM
> To: Johannes Sixt
> Cc: Kelly F. Hickel; git@vger.kernel.org
> Subject: Re: newb: Given a commit id, find which branches have it as
an
> ancestor
> 
> Johannes Sixt <j.sixt@viscovery.net> writes:
> 
> > Your best bet is perhaps that you create a branch at the commit
> >
> >   $ git branch tmp-branch your_sha1
> >
> > so that the commits are not lost, then you cherry-pick them to
> master.
> 
> It could be that there are more commits that are built on top of the
> one
> you are aware of.  Finding unreachable commits from "git fsck --full"
> might help you find them.

Thanks, turned out to be my misunderstanding of how to do incremental
imports
(see my response to Johannes).

Thanks for the help,
-Kelly
