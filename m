From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v6 1/2] worktrees: add find_shared_symref
Date: Mon, 10 Aug 2015 18:49:49 -0400
Message-ID: <CAPig+cQ-Y6=A-bUEtBzHCV_roDShFcm9qnv8PC6gge2Y0anU_w@mail.gmail.com>
References: <1439229165-25773-1-git-send-email-dturner@twopensource.com>
	<CAPig+cTBLx2Q0n2ZcA-QgwNQMHZm9G45ThHbGc+Orkz-6c5cUg@mail.gmail.com>
	<1439246526.5283.3.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Johan Herland <johan@herland.net>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Aug 11 00:49:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOvtC-0000TX-Py
	for gcvg-git-2@plane.gmane.org; Tue, 11 Aug 2015 00:49:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932791AbbHJWtv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 18:49:51 -0400
Received: from mail-yk0-f181.google.com ([209.85.160.181]:32943 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751313AbbHJWtu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 18:49:50 -0400
Received: by ykaz130 with SMTP id z130so45288187yka.0
        for <git@vger.kernel.org>; Mon, 10 Aug 2015 15:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=orpbT7cYb5LtBLmE8DUUmQT/hDlECjCvX/jdOFjGsP0=;
        b=xtEewhi7YbSeqolfuh0rLRVnqFBfbeA8DwMZFV5ioIbMIiCP+1tOpKThI1MBQAfj37
         hdrqwbFBaWKpb+gHmLuKD1Gq8vkxjvoQcKKNMrTmJj9894JUIDE6dyD7StU/my3UhxHP
         5awHpyNAMlhflamUdnK4YO9jcdZPKFKaRRPNZZui/A0uIbrX24QuPJ4snFNNtbclFr1P
         vN5J/1fHIHJb99/7aBfXVEwvWFybVNySraY8om8dcpypXfEuE3Ui8l9p63tVMLcDYvVr
         eNsRcoozKLYZQlf2n/QNf7y0z0RzAJuyiD/lgA11rcLPG9MnoFonE7k7+NlRmAQn6F8o
         qjYA==
X-Received: by 10.170.97.9 with SMTP id o9mr24038843yka.84.1439246990044; Mon,
 10 Aug 2015 15:49:50 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Mon, 10 Aug 2015 15:49:49 -0700 (PDT)
In-Reply-To: <1439246526.5283.3.camel@twopensource.com>
X-Google-Sender-Auth: 31DDIAiBjHm1AiBttTDzIWZUpgE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275661>

On Mon, Aug 10, 2015 at 6:42 PM, David Turner <dturner@twopensource.com> wrote:
> On Mon, 2015-08-10 at 18:30 -0400, Eric Sunshine wrote:
>> On Mon, Aug 10, 2015 at 1:52 PM, David Turner <dturner@twopensource.com> wrote:
>> > worktrees: add find_shared_symref
>>
>> s/worktrees/branch/ perhaps?
>
> Do you mean "this is in branch.c, so should be labeled with branch"?
>
> Because this change is mostly about non-branch refs, so I think saying
> "branch" is confusing.  That's why I labelled it "worktrees"; that's the
> broad topic that's being addressed.

Okay.
