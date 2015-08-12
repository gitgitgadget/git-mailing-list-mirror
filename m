From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 0/4] submodule config lookup API
Date: Wed, 12 Aug 2015 12:27:18 -0700
Message-ID: <xmqq614kl33d.fsf@gitster.dls.corp.google.com>
References: <1439406838-6290-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: hvoigt@hvoigt.net, git@vger.kernel.org, jens.lehmann@web.de,
	jrnieder@gmail.com, peff@peff.net, wking@tremily.us,
	sunshine@sunshineco.com, karsten.blees@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 21:27:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPbgL-0001hB-Uk
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 21:27:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752021AbbHLT1V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2015 15:27:21 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35612 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751852AbbHLT1U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2015 15:27:20 -0400
Received: by pacgr6 with SMTP id gr6so20569124pac.2
        for <git@vger.kernel.org>; Wed, 12 Aug 2015 12:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=KTTG45ZPXhDo54/5D/7hoYoqV1g0PUVgAFYkd1r/8rk=;
        b=nsSZuIE/iScsQ6CgTAptaBtqMiVW2yidaEK0lJ4qTNNlM4EdYbeEzoxzUzUzxfFJOp
         JTP5uAi0dvA6Jaxwm5M4JoEcZsP1bT5a19UkErpSqa/2fsbXPpX+MhDqVtGBxV0OaPQU
         j6vNMCT3xLnqs3Ib/3UZ3DGZWc4rsB9o+PMScKtLeKUXO8XWrwMkO8dt9kdeusnEyYR5
         s0RQ8XOR7BgUisaZRJkL/6CozY6II55Au3zsqw/68hxvFFQsY7Hk5sgGmJHs9iIwth4i
         hE9etHxwDyXaCgNuRK0UgPdm0LYUeVhtdd7NkrJiCAf52Ayd/F7Gv98IED2p46mZsCci
         WgiQ==
X-Received: by 10.66.162.137 with SMTP id ya9mr45121226pab.11.1439407640390;
        Wed, 12 Aug 2015 12:27:20 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:755f:3d29:a826:eda6])
        by smtp.gmail.com with ESMTPSA id an10sm263414pad.5.2015.08.12.12.27.19
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 12 Aug 2015 12:27:19 -0700 (PDT)
In-Reply-To: <1439406838-6290-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Wed, 12 Aug 2015 12:13:56 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275803>

Stefan Beller <sbeller@google.com> writes:

> However just as I was convinced of my review and sent out the email, I started
> working with it. And I found nits which I'd ask you to squash into the round or
> put on top.

Good ;-).  I'd prefer a full reroll, as it has been quite a while
since v5 was originally posted, once you get to a reasonable state
where you are reasonably confident that you won't find more of such
nits.  Hopefully more people might have eyes on the list to review
and comment this round.

Thanks.
