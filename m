From: Stepan Kasal <kasal@ucw.cz>
Subject: Re: [PATCH] send-email: do not insert third header
Date: Tue, 10 Jun 2014 09:05:06 +0200
Organization: <)><
Message-ID: <20140610070506.GA23093@camelia.ucw.cz>
References: <20140607080940.GA8858@camelia.ucw.cz> <xmqqa99ld5sp.fsf@gitster.dls.corp.google.com> <xmqqwqcpb9yx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 09:05:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuG7S-00021o-1x
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 09:05:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755034AbaFJHFK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 03:05:10 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:51985 "EHLO
	jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754620AbaFJHFJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 03:05:09 -0400
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id 31A901C0073;
	Tue, 10 Jun 2014 09:05:08 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id s5A7577h023165;
	Tue, 10 Jun 2014 09:05:07 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id s5A757NL023164;
	Tue, 10 Jun 2014 09:05:07 +0200
Content-Disposition: inline
In-Reply-To: <xmqqwqcpb9yx.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251168>

On Mon, Jun 09, 2014 at 10:38:14PM -0700, Junio C Hamano wrote:
> two new options [..]
> would support the recent kernel submission convention better.

indeed, but they are not there and I do not volunteer to write them.

Instead, I edit the generated patches to add the necessary headers.
But if send-mail is used to mass-send these edited mails, it adds yet
another header.  As a quick solution, I fixed send-mail, so that it
respects the header added by hand.

Even if send-mail is in the future enhanced according to your
proposal, it is still possible that hand-crafted headers will be
needed for a special purpose, so my patch still may come handy.

Stepan
