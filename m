From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH v4] mergetools: add winmerge as a builtin tool
Date: Wed, 20 May 2015 09:47:56 +0200
Message-ID: <CAHGBnuMCvzBYRYgLxz-5QJ5x8Quhw6byf+cGteRXQzpU65B+Jg@mail.gmail.com>
References: <1432107722-98613-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Phil Susi <phillsusi@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 20 09:48:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuyjV-0005rG-GS
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 09:48:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752953AbbETHr7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 03:47:59 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:36152 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752824AbbETHr5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 03:47:57 -0400
Received: by iepj10 with SMTP id j10so32928231iep.3
        for <git@vger.kernel.org>; Wed, 20 May 2015 00:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Og/ALCuj82g+k77gbniyYKTiSH9048fApJ25he+6Hz0=;
        b=mzk1XQlF7sjHT9qK5hyrkFqGcD06/kCcffZoVgT0XcG+IVgx62MxQL6mBAv8voG+75
         CR/uqIQtiVX8I8WYzZNi/9p7W3hqgU7ZBBeUGJpgh7UAMZlWJ+wBp454O6AxJHWkrZXK
         dT9nA4QAjz/Owgr8/KFA74TQn0MKMFHp0HyvTW3+KqMGCzC8cdicGw0GaEAklUogj9Si
         JCqs/cXzcelgzfEgUnrXExyvZU+wMzQjjcl2+f3ZvK1AmpZporU9FSrwtxR80wKp9qV2
         Cci++I9+ZKO3HLikiarJCRbfScj5KfZwy400MW5aJ50CsJyX/Kc3BUnTXRlmlDOP9aUD
         aedg==
X-Received: by 10.107.10.146 with SMTP id 18mr13946256iok.40.1432108076975;
 Wed, 20 May 2015 00:47:56 -0700 (PDT)
Received: by 10.107.29.149 with HTTP; Wed, 20 May 2015 00:47:56 -0700 (PDT)
In-Reply-To: <1432107722-98613-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269448>

On Wed, May 20, 2015 at 9:42 AM, David Aguilar <davvid@gmail.com> wrote:

> +       OIFS=$IFS
> +       IFS='
> +'

I guess this is just a formatting issue with the mail export as it should read

IFS=$'\n'

Otherwise looks good to me.

-- 
Sebastian Schuberth
