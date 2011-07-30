From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 16/18] revert: Remove sequencer state when no commits are
 pending
Date: Sat, 30 Jul 2011 16:48:17 +0200
Message-ID: <20110730144817.GC7043@elie>
References: <20110727051755.GK18470@elie>
 <CALkWK0noPtLgr_t=DC_XFdLrWUNCLhUd00Mw1HbmWRJjeT4jew@mail.gmail.com>
 <20110727141006.GA24785@elie>
 <CALkWK0k8Lra7LkGJXoXScnGUjrag-xgNptaB_JCiAsgemTq0eQ@mail.gmail.com>
 <20110727154830.GA29924@elie>
 <CALkWK0mUGiCRQoW6UM+mF5tsn4DxRuaiXn0TS2CcEsR0OeusKg@mail.gmail.com>
 <20110729191654.GA2368@elie.dc0b.debconf.org>
 <CALkWK0=qXBteRjj5vXDEWGVausQ3ssOvy4hyHHz84ORFzDaHaQ@mail.gmail.com>
 <20110730131050.GA4848@elie>
 <CALkWK0=9kwgtZB-BA12tOQrQXS8XRbhTg6K=Ak00o2nurX16Fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 30 16:48:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnAq8-0005NC-Ex
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jul 2011 16:48:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519Ab1G3Os2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jul 2011 10:48:28 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:35919 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090Ab1G3Os1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2011 10:48:27 -0400
Received: by fxh19 with SMTP id 19so3139212fxh.19
        for <git@vger.kernel.org>; Sat, 30 Jul 2011 07:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=pAvjG/r+uOV8sElY94AykvLWG1fUYG7N2hYtqEijfWc=;
        b=LqEHAXFsNlufNtebhIMJVnaZbfm6ksRTq9mD4PWhnZ9Pdq9nCb4L5ttVm1cNCph7x/
         oaRCnMNpupb/d6VJPqtQWbu2Irkdzh9XoIx7tOIATTlFurtRNy3DY5DzU/fj2sduqdQY
         yUQWfJhiSwBX7+D8eU2/6eZa5o1iniNn7zWk0=
Received: by 10.223.15.141 with SMTP id k13mr3469002faa.118.1312037305827;
        Sat, 30 Jul 2011 07:48:25 -0700 (PDT)
Received: from elie (adsl-165-161-90.teol.net [109.165.161.90])
        by mx.google.com with ESMTPS id q5sm1726961fah.30.2011.07.30.07.48.24
        (version=SSLv3 cipher=OTHER);
        Sat, 30 Jul 2011 07:48:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0=9kwgtZB-BA12tOQrQXS8XRbhTg6K=Ak00o2nurX16Fg@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178203>

Ramkumar Ramachandra wrote:

> Long story short: I'd like it if we could bear with this slight
> annoyance (removal of sequencer state when one commit is pending) and
> get the series merged, so that I can work on a series to improve the
> experience based on this series.

Thanks for explaining.  It's not a regression, so fwiw
Acked-by: Jonathan Nieder <jrnieder@gmail.com>

If you are preparing a reroll, please do explain this a little in the
log message.
