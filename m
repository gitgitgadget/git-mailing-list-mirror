From: =?UTF-8?Q?Am=C3=A9rico_Wang?= <xiyou.wangcong@gmail.com>
Subject: Re: [PATCH 1/1] gitignore: do not ignore include/linux/
Date: Mon, 8 Mar 2010 10:08:46 +0800
Message-ID: <2375c9f91003071808n64bf5ddav4a5eeb6e73158d4@mail.gmail.com>
References: <4B90CBE5.9090102@viscovery.net>
	 <1267780845-10547-1-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Andrew Morton <akpm@linux-foundation.org>, git@vger.kernel.org,
	linux-kernel@vger.kernel.org, jirislaby@gmail.com,
	Johannes Sixt <j.sixt@viscovery.net>
To: Jiri Slaby <jslaby@suse.cz>
X-From: git-owner@vger.kernel.org Mon Mar 08 03:08:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoSOt-0005Me-AG
	for gcvg-git-2@lo.gmane.org; Mon, 08 Mar 2010 03:08:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753211Ab0CHCIs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Mar 2010 21:08:48 -0500
Received: from mail-qy0-f179.google.com ([209.85.221.179]:56075 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752364Ab0CHCIq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Mar 2010 21:08:46 -0500
Received: by qyk9 with SMTP id 9so4175195qyk.5
        for <multiple recipients>; Sun, 07 Mar 2010 18:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=SdeVOAKfAcvTB9neE5eGKL5ym1uE88HDuKE3fjOypzA=;
        b=NEvlxwfFiNh/LuMuQHuX4AsNbKRpS+EGynO6fgdBL4SwjZ6hwC3M3F+sdIxVT+PLfW
         rqdAEijUz7UAW+G/G1+k+x6oqYNa8fSmZ+SCjdiAAITvKvi7PdrVbs9ZT3aIGcPdjxEv
         efaLqWoiRv7w7Qs13n40GjOGHe2vLGjo6pMyw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=lTG+4m0ptXwAtDdUgBnwlC4d2Hd2paT7Tua+pSRyf0XsJVdfiopOhlXdx4dKo+5ixa
         sjfd63yWgmOFJD3e7euJoSzRbHhVwvAc/RUqiTyUM8YBxjNzCA6BZtp/ww8j+aCc4Do2
         Y4PsMF6UloDaQmaifd4yN1sOaD05ZBKpIlFn0=
Received: by 10.229.211.130 with SMTP id go2mr344032qcb.104.1268014126130; 
	Sun, 07 Mar 2010 18:08:46 -0800 (PST)
In-Reply-To: <1267780845-10547-1-git-send-email-jslaby@suse.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141748>

On Fri, Mar 5, 2010 at 5:20 PM, Jiri Slaby <jslaby@suse.cz> wrote:
> linux entry in .gitignore means that everything in include/linux/
> gets ignored with git 1.7.
>
> Prepend a slash to entries which are toplevel to avoid that

New change in git 1.7?
