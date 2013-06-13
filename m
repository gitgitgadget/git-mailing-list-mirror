From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/4] push: make upstream, simple work with pushdefault
Date: Thu, 13 Jun 2013 23:15:31 +0530
Message-ID: <CALkWK0kx=NRzYpDmr-PeswZi=eYYzycqc19phfpwsgnbOb1PZQ@mail.gmail.com>
References: <1370798000-2358-1-git-send-email-artagnon@gmail.com>
 <1370798000-2358-3-git-send-email-artagnon@gmail.com> <7vip1moq3k.fsf@alter.siamese.dyndns.org>
 <CALkWK0mesZay8Cpi6yTvhUG=136=9JLyFUZXm8t_fMOrY0F62Q@mail.gmail.com>
 <7v4nd6l31d.fsf@alter.siamese.dyndns.org> <CALkWK0mY5=H6FoUZCOXTYykEV1f=3wrP21WPXj1v4VBCeOxocg@mail.gmail.com>
 <7vwqq2j7c9.fsf@alter.siamese.dyndns.org> <CALkWK0mfWs3LBocvn=QMcX0_ZCROx4Nw=+xjpCbKLQU0JzSdXg@mail.gmail.com>
 <7vobbdhjeg.fsf@alter.siamese.dyndns.org> <CALkWK0mDDKETE1O=g7X5s5MJvU7UA_NQiMNESor_8=phW0WR-A@mail.gmail.com>
 <7vehc6vtvt.fsf@alter.siamese.dyndns.org> <7vk3lxvrj0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Leandro Lucarella <leandro.lucarella@sociomantic.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 13 19:46:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnBbF-0008Hd-OF
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 19:46:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758843Ab3FMRqN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 13:46:13 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:48590 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756078Ab3FMRqM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 13:46:12 -0400
Received: by mail-ie0-f171.google.com with SMTP id qd12so12767771ieb.30
        for <git@vger.kernel.org>; Thu, 13 Jun 2013 10:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Oo0b2FrIJ9Ut6VAnu4k65ZE7uwqYaZGoD/a+WeZwQbY=;
        b=Vs3RUxV5HqadwsLQ72M/NJI01mXCWOKjrYE+KTi1J8t9ZD/ACm/rxzmrFWE7if8oXS
         9Rwb1C2xxMWIwLaoH7sZQjBWDcUTCTCHQoThd7GPiyeyAr5RjzLQQv5zitvnuHsxVtOv
         QpJ5RfOHyCf9JuXsxC8WQ6nrzC3+ZkKSYlontFsRjOpL3QFaHgpBSXZd82otTAK8cqAZ
         QmKswRsINeSGlU2FeSoOHDv74+6SMRfu5tUduyf/1nUVmgxrrxrKnyS0EFTaKASSfBwF
         PUTFxsKFR16m4fRk+fzuQ5lpzOKew1uBampQl13wx+MW4EOJ5EfcZqaZbHxTh1MJCaXY
         OxeQ==
X-Received: by 10.50.56.20 with SMTP id w20mr5991077igp.40.1371145572531; Thu,
 13 Jun 2013 10:46:12 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Thu, 13 Jun 2013 10:45:31 -0700 (PDT)
In-Reply-To: <7vk3lxvrj0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227754>

Junio C Hamano wrote:
> Did you mean "I'm still resisting, but after reading [...] I think
> it makes sense"?  If so, please discard my question.

Sorry about the lack of clarity.  I agreed with most of what you said,
and I outlined how we could possibly turn it into an implementation.
Still haven't found a solution.
