From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [PATCH/RFC] git-blame.el: Use eldoc-mode to display current commit.
Date: Mon, 30 Jun 2008 12:47:48 +0200
Message-ID: <87myl3fbcb.fsf@lysator.liu.se>
References: <m2ej6fz1lv.fsf@nschum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, Nikolaj Schumacher <n_schumacher@web.de>
X-From: git-owner@vger.kernel.org Mon Jun 30 13:18:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDHOa-0006Oz-JX
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 13:18:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756640AbYF3LRM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jun 2008 07:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756492AbYF3LRK
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 07:17:10 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:59292 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756234AbYF3LRK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 07:17:10 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 9E413200A31E;
	Mon, 30 Jun 2008 12:47:49 +0200 (CEST)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 22965-01-76; Mon, 30 Jun 2008 12:47:49 +0200 (CEST)
Received: from krank (unknown [87.96.142.66])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 45A0D200A1D4;
	Mon, 30 Jun 2008 12:47:49 +0200 (CEST)
Received: by krank (Postfix, from userid 1000)
	id A4818E48013; Mon, 30 Jun 2008 12:47:48 +0200 (CEST)
In-Reply-To: <m2ej6fz1lv.fsf@nschum.de> (Nikolaj Schumacher's message of "Mon\, 30 Jun 2008 11\:57\:48 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86904>

Nikolaj Schumacher <n_schumacher@web.de> writes:

> I think this is a better way to display the current commit.  However,
> I'm not sure whether to rely on eldoc, or create my own timer.

Yes, maybe it is better to use a timer. But you should definitively
create a new timer, it isn't hard.

--=20
David K=C3=A5gedal
