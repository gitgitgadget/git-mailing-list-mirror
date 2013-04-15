From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 3/3] pull: introduce --[no-]autostash and pull.autostash
Date: Mon, 15 Apr 2013 17:53:53 +0100
Message-ID: <20130415165352.GH2278@serenity.lan>
References: <1365887729-9630-1-git-send-email-artagnon@gmail.com>
 <1365887729-9630-4-git-send-email-artagnon@gmail.com>
 <vpq38us2oov.fsf@grenoble-inp.fr>
 <CALkWK0mdC_tK2CGqAa67fr189PQCjSjzAOPujipOHFfoiYW0qA@mail.gmail.com>
 <vpqppxvoqsc.fsf@grenoble-inp.fr>
 <CALkWK0nqrw7DFQSnMvULYjJtBHRnadKWqCLQOAjzJH0o7USo+A@mail.gmail.com>
 <vpqwqs3lqlf.fsf@grenoble-inp.fr>
 <CALkWK0nrVZo3MSgqpPmX2+T3JJ8uP=hzH3PMv+qd4ZaqNVwEsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 18:54:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URmfP-0002Gy-Rq
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 18:54:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754678Ab3DOQyD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 12:54:03 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:41144 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754583Ab3DOQyC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 12:54:02 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 5804A6065A1;
	Mon, 15 Apr 2013 17:54:01 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -11
X-Spam-Level: 
X-Spam-Status: No, score=-11 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ul806oRcm979; Mon, 15 Apr 2013 17:54:01 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 4180F6065A2;
	Mon, 15 Apr 2013 17:53:54 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CALkWK0nrVZo3MSgqpPmX2+T3JJ8uP=hzH3PMv+qd4ZaqNVwEsw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221255>

On Mon, Apr 15, 2013 at 10:15:54PM +0530, Ramkumar Ramachandra wrote:
> Junio's criticism of pull.autostash hurting pull-merge people is
> cogent; my current plan is to ditch pull.autostash altogether, and
> implement rebase.autostash for the reduced case of a non-interactive
> rebase.

Why restrict it to non-interactive?  I'd find it useful when doing
interactive rebases as well - consider the case when you simply want to
re-order some commits.
