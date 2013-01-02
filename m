From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH 3/4] t4014: do not uese echo -n
Date: Wed, 2 Jan 2013 00:42:32 -0800
Message-ID: <CA+sFfMc=ZJ0=LyYBmEWTJFY_eDi4qLZv9Fz+1m6SkRO9WF8zOQ@mail.gmail.com>
References: <201301012241.17050.tboegi@web.de>
	<7vwqvw5qpg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 02 09:50:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqK1O-0001tE-5H
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 09:49:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752654Ab3ABItj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jan 2013 03:49:39 -0500
Received: from mail-vb0-f53.google.com ([209.85.212.53]:39498 "EHLO
	mail-vb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752274Ab3ABIti convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Jan 2013 03:49:38 -0500
Received: by mail-vb0-f53.google.com with SMTP id b23so13808478vbz.40
        for <git@vger.kernel.org>; Wed, 02 Jan 2013 00:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=AaoMQ66ynb5hSSMB6Yz56U6OkaXgtwZBxM4l69CZqhg=;
        b=S8f1Qf4gv5P27MFHHy0hmq+hkVs+u0XqxQwhj5DXfRoQxBqBrW7hfFWpfJbsUd9j9B
         WRo9zxxMjciXsnXPcpFAI4eNfb9XhwTzwlEpflP3NAMU549ms0Ml3g0K7BwshZgIEcq7
         bLOFafnvj2GVciJ5MFunrHD1ZqTK7yatfO+tn1M7tsvHhWyVsR01fTGKH5DXYj9DfPxc
         9d70W0HydgrG50R7HgjqPGOrTZ6jQSUsd9q0D+JYs9cFIfbRuwBwHaRJo9vgBgAa6uLK
         qip/gj59h9FJi8Wls0JFRj580CcwlMbUw6JusFvYG1wmhzPfzqRyAAhGmnfIgEaz7/T9
         PuIg==
Received: by 10.52.93.146 with SMTP id cu18mr61427592vdb.37.1357116152354;
 Wed, 02 Jan 2013 00:42:32 -0800 (PST)
Received: by 10.58.215.106 with HTTP; Wed, 2 Jan 2013 00:42:32 -0800 (PST)
In-Reply-To: <7vwqvw5qpg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212507>

On Tue, Jan 1, 2013 at 5:16 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>
>> echo -n is not portable on all systems.
>> Use printf instead
>>
>> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
>> ---
>
> Brandon, this comes from 932581b (Unify appending signoff in
> format-patch, commit and sequencer, 2012-11-25).  Please make sure
> to squash it in when you reroll the series.

Will do.

> Thanks (and a happy new year ;-).

Thanks.  Happy New Year to you too. :)

-Brandon
