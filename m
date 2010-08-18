From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC/PATCH] Add test case for dealing with a tracked file in an
 ignored directory
Date: Wed, 18 Aug 2010 14:02:40 +0000
Message-ID: <AANLkTinhAMNm3OyGPE4xbkXrF9nB=0rZy=9s1witpNfG@mail.gmail.com>
References: <AANLkTiky+azVAnXEBFWR1q9_8NH8TX2TfuonXCpA_-ms@mail.gmail.com>
	<1282123788-24055-1-git-send-email-gdb@mit.edu>
	<AANLkTi=UJmXx0-fV6OqDTOzuTdQQWioUb=3vrVx01qi6@mail.gmail.com>
	<vpqk4noc9ro.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Greg Brockman <gdb@mit.edu>, git@vger.kernel.org,
	gitster@pobox.com, Jens.Lehmann@web.de, jrnieder@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Aug 18 16:02:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OljE8-0004cZ-4w
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 16:02:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753374Ab0HROCm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Aug 2010 10:02:42 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:41360 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753125Ab0HROCl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Aug 2010 10:02:41 -0400
Received: by iwn7 with SMTP id 7so721766iwn.19
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 07:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=cI5Mn7iTFllOZDW9wTH3vQ9sAWc5gtUyblgS9gZx/aQ=;
        b=epEqzTSdhkpKr7M/vD6MTOSHTLFxsw7WhQ/J4z+gd584RHTc4ueVPKl1uFMTzS7Edi
         Mi7DnN5C2CRxME7rMmh1Dcf97CqzEqcibvVBl0vZNZRrtrfJRH9bgVOytgx/FJ0CqgeL
         +vTcqA49xkhvyOu5OrUsdQLugChYOauZFkz3Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=dwhzh0cKgSsiewWTw/8wUKI/mq1B+AGtS/yKnVBWkmgbJplSmN/A2jLZonN2L/XB58
         AX+7rzmaM32PDnF33Msruy4migGLiCrusyCSafxEHZVF2KY0ECguHVSH1o61ObvZnJM4
         cpFboQqcDq2b2HjVk8l3PoVxMl1ptgP/pfwBU=
Received: by 10.231.12.77 with SMTP id w13mr9255425ibw.129.1282140160952; Wed,
 18 Aug 2010 07:02:40 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Wed, 18 Aug 2010 07:02:40 -0700 (PDT)
In-Reply-To: <vpqk4noc9ro.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153856>

On Wed, Aug 18, 2010 at 13:47, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Not sure what is the gain by doing so

Most of those cases were already discussed in
<1278082789-19872-8-git-send-email-avarab@gmail.com> and surrounding
mails, I'll point to those instead of repeating things, unless there's
something else that needs clarifying (and perhaps elaborated in
t/README).

> and the vast majority of tests already there use the style of Greg's
> patch ...

They do because we haven't converted them yet. New tests following the
recommendations in t/README helps with that conversion effort.
