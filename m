From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH v2] Revert "graph.c: mark private file-scope symbols as static"
Date: Mon, 4 Mar 2013 01:52:42 +0100
Message-ID: <CALKQrgds0-Fj-cZuvBHKiRHDx9vyY=dYpfOP0wE0WTHfAJ62oA@mail.gmail.com>
References: <50e7b3316fadbb550bea098ae92a0942a4429647.1362228122.git.john@keeping.me.uk>
	<87haktwr2a.fsf@pctrast.inf.ethz.ch>
	<20130303102946.GH7738@serenity.lan>
	<7vk3pob38d.fsf@alter.siamese.dyndns.org>
	<20130303214206.GL7738@serenity.lan>
	<7vppzg9k0n.fsf@alter.siamese.dyndns.org>
	<20130303232413.GN7738@serenity.lan>
	<7vzjyk83gn.fsf@alter.siamese.dyndns.org>
	<20130304000337.GP7738@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Lars Hjemli <hjemli@gmail.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Mar 04 01:53:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCJea-000466-E2
	for gcvg-git-2@plane.gmane.org; Mon, 04 Mar 2013 01:53:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754663Ab3CDAws (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Mar 2013 19:52:48 -0500
Received: from locusts.copyleft.no ([188.94.218.116]:54633 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754544Ab3CDAws (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Mar 2013 19:52:48 -0500
Received: from mail-oa0-f53.google.com ([209.85.219.53])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UCJe2-000Nlx-0w
	for git@vger.kernel.org; Mon, 04 Mar 2013 01:52:46 +0100
Received: by mail-oa0-f53.google.com with SMTP id m1so8201236oag.40
        for <git@vger.kernel.org>; Sun, 03 Mar 2013 16:52:42 -0800 (PST)
X-Received: by 10.182.164.8 with SMTP id ym8mr14301431obb.68.1362358362592;
 Sun, 03 Mar 2013 16:52:42 -0800 (PST)
Received: by 10.182.231.68 with HTTP; Sun, 3 Mar 2013 16:52:42 -0800 (PST)
In-Reply-To: <20130304000337.GP7738@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217388>

On Mon, Mar 4, 2013 at 1:03 AM, John Keeping <john@keeping.me.uk> wrote:
> This reverts commit ba35480439d05b8f6cca50527072194fe3278bbb.
>
> CGit uses these symbols to output the correct HTML around graph
> elements.  Making these symbols private means that CGit cannot be
> updated to use Git 1.8.0 or newer, so let's not do that.
>
> On top of the revert, also add comments so that we avoid reintroducing
> this problem in the future and suggest to those modifying this API
> that they might want to discuss it with the CGit developers.
>
> Signed-off-by: John Keeping <john@keeping.me.uk>

Still-Acked-by: Johan Herland <johan@herland.net>


...Johan


-- 
Johan Herland, <johan@herland.net>
www.herland.net
