From: Frans Klaver <fransklaver@gmail.com>
Subject: Re: [PATCH] Fix bash completion when `egrep` is aliased to `egrep --color=always`
Date: Mon, 26 Nov 2012 12:30:48 +0100
Message-ID: <CAH6sp9PwsxLDDXfA5oZk-3X+d7h5OdR3TRX7aMMyTA+8WDuSmA@mail.gmail.com>
References: <20121122154120.GA16835@redhat.com>
	<CAFj1UpG6H3bpoa7xbqpH6Hyb6pwqE_CCgP6iT36D-ELvtVi4wA@mail.gmail.com>
	<20121126112352.GA4481@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Marc Khouzam <marc.khouzam@gmail.com>, git@vger.kernel.org
To: Adam Tkac <atkac@redhat.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 12:31:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tcwu0-0004on-Da
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 12:31:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754370Ab2KZLau (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 06:30:50 -0500
Received: from mail-qc0-f174.google.com ([209.85.216.174]:35863 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754043Ab2KZLat (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 06:30:49 -0500
Received: by mail-qc0-f174.google.com with SMTP id o22so7760453qcr.19
        for <git@vger.kernel.org>; Mon, 26 Nov 2012 03:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=xmm+r9B118x91PZxI0XLWOo7HT5Hpklc2ruZxOLUVM8=;
        b=H91WXaz4vNr7yHdNkwrlc37OGNfb6E1AVYcpUpapQ/0hlxsVHkXqFpcn248dwIF2hN
         hHgZbhSQAUZCCmcU9qsi/i60OIlwP9SsXTrmy5o8B5vQmEj7O8pvUtc3zycZHoIwpoFQ
         /cOYtgd5C8zpbPY+hRmJD6lJ20f3LYKAw9lqqFtrT1ZEniD3/V0mX2RsUGdYQoHBsQ6r
         Ryai/smDyhc01BHhXtsFvE4NULF/dv5Zl4/zMs76/hibEhIW/h5JbLQlmET/UcBWIh/k
         tCDOkY9HMPM05VR0uI6I+DHpXk/yEPQjyv4PW98qodwf5iNh4h4tKE8oXSkoPhRqZgca
         oLoQ==
Received: by 10.229.111.220 with SMTP id t28mr2705057qcp.146.1353929448716;
 Mon, 26 Nov 2012 03:30:48 -0800 (PST)
Received: by 10.224.188.212 with HTTP; Mon, 26 Nov 2012 03:30:48 -0800 (PST)
In-Reply-To: <20121126112352.GA4481@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210431>

On Mon, Nov 26, 2012 at 12:23 PM, Adam Tkac <atkac@redhat.com> wrote:

> Good idea, thanks. Improved patch is attached.

It is custom on this list to mail the patches, rather than attaching
them, so people can review your changes in-line. You can read more
about it in in git/Documentation/SubmittingPatches.

Cheers,
Frans
