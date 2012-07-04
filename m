From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 3/3] gitweb: Add support to Link: tag
Date: Wed, 4 Jul 2012 10:30:11 +0900
Message-ID: <CAM9d7cgO1u86o0Wk+XUOE=vkDkb=T5UTSX4Tz5pgMYE+ztaubA@mail.gmail.com>
References: <1341295377-22083-1-git-send-email-namhyung@kernel.org>
 <1341295377-22083-4-git-send-email-namhyung@kernel.org> <7vy5n0txdi.fsf@alter.siamese.dyndns.org>
 <CAM9d7ciU8j6Kt+9akyPpPiUdCJSFyL1xBbG2_c2epa79FgMmiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 04 03:30:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmEQQ-000211-M5
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jul 2012 03:30:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756204Ab2GDBad (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 21:30:33 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:60863 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756160Ab2GDBad (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 21:30:33 -0400
Received: by qcro28 with SMTP id o28so4041791qcr.19
        for <git@vger.kernel.org>; Tue, 03 Jul 2012 18:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=rSdnfuvHMngBS4f7Dh9m6xNP+A0xqoAMW4ta8Uh9/CY=;
        b=C8Gmwtnm/AWmlPGdl6HMUWRWathwsw7kutIA4jV8RJRUCTJCNuBLnndESzQCdw3Au/
         dTbu4vrbGL5maWIAFhFSUipaJTM4u0H92SvYYGBX8JByMvOSYxddhG2w4dHUgWW9qJYj
         ceAhXWKu/5EuSL5jatQ1QIYaSxMo4vgT48SxHR483DPwz6p5XRbMuNQbH1QqlK+vSlhH
         k5JdFmShONEMwN82sIbbMddR2W3Z0PMcT1/hIOV0oFGj38oy/m00f5ob4tTFbicfMfgN
         bXEjsSJPFdOZ7Kh7TynoEKadY8qLi0vQHG56FFAykF4jajuUTjaKJM88eF+M0odq+2f+
         p2vA==
Received: by 10.229.135.129 with SMTP id n1mr10123496qct.32.1341365432122;
 Tue, 03 Jul 2012 18:30:32 -0700 (PDT)
Received: by 10.229.176.217 with HTTP; Tue, 3 Jul 2012 18:30:11 -0700 (PDT)
In-Reply-To: <CAM9d7ciU8j6Kt+9akyPpPiUdCJSFyL1xBbG2_c2epa79FgMmiw@mail.gmail.com>
X-Google-Sender-Auth: 2I7EagKW4i9KxK2ZXukpoArtVq8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200978>

On Wed, Jul 4, 2012 at 10:24 AM, Namhyung Kim <namhyung@kernel.org> wrote:
> On Wed, Jul 4, 2012 at 5:15 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Namhyung Kim <namhyung@kernel.org> writes:
>> I also notice that "Reported-bisected-and-tested-by: " in that
>> example, which is the topic of your [PATCH 2/3].  Perhaps the logic
>> should catch everythinng that match "^[A-Z][-a-z]*[a-z]: ".
>>
>
> Isn't "^[A-Z][-A-Za-z]*-[Bb]y: " enough?

Oh, I guess you considered "Cc: " also.
That could be handled specially, though.

Thanks,
Namhyung
