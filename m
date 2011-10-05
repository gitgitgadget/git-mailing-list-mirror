From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [RFC/PATCH] Add multiple workdir support to branch/checkout
Date: Wed, 5 Oct 2011 15:14:08 -0400
Message-ID: <CAG+J_DxqW5J01VNe7c86SMSZPWuz=cuFJm4PaeOvr4dnQryrwQ@mail.gmail.com>
References: <1317786204-57335-1-git-send-email-jaysoffian@gmail.com>
	<CACsJy8AqYq+YF+rvUp=BBeFUAtUz783iF2jbUp3fO58yLp9ptQ@mail.gmail.com>
	<CAG+J_DygQTD5ibco=-NOiKg0BLgBGFJnvV8zPyhngC2iZv_H8g@mail.gmail.com>
	<7vpqib8jzk.fsf@alter.siamese.dyndns.org>
	<CAG+J_Dz-GXvRbYUXSoyfyHfOO-_BszcOza9x=ysHhmL5YBW-Jw@mail.gmail.com>
	<7vzkhf713u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 05 21:14:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBWv1-0002OX-PL
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 21:14:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934427Ab1JETOK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Oct 2011 15:14:10 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:63352 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934227Ab1JETOI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 15:14:08 -0400
Received: by ywb5 with SMTP id 5so1888497ywb.19
        for <git@vger.kernel.org>; Wed, 05 Oct 2011 12:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=BpLMvaheWuCGP3b/QpvLejlHz3u+wPlH8gGMecfTc7Y=;
        b=pdUpGsX68WUQOJVF4SjZk2VdC7kw0S4KZalAriyMP11LIxRsAz1JPNFeVkI/78BOjW
         Fw/EqcYMJea6mlaow9h6b+TW0rfBFLgMxFnVKMmTI6PPct9em1aVWBEIhWKUqDufe8RB
         eCr7g/+wNUPj/v/UBXhralnBfBkjkcJfJAkSk=
Received: by 10.147.5.21 with SMTP id h21mr2385863yai.26.1317842048340; Wed,
 05 Oct 2011 12:14:08 -0700 (PDT)
Received: by 10.147.32.18 with HTTP; Wed, 5 Oct 2011 12:14:08 -0700 (PDT)
In-Reply-To: <7vzkhf713u.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182878>

Aside, previous discussion -
http://thread.gmane.org/gmane.comp.version-control.git/150559

Sadly, it seems to have petered out, it looks to me like a case of
perfect being the enemy of the good. I'm really just trying to make it
good enough that we can move new-workdir out of contrib. It's a
valuable tool, we just need to remove some of its sharper edges.

j.
