From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH v2 1/2] i18n: proposed command missing leading dash
Date: Wed, 5 Mar 2014 22:14:44 +0800
Message-ID: <CANYiYbEZEYwrOh0VZAGiX_sMB3z+6ntv3_UgbLkvsU6FvH07Dg@mail.gmail.com>
References: <1393620766-17582-1-git-send-email-sandy.carter@savoirfairelinux.com>
	<1393858554-4392-1-git-send-email-sandy.carter@savoirfairelinux.com>
	<xmqqa9d5lsdb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Jean-Noel Avila <jn.avila@free.fr>,
	Sandy Carter <sandy.carter@savoirfairelinux.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 15:14:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLCaw-0000VU-7w
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 15:14:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753905AbaCEOOq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2014 09:14:46 -0500
Received: from mail-we0-f172.google.com ([74.125.82.172]:43727 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751981AbaCEOOp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2014 09:14:45 -0500
Received: by mail-we0-f172.google.com with SMTP id t61so1284424wes.17
        for <git@vger.kernel.org>; Wed, 05 Mar 2014 06:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=3voK4CTTDjKA3in+Iq/mjW0w9osm2kJCMtu8G//hW3s=;
        b=J/dGaSHa64k6UCqs9ucAk4LYzlqIRIykvkTS3KqgFLOQ93XNS2/oshKNsumVu7N9L8
         Lc0mO2DL/Dq2UsQJ3BAOwOfFp2yfzdrHvpZxDQssR4yrZqbbtZ83XRtMdQIt8Jy3KBIp
         CQvVVNwtyGj0xsrU8vc1lnX+MwJi93Qkg6Xp6ui6EdygN5dAI8qwLG4hV6v7vro7dFk6
         N67GgXaUuess7eOOwH+3XTp0LqKa8/CM6h1DG84jEZXinLdDrCuS/zdJ3udxGe1ncv2m
         QjKMk/1eJVl2Wf8u/dgFa94E0jMcwr/tL3Oovbf4tFpfeDnBtbls8O36pBdhRZ+/PCtV
         gNmw==
X-Received: by 10.194.202.230 with SMTP id kl6mr1286595wjc.9.1394028884544;
 Wed, 05 Mar 2014 06:14:44 -0800 (PST)
Received: by 10.217.58.65 with HTTP; Wed, 5 Mar 2014 06:14:44 -0800 (PST)
In-Reply-To: <xmqqa9d5lsdb.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243439>

2014-03-05 2:40 GMT+08:00 Junio C Hamano <gitster@pobox.com>:
> From: Sandy Carter <sandy.carter@savoirfairelinux.com>
> Date: Mon,  3 Mar 2014 09:55:53 -0500
>
> Add missing leading dash to proposed commands in french output when
> using the command:
>     git branch --set-upstream remotename/branchname
> and when upstream is gone
>
> Signed-off-by: Sandy Carter <sandy.carter@savoirfairelinux.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>  * Forwarding to the i18n coordinator.  I don't do French, but this
>    seems trivially correct.

Applied to maint branch of git://github.com/git-l10n/git-po, and can be
merged to master directly.

-- 
Jiang Xin
