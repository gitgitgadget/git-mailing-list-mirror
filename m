From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] diff --follow: do call diffcore_std() as necessary
Date: Fri, 13 Aug 2010 21:27:38 +0000
Message-ID: <AANLkTin-qPe-meW_kV5vtC0BT8QS-sZ90BrckRAbjk9X@mail.gmail.com>
References: <AANLkTikPhWgeeLBV3dbLZ5UM3UDmkOmpqrmwqPmGfn7Z@mail.gmail.com>
	<7vhbiyl8ji.fsf@alter.siamese.dyndns.org>
	<7vpqxmjphl.fsf@alter.siamese.dyndns.org>
	<7veie2jnww.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Bo Yang <struggleyb.nku@gmail.com>,
	Constantine Plotnikov <constantine.plotnikov@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 13 23:28:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ok1nA-0005JO-GG
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 23:27:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753507Ab0HMV1p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Aug 2010 17:27:45 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37308 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753225Ab0HMV1o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Aug 2010 17:27:44 -0400
Received: by iwn7 with SMTP id 7so199675iwn.19
        for <git@vger.kernel.org>; Fri, 13 Aug 2010 14:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=K6oaIZIBksYmz5pUXMbPF5vB8SzP1qOB/2NEidvAz5A=;
        b=x5JSRxdtvxJ5Jv2iCky1ctM2gCI9gNR5ZQPpjgkyc2xWcBt+qtYpmjJDcx2mOpwJ/Z
         QR4KVu0PI7FTX8g7LaQOP82DZviTLn9fwPypV8wY0wMlENCVNzuWjSZJArjtwRhTCo4b
         JM+IAbQOt0wP9IFgbAbhvEVYvSDTo+/3fTOaE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=PRtF65IqokW3smx1otMRMACNHPWp3wC7puOzutsWhGZulDqenL+k6l/iMH/0PrSW9Q
         1WVcPaUAOQARdp+kkL6bGZnrBuItVTSyr6g0QHmSnvKfhg/Cdz+GEmTHrkV2fzN8XtEc
         F1aSdlRvSc9A14O6YFIv0vTgpY9hHD5M4c96s=
Received: by 10.231.152.78 with SMTP id f14mr2361970ibw.60.1281734859003; Fri,
 13 Aug 2010 14:27:39 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Fri, 13 Aug 2010 14:27:38 -0700 (PDT)
In-Reply-To: <7veie2jnww.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153509>

On Fri, Aug 13, 2010 at 19:46, Junio C Hamano <gitster@pobox.com> wrote:

> This hopefully fixes the breakage.

Hopefully. It'd also be nice if we had a regression test for this, but
I don't know how hard that would be to arrange. If it's hard to
reproduce we might get away with a filter-branch + subdir filter from
the idea repository.
