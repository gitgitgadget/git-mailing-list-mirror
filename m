From: Kevin Cernekee <cernekee@gmail.com>
Subject: Re: [PATCH v2 4/3] gitweb: Always call format_date with timezone parameter
Date: Sun, 20 Mar 2011 13:47:52 -0700
Message-ID: <AANLkTi=R+03BQZxh+8pcvxKRjO00_8Eo8FJ31buWZ6rb@mail.gmail.com>
References: <4f21902cf5f72b30a96465cf911d13aa@localhost>
	<b599dae39131b90d0970a1ef63e6599b@localhost>
	<201103201137.18619.jnareb@gmail.com>
	<201103201207.56639.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 20 21:48:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1PXq-0001C5-Ol
	for gcvg-git-2@lo.gmane.org; Sun, 20 Mar 2011 21:48:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752472Ab1CTUsK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2011 16:48:10 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:47217 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752384Ab1CTUsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2011 16:48:09 -0400
Received: by fxm17 with SMTP id 17so4992227fxm.19
        for <git@vger.kernel.org>; Sun, 20 Mar 2011 13:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=d3UAJa1VwTzjwikJS6jiahTj16wKmYPQecrIgIxpg2Q=;
        b=rmV5dIXnzea9J+djH8QqF+kiTxPz5ijyCkFVJoh+O6RRWiXtG5F4BE3b7cxhP+SwEY
         UAC1xZUx9pl+TNbWEfRW2ZsUlU0AHMLxnfl3UOmj0rjcvbeb+8555xsOKyqkWbTz0edk
         VUqdaQgaVP3qyt3D1Qr0WN9F10tx29hjTadVg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=KuG7ewv7TFbr964GM6V8ibIIr4xCP8KKVWpL9WqMx5Ipgg5BNCmAPAyasTqAfVEC0a
         TxkYqSqk8sIXrTNH/jWUZ3N6SfigGMKHIXIRVKk5ofThS6EJZtL0STk/sxfOb7iGBKi5
         m529S81SotnYYE8EUC9zBg9hQU/ivFhQhXy3w=
Received: by 10.223.102.129 with SMTP id g1mr4073394fao.3.1300654072689; Sun,
 20 Mar 2011 13:47:52 -0700 (PDT)
Received: by 10.223.61.83 with HTTP; Sun, 20 Mar 2011 13:47:52 -0700 (PDT)
In-Reply-To: <201103201207.56639.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169523>

On Sun, Mar 20, 2011 at 4:07 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> But it takes bugfix hostage to applying new feature series.

I can reorder and resubmit if needed...

But, since the bug isn't actually showing any symptoms in the existing
code, and since the fix only depends on patch 1/3 ("rename parse_date"
cleanup) rather than 2/3 + 3/3 (localtime + atnight features), I'm
hoping this won't be a major point of contention.
