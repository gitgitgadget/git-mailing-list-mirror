From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 0/5] nd/branch-show-rebase-bisect-state updates
Date: Wed, 20 Mar 2013 19:40:49 +0700
Message-ID: <CACsJy8C93OOLWW2tdh17XA1k3Zs_kUjyZ32v4Ywk2BK83BL3wQ@mail.gmail.com>
References: <1362572482-20570-1-git-send-email-pclouds@gmail.com>
 <1363174973-17597-1-git-send-email-pclouds@gmail.com> <7vhak7i6ch.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jonathan Niedier <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 20 13:41:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIIKy-0000AO-HD
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 13:41:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758136Ab3CTMlV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 08:41:21 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:61027 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757960Ab3CTMlU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 08:41:20 -0400
Received: by mail-oa0-f48.google.com with SMTP id j1so1673309oag.35
        for <git@vger.kernel.org>; Wed, 20 Mar 2013 05:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=cwd1g/IAvkoZPurJUOns9YCh6LaITbDjwqHnECLngd0=;
        b=v5Wrif8CJEHykl2uL8RfR4NHxUwrF02eEE87hyZWyzo3HKVmnu+P02hN382fUcCcqh
         2Z952YaZ/oEBXdcjbQQ7eJ2yuMH/IjTiG1wv6l/iAtBu6RCtR/PWOfGVPC1U2BAnDWiE
         WfXRKezOHW4bj/9HLpshmNfVRSlSwnBTYUlOYw1tC+Pfu2krEZJHPPmBK3kp0UqMk5CP
         3liFMZwY85ZmsUgXC1KMgYykAL9vU1RDlc/W2xg+g7FnPebJzJCg/KSj8nvm+B/E+ZJh
         J6h5Iq4ysJmwY9k1CqJzBa1/eEwsfv4EjhGZRt4FDTy8eJ2+NqDiPrFzkv5zCVZlsnjd
         ZP/w==
X-Received: by 10.182.39.69 with SMTP id n5mr4011839obk.72.1363783280047; Wed,
 20 Mar 2013 05:41:20 -0700 (PDT)
Received: by 10.76.27.200 with HTTP; Wed, 20 Mar 2013 05:40:49 -0700 (PDT)
In-Reply-To: <7vhak7i6ch.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218597>

On Wed, Mar 20, 2013 at 1:37 AM, Junio C Hamano <gitster@pobox.com> wrote:
> I was running "git bisect start pu jch" (jch is a branch I do not
> push out everywhere that is somewhere in the middle of
> "master..pu"), and then after bisection finished, saw this:
>
>     $ git branch --with 66887099e096f0258a5ef3b1e7458748597bdffe
>     * (no branch, bisecting jch)
>       nd/magic-pathspecs
>       pu
>
> which is obviously bogus.  I only said "I know the tip of pu is bad
> and the tip of jch is good".  If anything, I was bisecting the
> breakage in 'pu', not in 'jch'.
>
> I think the message should better say "before you started to bisect
> you were on 'jch'" or something instead.

How about

* (no branch, bisect started on jch)

then? I don't want to make it too long because it'll waste space in
column layout.
-- 
Duy
