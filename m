From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH v2] Revert "graph.c: mark private file-scope symbols as static"
Date: Sun, 3 Mar 2013 23:25:19 -0500
Message-ID: <CAHmME9p_bDLxa8dG=b=5+FL4CXgdeKJVv4hFoFJwG-vxW-TiYQ@mail.gmail.com>
References: <50e7b3316fadbb550bea098ae92a0942a4429647.1362228122.git.john@keeping.me.uk>
	<87haktwr2a.fsf@pctrast.inf.ethz.ch>
	<20130303102946.GH7738@serenity.lan>
	<7vk3pob38d.fsf@alter.siamese.dyndns.org>
	<20130303214206.GL7738@serenity.lan>
	<7vppzg9k0n.fsf@alter.siamese.dyndns.org>
	<20130303232413.GN7738@serenity.lan>
	<7vzjyk83gn.fsf@alter.siamese.dyndns.org>
	<20130304000337.GP7738@serenity.lan>
	<CAHmME9oAiZDcAeMCE=haUmC9yeC0crZCKB-WrxQ3CVd1YrBdHQ@mail.gmail.com>
	<7vzjyjygnd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: John Keeping <john@keeping.me.uk>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>,
	Lars Hjemli <hjemli@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 04 05:25:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCMyD-00015v-9g
	for gcvg-git-2@plane.gmane.org; Mon, 04 Mar 2013 05:25:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754983Ab3CDEZW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Mar 2013 23:25:22 -0500
Received: from caiajhbdcagg.dreamhost.com ([208.97.132.66]:55454 "EHLO
	homiemail-a38.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754741Ab3CDEZV (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Mar 2013 23:25:21 -0500
X-Greylist: delayed 15155 seconds by postgrey-1.27 at vger.kernel.org; Sun, 03 Mar 2013 23:25:21 EST
Received: from homiemail-a38.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a38.g.dreamhost.com (Postfix) with ESMTP id 6EF1010AFAD
	for <git@vger.kernel.org>; Sun,  3 Mar 2013 20:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
	:in-reply-to:references:date:message-id:subject:from:to:cc:
	content-type; s=zx2c4.com; bh=nfZFNEpIJHx+xHhtIWBTXW6dx3U=; b=oz
	GW3SG626KRl3ng1kvx734z/ZZYJ0/CDSNVA9YQNt45vxuFkuNRmAg03ZSNHSqMUn
	8wpjTs4U/eMvtw8IkJ5rJRWRzcMgV7qw8aayNMivf01LXGtKjgK567Mz2xvw5OPh
	3cviBUfzeCkIzuHYArSMdRlyxYCWUA1fKxWAxjxs0=
Received: from mail-oa0-f42.google.com (mail-oa0-f42.google.com [209.85.219.42])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: jason@zx2c4.com)
	by homiemail-a38.g.dreamhost.com (Postfix) with ESMTPSA id 41A9910AFAB
	for <git@vger.kernel.org>; Sun,  3 Mar 2013 20:25:20 -0800 (PST)
Received: by mail-oa0-f42.google.com with SMTP id i18so8586376oag.15
        for <git@vger.kernel.org>; Sun, 03 Mar 2013 20:25:19 -0800 (PST)
X-Received: by 10.60.31.225 with SMTP id d1mr14238705oei.120.1362371119620;
 Sun, 03 Mar 2013 20:25:19 -0800 (PST)
Received: by 10.76.143.37 with HTTP; Sun, 3 Mar 2013 20:25:19 -0800 (PST)
In-Reply-To: <7vzjyjygnd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217391>

On Sun, Mar 3, 2013 at 10:42 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I suspect that many people outside CGit circle may not know who this
> Jason
> That active contributor is Jason. The repository has also been moved
> to Jason's http://git.zx2c4.com/cgit/
> So, thanks, Jason and John for your efforts.

Hey folks,

Sorry for not providing the explanation myself, but Junio -- thanks
for introducing me!

Jason
