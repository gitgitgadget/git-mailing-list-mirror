From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 07/10] builtin/replace: teach listing using short,
 medium or full formats
Date: Wed, 18 Dec 2013 17:49:49 +0100
Message-ID: <CAP8UFD3UsdcDg2D2nysMZgGAxLebYm-qQX3LZfqdwF9gNbyxgA@mail.gmail.com>
References: <20131211074147.11117.1155.chriscool@tuxfamily.org>
	<20131211074614.11117.96106.chriscool@tuxfamily.org>
	<52B196F1.3060003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Joey Hess <joey@kitenet.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 18 17:49:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtKJn-00011o-2h
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 17:49:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755092Ab3LRQtv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Dec 2013 11:49:51 -0500
Received: from mail-vc0-f169.google.com ([209.85.220.169]:38413 "EHLO
	mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751930Ab3LRQtu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 11:49:50 -0500
Received: by mail-vc0-f169.google.com with SMTP id hu19so5221085vcb.14
        for <git@vger.kernel.org>; Wed, 18 Dec 2013 08:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=tRH7XMptijXEeFRYaENMB4R5GTmoOLX4wdwF3710hdc=;
        b=E4d+uYJCO8dqF2BE7Z8V02XhPz7j5UgjJoFhCMj2U6fLaWT1/rP1YJgPyQJhsDDpkF
         vXyfFNM+O6EzK+zUqzGsFrX2SMUODCZvVyPLqhJTfFr0+c0qZu7w5vzoUuaRtxHCQcjF
         O/49K4k2D08g4VvJSMPxBVWvT63IAzhm1QAAOA9IRbkmhkQD52FDAzrwZ5KPfkgsvm8g
         tkTeSSD9AGnM+rJtlTxy7AgU17UAegrEfxXmiz8dyr7pSgliPiudLO0tUcqtBCccaSm0
         cnbgnpqBeKaxZ7iUvsR9wtUSaKY6SN88pAewRrbbThERl4hmcXbRm3U0IlBhnP3xc7hR
         t5Wg==
X-Received: by 10.221.18.70 with SMTP id qf6mr1305575vcb.37.1387385389705;
 Wed, 18 Dec 2013 08:49:49 -0800 (PST)
Received: by 10.58.253.136 with HTTP; Wed, 18 Dec 2013 08:49:49 -0800 (PST)
In-Reply-To: <52B196F1.3060003@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239456>

On Wed, Dec 18, 2013 at 1:37 PM, Karsten Blees <karsten.blees@gmail.com> wrote:
> Am 11.12.2013 08:46, schrieb Christian Couder:
>> +enum repl_fmt { SHORT, MEDIUM, FULL };
>
> SHORT is predefined on Windows, could you choose another name?

Ok, I will change to:

enum repl_fmt { SHORT_FMT, MEDIUM_FMT, FULL_FMT };

Thanks,
Christian.
