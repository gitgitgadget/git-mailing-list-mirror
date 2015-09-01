From: =?UTF-8?Q?erik_elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
Subject: Re: [PATCH] t7300: fix broken && chains
Date: Tue, 1 Sep 2015 08:31:37 +0200
Message-ID: <CAMpP7NZMMYyCbmnzhLTqa73TD_mqk+rO8=D0v9qb0z_UmBQ-rg@mail.gmail.com>
References: <1440926289-5899-1-git-send-email-erik.elfstrom@gmail.com>
	<xmqqzj17wg1i.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 01 08:31:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWf6c-0003WS-He
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 08:31:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753187AbbIAGbj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 02:31:39 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:35176 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751609AbbIAGbi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 02:31:38 -0400
Received: by obcbp4 with SMTP id bp4so39739261obc.2
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 23:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=2udwSKX9f57pVooTAmCkI6GINTfvEgWBhwcaH3o3TgU=;
        b=UipcCNWHwSkksZx/U4rNddHxuAXvY/GsUpIlNobqHji8r1VGdLZoYUAKsVZki+XBBe
         Vms63nONiLjOiOYQCqL5eeZE8cKI1QKMuGl/B/h1GESICtOxPe/HomRW5S65TyhRwBlq
         mQ3Fl39KVHORW+Z5gsEWX+UszwkIxD5qasfElbBaDgl4r3dKOnJWopTGw2WjXpVN3tSY
         Y12SyUW51HzZZPhOuXUozUTKElpi32/8elL43vcfWjAi95abcUGOC7ycHJmV9S46s4Sk
         r33GVAha8hiLzVvn4UzwUSyzYX+Xnpd6YzY9eiPgX0g3+nm0gwa/zImuEX1j+hOMVsn2
         qDqg==
X-Received: by 10.60.116.3 with SMTP id js3mr16599716oeb.15.1441089097792;
 Mon, 31 Aug 2015 23:31:37 -0700 (PDT)
Received: by 10.182.116.69 with HTTP; Mon, 31 Aug 2015 23:31:37 -0700 (PDT)
In-Reply-To: <xmqqzj17wg1i.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276969>

On Mon, Aug 31, 2015 at 6:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Many of the constructs we see here shows clearly that this is an
> ancient part of the codebase ;-), as we would be using the one
> parameter form of "git init" and more test_* helpers if we were
> writing this script in today's Git codebase.  It may have been
> better if you didn't do "while we are here" and corrected only the
> &&-chain in patch 1/2 and then updated the style of the tests to
> take advantage of the newer facilities recent test-lib has in a
> separate patch 2/2, but this will do at least for now.
>
> Will queue.
>
> Thanks.


I can do a re-roll with the chain fix in the first patch and a more
thorough modernization of t7300 in separate patches if you'd like? I
almost went this way for v1 but decided to limit the scope for the
first version.

(Forgot to include the list in my first reply, sorry... And forgot to
turn off HTML in the second... sigh, sorry for the spam)

/Erik
