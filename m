From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] run-command: simplify wait_or_whine
Date: Sat, 1 Jun 2013 10:01:49 -0500
Message-ID: <CAMP44s2cBGc+uKH0t-KZko-5GYkZUK54+7wiYbWim55B7KGaGA@mail.gmail.com>
References: <1370094715-2684-1-git-send-email-felipe.contreras@gmail.com>
	<CACsJy8Df-O=D5LQBXCbiVLB=uHfn6ETbAxADWq3hd-9pPX4+mg@mail.gmail.com>
	<CAMP44s0L1M+_s2eDM=Ogy=rxLhpZYwSb8qWTuEe30pB4KGDVtA@mail.gmail.com>
	<CACsJy8BFv7kJkymJ_rj9dwaN-zMcHtS9sjmqDSpLWB5TsUU_kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"John J. Franey" <jjfraney@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 01 17:02:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UinJb-00017O-O9
	for gcvg-git-2@plane.gmane.org; Sat, 01 Jun 2013 17:01:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756309Ab3FAPBw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Jun 2013 11:01:52 -0400
Received: from mail-wg0-f50.google.com ([74.125.82.50]:60027 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753616Ab3FAPBv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Jun 2013 11:01:51 -0400
Received: by mail-wg0-f50.google.com with SMTP id k13so2025997wgh.29
        for <git@vger.kernel.org>; Sat, 01 Jun 2013 08:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=DlgYFbccwKJkB0QS+7vVR6eUNcN+JKICzvFvjWAcyZw=;
        b=rCoJruGbt3khwH8lfSht3Z/SC+XfE+HgKHNl/gN2QuaUqgT4BDX9KrHAHvOqAPc7nu
         AyOmObtVObux8jRfY3BysHWpz4XCfd1CIcx16RQd4wLOgu1nrGxaFODx2sgK/IFioRLp
         VTc+HpMXP7o8FfvknDb2MWfFpMd+jQWYmxC4dRce57PqkTVL8jY2x1LlvGSgV4Kn5UVY
         b2SJb/4jQsX/y65+WUi/skRmpwZo15uAsg4n0o51srEp+4AjKRwXAWPSDyk5zkSFNGCP
         gTt+YXz1x4LUUIUoj6eCwGtJrOgJ+dP+gtlkewRvycGC0KTDBy243Q9LA3MzaC1XwwO7
         T12Q==
X-Received: by 10.180.189.136 with SMTP id gi8mr7223665wic.11.1370098909375;
 Sat, 01 Jun 2013 08:01:49 -0700 (PDT)
Received: by 10.194.47.4 with HTTP; Sat, 1 Jun 2013 08:01:49 -0700 (PDT)
In-Reply-To: <CACsJy8BFv7kJkymJ_rj9dwaN-zMcHtS9sjmqDSpLWB5TsUU_kg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226137>

On Sat, Jun 1, 2013 at 9:36 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sat, Jun 1, 2013 at 9:30 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> On Sat, Jun 1, 2013 at 9:21 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>>> On Sat, Jun 1, 2013 at 8:51 PM, Felipe Contreras
>>> <felipe.contreras@gmail.com> wrote:
>> Yeah, and last year we returned a different code. The world didn't
>> end, because nobody is checking for the specific code. But if you want
>> to retain complexity forever, suit yourselves.
>
> And that was changed for a reason, compared to this change "because I
> like it". I maintain my NAK (not that it matters) until you justify
> your change better than "nobody is using it".

Who said the reason was "because I like it"? You don't agree that
making the code simpler and more maintainable is a good reason for any
change?

Anyway, if you care so much about the current behavior, why isn't
there any tests that check for this?

My patch passes *all* the tests.

-- 
Felipe Contreras
