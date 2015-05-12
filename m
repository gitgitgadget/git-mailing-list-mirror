From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 3/3] cat-file: add --follow-symlinks to --batch
Date: Tue, 12 May 2015 16:06:53 -0700
Message-ID: <xmqq1tile6pe.fsf@gitster.dls.corp.google.com>
References: <1431384645-17276-1-git-send-email-dturner@twopensource.com>
	<1431384645-17276-4-git-send-email-dturner@twopensource.com>
	<xmqqoalpzn3s.fsf@gitster.dls.corp.google.com>
	<1431455779.16652.20.camel@ubuntu>
	<xmqqk2wdzlfm.fsf@gitster.dls.corp.google.com>
	<1431456922.16652.26.camel@ubuntu>
	<xmqqlhgtftw0.fsf@gitster.dls.corp.google.com>
	<xmqqd225fsw8.fsf@gitster.dls.corp.google.com>
	<1431470204.16652.52.camel@ubuntu>
	<xmqq617xe6x8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed May 13 01:07:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsJGN-00073s-Qd
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 01:07:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753971AbbELXGz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2015 19:06:55 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:33604 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933808AbbELXGz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2015 19:06:55 -0400
Received: by igbpi8 with SMTP id pi8so104340355igb.0
        for <git@vger.kernel.org>; Tue, 12 May 2015 16:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=J97YYG7p3iMtef4yuwov+7EhRL8ACWH3lOG4AqSukS8=;
        b=TRGsiYlH7tVO9WIoNvsnk5WO/9kB2sCH9DDcaJ1591oSy4e/B+JXwNh9s47GZYxXwW
         FVMLG0Lod7d1S/BXBkGgaSxhQE4ticeRvR8NqopOCcei6OsDefsvVw8yRInJY/jH7crj
         0Hs9E5/7DK4UU47zSbs8Py2iLV10xY7btQmyPDvJjH5cs/vRc65YDkTS1qSgE1gP3nF8
         jvty7GdLS9ohL2QDjnQqECyvzWydO4dCpr9OhQklRMugKtttBPJcrxLPLId0NCR+4ahd
         f/34T6VzssBGWmUHzOI45uDSpR6FqImN47e3iI7JH3UeoCGncUFcbxFA5EKRBeBH3CYQ
         8HMA==
X-Received: by 10.107.132.223 with SMTP id o92mr23285170ioi.49.1431472014477;
        Tue, 12 May 2015 16:06:54 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3cfa:54ee:8e48:89ad])
        by mx.google.com with ESMTPSA id r4sm2234183igw.12.2015.05.12.16.06.53
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 12 May 2015 16:06:53 -0700 (PDT)
In-Reply-To: <xmqq617xe6x8.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 12 May 2015 16:02:11 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268903>

Junio C Hamano <gitster@pobox.com> writes:

> David Turner <dturner@twopensource.com> writes:
>
>> In addition, I would like to have the format for the dangling, loop, and
>> notdir cases match the missing case.  In other words, "HEAD:link
>> missing", "HEAD:link dangling", etc.  Users already need to parse the
>> missing case, so we might as well make the others match.
>
> Interesting to see our opinions differ here, especially because the
> previous suggestion was coming from "users already need to parse the
> 'symlink' case, so we might as well make the others match" ;-).
>
> Between 'missing' and 'symlink', the latter is richer in information
> and easier to parse, I would have thought.

Forgot to conclude the paragraph with final sentence.

... But I do not deeply care either way.

Thanks.
