From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: Git log three-dot notation: include merge base
Date: Sat, 14 May 2016 18:32:39 -0500
Message-ID: <CAHd499D2ci-8WKh=sCGdoy_Ry7aCw+TxD_Rp7QWiUpg9Qu=nmA@mail.gmail.com>
References: <CAHd499A_AN0U7gj8Yp0pBGGZ6deNrDJ4F4npAKy6a2U0+uTsxg@mail.gmail.com>
	<xmqqbn486wv3.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 15 01:33:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1j3G-0002Pi-ET
	for gcvg-git-2@plane.gmane.org; Sun, 15 May 2016 01:32:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753978AbcENXck (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 May 2016 19:32:40 -0400
Received: from mail-vk0-f51.google.com ([209.85.213.51]:36549 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753913AbcENXck (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2016 19:32:40 -0400
Received: by mail-vk0-f51.google.com with SMTP id s184so176462738vkb.3
        for <git@vger.kernel.org>; Sat, 14 May 2016 16:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=sQBQ9XpDPs2Di+hkAYjrNAiwzFBI+8N6hEwtoxJUw8E=;
        b=tny4Qs3oDbu/GjCFNl2reUajDQxk8D9uZ9RlY9CUrB+b06R37v+4KAHEyKMsmdCYb+
         YszwksKXTccqGQYHDhGU7NykGqviW5BDn0dbnQrYsuNKa6hkSWVQCJPeAVrqWfPb4oEQ
         LTIN/iHi+alvmlZOsYnnE9ua0LbPROLtNN92dgsNKXKWBgNyBc5vDS8GUIc1CITcLP0x
         G6jur7k9Addgv+bBeIEzeeC0MxWPTJQFERAgzQ6f3O4vLfmKkORIuPUBklC6xOnzCdyi
         vWC+AzrESoCUJyIlRZtVPGYfwqfAv1eqzYbWwfNOxz0/33yLM9ZuUdsgQzKv93OChmTT
         3QZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=sQBQ9XpDPs2Di+hkAYjrNAiwzFBI+8N6hEwtoxJUw8E=;
        b=mB8OON4buFB0/BN18CyYrA4TFDLZ7bb862buXS9dVNdcMvB2OHJqUMLGW7kEVeJEZx
         3bbIYd1vsG1FxDnuLEo9IiFK0gED2z2XZgvQBkyfg2QNnAhHvgtVz9KlI+eTqXIGpyaD
         RGAD+pGC0DsVRKfH7Fbu7Kk1nGSCtsP1WGyGr1Fgcy8FdpUCAEFHD8UKPmxfQeUs2z4W
         AnB3gTLq0RjKWfj+q8ltVW3xpkp1O2+cLFLi3+M+ptr8/ZV9ZM/clKiqDK9VriFJqVDL
         u8tbP894mE/yD5SDmUS/+ztiEXvCB/+JZXbkoYXIeVswdDcywtd1jIP6UGEz8IDXPMNt
         MmOQ==
X-Gm-Message-State: AOPr4FUqcfw1wNz8jVTkTBNEm4Q+FYgsvX83jfwCSeiT/5n90nUUbUTl2/UXdLrNFpzigei3KHQM2yxJ4IKQsw==
X-Received: by 10.176.2.171 with SMTP id 40mr11521341uah.5.1463268759252; Sat,
 14 May 2016 16:32:39 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.159.34.134 with HTTP; Sat, 14 May 2016 16:32:39 -0700 (PDT)
In-Reply-To: <xmqqbn486wv3.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: IpdLf1z-laFZ8iHaogUMt4WXBTs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294632>

On Sat, May 14, 2016 at 6:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Robert Dailey <rcdailey.lists@gmail.com> writes:
>
>> This is because the merge base commit isn't shown. I understand this
>> is "by-design", but is there a way to include it? It's necessary to
>> have it, for this graph to make sense.
>
> --boundary, perhaps?

Big thanks to both you and Jeff. I figured there was some option for
this, but I always have trouble finding what I need in the
documentation sea of git log :-)

This worked perfectly. Much appreciated!!!
