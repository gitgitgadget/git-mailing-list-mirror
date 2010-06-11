From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH next] test-lib: set $DIFF to diff if it is unset
Date: Fri, 11 Jun 2010 18:34:35 +0200
Message-ID: <201006111834.36226.trast@student.ethz.ch>
References: <06ffbe0ca6aac061336f6f595e89f75c09ab88ac.1276162629.git.trast@student.ethz.ch> <I5rdmhJblm27JnzIPi7xP5KmntXzA3-wGL-IGXejOPAurGsMke2J3g@cipher.nrlssc.navy.mil> <7vhbl9k0jv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>,
	<git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 11 18:34:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ON7Br-00028k-Sm
	for gcvg-git-2@lo.gmane.org; Fri, 11 Jun 2010 18:34:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755799Ab0FKQei (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jun 2010 12:34:38 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:12836 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755226Ab0FKQeh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jun 2010 12:34:37 -0400
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Fri, 11 Jun
 2010 18:34:36 +0200
Received: from thomas.localnet (192.33.106.236) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.254.0; Fri, 11 Jun
 2010 18:34:36 +0200
User-Agent: KMail/1.13.3 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.3; x86_64; ; )
In-Reply-To: <7vhbl9k0jv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148961>

Junio C Hamano wrote:
> Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil> writes:
> 
> > I think what should be done instead, is to move this section
> > down below the line where GIT-BUILD-OPTIONS is sourced.  That
> > way, the value of $DIFF can be gotten from that file.
> >
> > I guess GIT_TEST_CMP and GIT_TEST_CMP_USE_COPIED_CONTEXT
> > should be written into GIT-BUILD-OPTIONS too.
> 
> I like that.  Something like this?

Fine by me, and tested.

Acked-by: Thomas Rast <trast@student.ethz.ch>

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
