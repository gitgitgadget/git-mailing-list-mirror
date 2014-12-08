From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [RFC/PATCH 0/5] git-glossary
Date: Mon, 8 Dec 2014 17:16:02 +0100
Message-ID: <CAP8UFD0yRKRPj3x6jZoL72jkzs0T2vZ0HZVi46zX0gzXqGv_Sw@mail.gmail.com>
References: <cover.1418052470.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Dec 08 17:16:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xy0yn-0006ie-Qc
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 17:16:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755947AbaLHQQF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 11:16:05 -0500
Received: from mail-ie0-f177.google.com ([209.85.223.177]:59752 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755908AbaLHQQE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 11:16:04 -0500
Received: by mail-ie0-f177.google.com with SMTP id rd18so4758907iec.36
        for <git@vger.kernel.org>; Mon, 08 Dec 2014 08:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=cmAq+t6dwbk34I3Q27qVFlPtubgzcp+5S9f2srYKIeQ=;
        b=jV16+gSbJ9hUnAk5n8b3NklwXLCBPEzDzRs3UUz2EkCUprT8JGlNigqZuqKvKm4IQc
         L53CiYxmbcL+Ffrevd+4Dx/9kUb/iM7p5nXJWoZCHHQwoJo5HKpw1WRmnEaBKU51RRsa
         Mgzwqhco7mrTHhCT0iQuNHuzIZ8EbRFadiHnqHJ+PE46TaQUzo8hZtuB16nhyWg08cFC
         fmzcdXczPw+Gb2zC5fgIiMHLC+z0tbPOQEdaSQ9DN0rA38TSugXNt0yPjz1hyMHNMoEu
         mqWUMta2yHTvFyiLJUbtYZDeoFFYS9KUL2sFcfz0cP9nby1PjaJNbAtFNoLCc4j3gRuQ
         AXeQ==
X-Received: by 10.107.135.211 with SMTP id r80mr11651746ioi.67.1418055362444;
 Mon, 08 Dec 2014 08:16:02 -0800 (PST)
Received: by 10.50.30.40 with HTTP; Mon, 8 Dec 2014 08:16:02 -0800 (PST)
In-Reply-To: <cover.1418052470.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261072>

On Mon, Dec 8, 2014 at 4:38 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> More and more people use Git in localised setups, which usually means
> mixed localisation setups - not only, but also because of our English
> man pages.
>
> Here's an attempt at leveraging our current infrastructure for helping
> those poor mixed localisation folks. The idea is to keep the most
> important iterms in the glossary and translate at least these.

If the problem is related to all the man pages, shouldn't the solution
apply to all the man pages?

> 1/5: generate glossary term list automatically from gitglossary.txt
> 2/5: introduce git-glossary command which helps with lookups

Couldn't you improve git-help ?

Thanks,
Christian.
