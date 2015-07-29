From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH v3 2/6] notes: replace pseudorefs with real refs
Date: Wed, 29 Jul 2015 04:37:07 +0200
Message-ID: <CALKQrgdkGUqjFaX+Z_U5oNL1bGdCn+qSRfQktHXA8q82KwVAHw@mail.gmail.com>
References: <1438107144-24293-1-git-send-email-dturner@twopensource.com>
	<1438107144-24293-3-git-send-email-dturner@twopensource.com>
	<xmqqpp3cds44.fsf@gitster.dls.corp.google.com>
	<xmqqegjsdq3n.fsf@gitster.dls.corp.google.com>
	<CALKQrgdLC_sLkM3jyH6pnDoY+RTHr9wJR_VH6iirBWmvyHYcVA@mail.gmail.com>
	<xmqqpp3bc2u6.fsf@gitster.dls.corp.google.com>
	<CALKQrgfxc83-yjrCWZqC+pyPhbQDgYbrpCDSaBk78YypO=BXOg@mail.gmail.com>
	<xmqqd1zbbtc4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Turner <dturner@twopensource.com>,
	Git mailing list <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Philip Oakley <philipoakley@iee.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 04:37:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKHFC-00036I-Bi
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 04:37:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752269AbbG2ChP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 22:37:15 -0400
Received: from locusts.copyleft.no ([188.94.218.116]:63180 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751520AbbG2ChO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 22:37:14 -0400
Received: from mail-yk0-f180.google.com ([209.85.160.180])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1ZKHF2-0002sj-Td
	for git@vger.kernel.org; Wed, 29 Jul 2015 04:37:13 +0200
Received: by ykdu72 with SMTP id u72so112214701ykd.2
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 19:37:07 -0700 (PDT)
X-Received: by 10.13.223.149 with SMTP id i143mr40810712ywe.91.1438137427120;
 Tue, 28 Jul 2015 19:37:07 -0700 (PDT)
Received: by 10.37.208.71 with HTTP; Tue, 28 Jul 2015 19:37:07 -0700 (PDT)
In-Reply-To: <xmqqd1zbbtc4.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274877>

On Wed, Jul 29, 2015 at 4:17 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Perhaps you meant by "per repo" to mean "per $GIT_DIR" in this
> message, and if that is the case, then I think we are in agreement.

No, by per repo I mean per $GIT_COMMON_DIR (I haven't followed the
linked worktree effort, so this language is new to me. My apologies).

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
