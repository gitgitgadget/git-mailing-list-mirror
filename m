From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/2] add: refuse to add paths beyond repository boundaries
Date: Tue, 9 Apr 2013 23:11:28 +0530
Message-ID: <CALkWK0k0YMWjhJQFWLv6b7kAHqRm8-Dq23gMVHYfatq1SLUDhQ@mail.gmail.com>
References: <CALkWK0m_82ThYKxcr=YHGBnOaHr9yBpYFHxx2KrnQkWD_zjp1A@mail.gmail.com>
 <1365499297-8667-1-git-send-email-artagnon@gmail.com> <1365499297-8667-3-git-send-email-artagnon@gmail.com>
 <7v4nfftyu3.fsf@alter.siamese.dyndns.org> <7vvc7vsj4p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 09 19:42:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPcYg-0002cb-Uk
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 19:42:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933672Ab3DIRmK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 13:42:10 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:45737 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933489Ab3DIRmJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 13:42:09 -0400
Received: by mail-ie0-f173.google.com with SMTP id 9so8864018iec.4
        for <git@vger.kernel.org>; Tue, 09 Apr 2013 10:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=/sOJz87AFAn347MZV+Sadww8P4+YuZ9QeIvOIAF9tss=;
        b=MCYVLrJx3od7XocBe6CjCezIeSQy3iTPi45zhgQSBh/ZtKk0+ofAzhDfSPvLY2Lsp7
         cEANE9AU6IZa0wV+2Ss9wfPntaVxvvbOVsVjJKaOEpLSqacRQHJDxsxqtA6T5YSr5GBq
         KonuDRi0R6wrCGOUvPbuP8i9QFIYbXvczaDogPpfr2lQ68NnFSBeUHv9yii8fbCWf/BN
         OUveleUrJXvvUI2uVlzywITlFmSJvg0rCxuDvAK5BxM4XdmWcWUNhvV1RP6rpZHK7mLZ
         7/YaDFwybbtZZEzh5ftoB/RjTXxgUloJ/IBUsyMS7WqrDmyhoUEmU4obTiti1ZKHEs3k
         rn4g==
X-Received: by 10.50.117.3 with SMTP id ka3mr10229022igb.107.1365529328915;
 Tue, 09 Apr 2013 10:42:08 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Tue, 9 Apr 2013 10:41:28 -0700 (PDT)
In-Reply-To: <7vvc7vsj4p.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220598>

Junio C Hamano wrote:
> The first step (renaming and adjusting comments) would look like
> this.

Thanks for this!  I like the name die_if_path_outside_our_project().
I'll take care of the rest.`
