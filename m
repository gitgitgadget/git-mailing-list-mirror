From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH v7 2/5] blame: introduce $ as "end of file" in -L syntax
Date: Thu, 7 Jun 2012 19:44:36 +0200
Message-ID: <87wr3j6mpn.fsf@thomas.inf.ethz.ch>
References: <cover.1339063659.git.trast@student.ethz.ch>
	<d9e1235303c949849b9acfa37fc9e9a780d93873.1339063659.git.trast@student.ethz.ch>
	<7vwr3jhw8z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>, Bo Yang <struggleyb.nku@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 07 19:44:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScglK-0005pu-5H
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 19:44:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932569Ab2FGRom (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jun 2012 13:44:42 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:6847 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932308Ab2FGRol (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2012 13:44:41 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 7 Jun
 2012 19:44:35 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (46.126.8.85) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 7 Jun
 2012 19:44:37 +0200
In-Reply-To: <7vwr3jhw8z.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 7 Jun 2012 10:23:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199426>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <trast@student.ethz.ch> writes:
>
>> To save the user a lookup of the last line number, introduce $ as a
>> shorthand for the last line.  This is mostly useful to spell "until
>> the end of the file" as '-L<begin>,$'.
>
> Hmph.  This is mostly useful not to error out when user (perhaps
> mistakenly) expects that the end of file is spelled as "$"; both
> "git blame -L<begin>" and "git blame L<begin>," have always meant
> "til the end", IIRC.

Heh.  That's actually a very good point; I think neither Bo nor me have
thought about allowing git log -L <begin>:<file>.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
