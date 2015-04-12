From: "Yi, EungJun" <semtlenori@gmail.com>
Subject: Re: How to send a warning message from git hosting server?
Date: Sun, 12 Apr 2015 20:25:47 +0900
Message-ID: <CAFT+Tg9La03dkteQT0YOPPKdR78w89385VfOGN2B9kLGPo7Kcg@mail.gmail.com>
References: <CAFT+Tg-Gwr9EemFv88+=Ao21dGYe73D-CDiT4mXU4kuP-niOSw@mail.gmail.com>
	<alpine.LSU.2.00.1504081206420.10193@hermes-1.csi.cam.ac.uk>
Reply-To: semtlenori@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Tony Finch <dot@dotat.at>
X-From: git-owner@vger.kernel.org Sun Apr 12 13:25:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YhG1S-0003Va-0z
	for gcvg-git-2@plane.gmane.org; Sun, 12 Apr 2015 13:25:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbbDLLZs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Apr 2015 07:25:48 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:34917 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751337AbbDLLZs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Apr 2015 07:25:48 -0400
Received: by qkhg7 with SMTP id g7so122128620qkh.2
        for <git@vger.kernel.org>; Sun, 12 Apr 2015 04:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=dv/nPckkyPZ9xCNcJVj4XiZ3DK7u8fUb3xwV+hPQk4U=;
        b=C4sKN/vmAozvZziXsEhcDGzm9gXK8sbKjnpTVN9K84oi4hexL1/eCj0Q71FngTpgeW
         yLF5VgteaDx7TxzlzQ7X/GaIvEgRqqb93UhUWPKHGXwMZCFfKbmWhShziyUil905m9U5
         qpXqoLtZJ6VG075Z7xTPYXoKfuTTpdkMeCrO8hjIlhdrkwdL6vPwEn7rAVUD16C2tU41
         l9fqbdY/5u7XRQwA1oVCBBHQo1vfbyMDqKIl2tKzA/nWAacng3k99e638eP2nCkI3ggg
         wKt4pdsP/DC3InsJK1Cvcl4MOPu+sVww0oSovin05byIQoAZvwaf6jDzyHvOl67RtaQo
         z1Vw==
X-Received: by 10.55.33.94 with SMTP id h91mr19197804qkh.69.1428837947214;
 Sun, 12 Apr 2015 04:25:47 -0700 (PDT)
Received: by 10.140.105.161 with HTTP; Sun, 12 Apr 2015 04:25:47 -0700 (PDT)
In-Reply-To: <alpine.LSU.2.00.1504081206420.10193@hermes-1.csi.cam.ac.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267049>

On Wed, Apr 8, 2015 at 8:08 PM, Tony Finch <dot@dotat.at> wrote:
> Yi, EungJun <semtlenori@gmail.com> wrote:
>>
>> I want a way to response a remote message when a client send any kind
>> of request. Is it possible?
>
> Yes, though you need a wrapper around git. Recent versions of gitolite
> have a "motd" message of the day feature.

It sounds nice. Is the wrapper for git client or git server?
