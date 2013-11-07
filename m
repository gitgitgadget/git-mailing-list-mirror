From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [ANNOUNCE] Git v1.8.5-rc1
Date: Thu, 7 Nov 2013 10:31:40 +0100
Message-ID: <CAP8UFD0faEZNU0A+r8eQTSKH84QqrT2wdeLWkGWx+NvoucKG5w@mail.gmail.com>
References: <xmqqbo1x6q32.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 07 10:31:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeLwK-0005QQ-80
	for gcvg-git-2@plane.gmane.org; Thu, 07 Nov 2013 10:31:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753651Ab3KGJbo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Nov 2013 04:31:44 -0500
Received: from mail-ve0-f173.google.com ([209.85.128.173]:64037 "EHLO
	mail-ve0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753239Ab3KGJbm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Nov 2013 04:31:42 -0500
Received: by mail-ve0-f173.google.com with SMTP id c14so63539vea.4
        for <multiple recipients>; Thu, 07 Nov 2013 01:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=gWHxzDDz0mej0svOJNdRTcLJUKSUvsA8kidcr+p6bH4=;
        b=nN94uVl/epTTJjhtkWW06wJeWJMxrTbGK8NppAj+8WnjWf/sK0KVVIQo9pNHcqinAg
         XFZbipp1khaxicv6sdASLzInIUEguzidtaiD9nnCsblLZOJyVZ3fE4YBjoNYY6v7ZniQ
         aZk3yKmIiCBsENFbvqlotzKHjmPwzqJYvicOLAQ/gvXfyPx1vMxWxYzSwGYG18SDGFtY
         Oe0j0XKE5cxwWRhTzNwUCk/72oC7OyjzJf+sSYXU54epgc5AznwH3iH/aMuzSfioGjmA
         0lFWhTTWo8rYsNMDheRI8nIwRxcjfNSke1TFTZ779NR9BdEnwF+C5MfZInU8usjawPML
         CjjQ==
X-Received: by 10.220.199.5 with SMTP id eq5mr6031631vcb.16.1383816701054;
 Thu, 07 Nov 2013 01:31:41 -0800 (PST)
Received: by 10.58.253.136 with HTTP; Thu, 7 Nov 2013 01:31:40 -0800 (PST)
In-Reply-To: <xmqqbo1x6q32.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237392>

On Thu, Nov 7, 2013 at 12:57 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
>  * "git replace" helper no longer allows an object to be replaced with
>    another object of a different type to avoid confusion (you can
>    still manually craft such replacement using "git update-ref", as an
>    escape hatch).

Maybe it would be more helpful to say "you can still do that using the
--force option" instead of pointing people to "git update-ref".

Thanks,
Christian.
