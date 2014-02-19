From: Philippe Vaucher <philippe.vaucher@gmail.com>
Subject: Re: git gc --aggressive led to about 40 times slower "git log --raw"
Date: Wed, 19 Feb 2014 09:38:31 +0100
Message-ID: <CAGK7Mr4wpwUK6UF6vTmgszX4sajPDvQazY2QagFfH9BEJx_9Ow@mail.gmail.com>
References: <CAEjYwfU==yYtQBDzZzEPdvbqz1N=gZtbMr5ccRaC_U7NfViQLA@mail.gmail.com>
 <87r470ssuc.fsf@fencepost.gnu.org> <CACsJy8D9tws_gu6yWVdz3t+Vfg5-9iorptn4BLnTL3b+YWcHzQ@mail.gmail.com>
 <87ioscsoow.fsf@fencepost.gnu.org> <20140218155842.GA7855@google.com>
 <xmqqzjlocf28.fsf@gitster.dls.corp.google.com> <CACsJy8AEXP45K+r3gGVTWbn4uuPLeHOkf-an20rj77QSfG1-ew@mail.gmail.com>
 <xmqq4n3warni.fsf@gitster.dls.corp.google.com> <CACsJy8C+wGd9WxnsML6-_G_S5GtN2pCPf09kcFtBVu-SDfP8YA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	David Kastrup <dak@gnu.org>,
	Christian Jaeger <chrjae@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 19 09:39:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WG2gT-0006JL-K5
	for gcvg-git-2@plane.gmane.org; Wed, 19 Feb 2014 09:39:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752993AbaBSIjG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Feb 2014 03:39:06 -0500
Received: from mail-oa0-f52.google.com ([209.85.219.52]:65369 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752697AbaBSIjC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Feb 2014 03:39:02 -0500
Received: by mail-oa0-f52.google.com with SMTP id o6so74431oag.25
        for <git@vger.kernel.org>; Wed, 19 Feb 2014 00:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=uDOd3aOO7Iwuvqrkb2cG7FxGWNWfgYqS1XvVAXfSkdw=;
        b=Os87H6MwhzXiVj1NtKguquWh6anCUHhyrF4jdfbKaqeVkwNPpkVNIA1WhQ9vl+zTWP
         B4yMe741bHqGGne7lDZxDhI/opEyF+Ve+QbvN0PwNjiZWz4ZhpvJnt4JuVhGce3bK23M
         reEyivniylmM80BDdQi8A05mIQzFQh4HyGFCQUAe0rTYHjSe5eqdZDIpFutN2S5vZMDg
         w6lstkxJRveRiQXUIZCvy3v09IRWgGvV6R1Y6uNJcGmnY0gGTqVX19UXyXTchijP2s/j
         KuRgupqfkapcr3mm8EN2Y/MqztVxRjbGmaKihuVW/GOmyXWJYeeyGnQYTkHSvpmgkvfs
         QhLA==
X-Received: by 10.60.54.202 with SMTP id l10mr29538964oep.29.1392799142142;
 Wed, 19 Feb 2014 00:39:02 -0800 (PST)
Received: by 10.76.85.233 with HTTP; Wed, 19 Feb 2014 00:38:31 -0800 (PST)
In-Reply-To: <CACsJy8C+wGd9WxnsML6-_G_S5GtN2pCPf09kcFtBVu-SDfP8YA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242383>

> fwiw this is the thread that added --depth=250
>
> http://thread.gmane.org/gmane.comp.gcc.devel/94565/focus=94626

This post is quite interesting:
http://article.gmane.org/gmane.comp.gcc.devel/94637

Philippe
