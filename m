From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/5] i18n: keep the last \n even when text is poisoned
Date: Fri, 9 Mar 2012 09:33:23 +0700
Message-ID: <CACsJy8BZi6NG+pixq45dbTMMEXkvy8soma95Zx+UWemxnX2jqw@mail.gmail.com>
References: <1331198198-22409-1-git-send-email-pclouds@gmail.com>
 <1331198198-22409-2-git-send-email-pclouds@gmail.com> <20120308220131.GA10122@burratino>
 <CACsJy8AcUy9FZiiehGc7mEL4i+XP6u0pmH1rGoR-WZnhYT1UMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 09 03:34:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5pel-0004qb-92
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 03:34:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752150Ab2CICd6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 21:33:58 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:39427 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934Ab2CICdy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 21:33:54 -0500
Received: by wejx9 with SMTP id x9so808583wej.19
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 18:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=B2eJqqipVQpv9yeVCBgE/P4z6StaKRpzLDT5j3JaxTw=;
        b=fFPrcqZKQ+NQx/VIU9lnojcJkqjI88grqQXYZGOl08DQkRZ0ANTjwy25Slg5vFl+qr
         kW9GOcPCfSd/KcmO4jo+AcUrErj2gdzmnqY4iXGNkEl/ZFTZNUZbrC0zb493yw82ubV8
         PMTUP0LMZGmYEkzXTPvpebnUl/RrKunDlpbdULpai4o1jO+7kHIxMzsKYEI1u2KhwH03
         sJnaswDAjoc6VBB0cq/QsQLLtQhs3nvKqZRs7prfzhM1DzHerVU4nHgdfeRkGJkGAY//
         xitCWGLuo2JuahGkM1VW81g7wiH80BIBnldlSqCfJwOnMATD9iZYzidmYacQVLp17XJd
         sC9Q==
Received: by 10.180.80.104 with SMTP id q8mr418462wix.14.1331260433234; Thu,
 08 Mar 2012 18:33:53 -0800 (PST)
Received: by 10.223.13.5 with HTTP; Thu, 8 Mar 2012 18:33:23 -0800 (PST)
In-Reply-To: <CACsJy8AcUy9FZiiehGc7mEL4i+XP6u0pmH1rGoR-WZnhYT1UMQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192670>

On Fri, Mar 9, 2012 at 8:11 AM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> It's the former for me, but that's probably because I'm also a
> translator :) Anyway for tricky cases where msgfmt fails to detect,
> there's the role of l10n coordinators, who should review translation
> and catch these errors.

On second thought, most of call sites are [fs]printf or strbuf_addf,
and we have to update the call sites anyway to mark for translation.
If we introduce [fs]printf_ln, changes should be minimum. So now I'm
on your side too.
-- 
Duy
