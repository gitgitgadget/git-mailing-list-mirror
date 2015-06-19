From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] format-patch: introduce format.outputDirectory configuration
Date: Fri, 19 Jun 2015 11:14:34 -0700
Message-ID: <xmqqwpyz8t11.fsf@gitster.dls.corp.google.com>
References: <1434626280-4610-1-git-send-email-kuleshovmail@gmail.com>
	<xmqq616ley7y.fsf@gitster.dls.corp.google.com>
	<20150618195751.GA14550@peff.net>
	<xmqqoakceq8s.fsf@gitster.dls.corp.google.com>
	<xmqqk2v0eq75.fsf@gitster.dls.corp.google.com>
	<20150618201323.GB14550@peff.net> <20150618202205.GA16517@peff.net>
	<xmqqd20sd70j.fsf@gitster.dls.corp.google.com>
	<CANCZXo72BscpXKGAtVPt_1QuffcOpTz6nGB+__q0JLisuTaKsQ@mail.gmail.com>
	<xmqq616jbse8.fsf@gitster.dls.corp.google.com>
	<CANCZXo5Nyt+JePQP=kvFsjTaV=xKXduoBqAwp5E0CrEf13QK7g@mail.gmail.com>
	<CANCZXo7Lyo_Sb=bxF9EgZHV35JfrQZ-CFsM9T4yUjkDBndcp8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 19 20:14:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z60oO-0006Kq-SS
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 20:14:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753602AbbFSSOi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 14:14:38 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:37524 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753241AbbFSSOg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 14:14:36 -0400
Received: by igblr2 with SMTP id lr2so18624640igb.0
        for <git@vger.kernel.org>; Fri, 19 Jun 2015 11:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=R9aPGqkZQyhxPbwrZrTIxhKeHXNjkdesNshvRfPTPIo=;
        b=vcog8XD1YkkQ6usSsnm79iKD/gQZgH8B8ja6F/H5jaCknESokQmY+AJtso//KoBUCl
         yOgaxdW2yj2IeBxMf3XnLb7GdvGc/KXM0meWqt3RzUO3X/U+vyBk/c/b7uW3Zbgxv9l0
         iKJjrLZTpokebs2vJgSXiJNdS+KMEA8Srab26t47jrpi2ynCTceiVBPn+5wcs6t9TagY
         zVlnoesnCMD+X3ECKYOhDBRmRDyWNs3ke6iDbItMDaJUZWYXyraF6LzJv4borN4/RtbC
         ZU6Xew3ESsVzA/CIbT5Xb4zNGBKNLDOLMN1NAWoQFAZ0XLDoSKHCJW8KklaoZcpt8Fzh
         +m1A==
X-Received: by 10.50.117.105 with SMTP id kd9mr6352403igb.31.1434737675939;
        Fri, 19 Jun 2015 11:14:35 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:80a8:63af:ca7c:ab61])
        by mx.google.com with ESMTPSA id f15sm7511463iof.36.2015.06.19.11.14.35
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Jun 2015 11:14:35 -0700 (PDT)
In-Reply-To: <CANCZXo7Lyo_Sb=bxF9EgZHV35JfrQZ-CFsM9T4yUjkDBndcp8A@mail.gmail.com>
	(Alexander Kuleshov's message of "Fri, 19 Jun 2015 23:27:20 +0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272176>

Alexander Kuleshov <kuleshovmail@gmail.com> writes:

> Ah, you mean to put this check before.

I am fuzzy what you mean "before" (or "after"); the "how about doing
it this way instead?" patch we are discussing is to replace the
change you did in your original, so if you apply it you would know
what addition goes to where ;-)
