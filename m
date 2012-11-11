From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v5 11/15] remote-testgit: make clear the 'done' feature
Date: Sun, 11 Nov 2012 22:22:09 +0100
Message-ID: <CAMP44s0o1eP+aeT0AHu4uP1NPLqJq56qUDb-+F_x5NjoJCnf+A@mail.gmail.com>
References: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com>
	<1352642392-28387-12-git-send-email-felipe.contreras@gmail.com>
	<29291552-880A-4FEB-88E0-A73A1C7742F7@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pete Wyckoff <pw@padd.com>, Ben Walton <bdwalton@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Sun Nov 11 22:22:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXez3-0007k6-6B
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 22:22:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752027Ab2KKVWL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 16:22:11 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:60360 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751852Ab2KKVWK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Nov 2012 16:22:10 -0500
Received: by mail-ob0-f174.google.com with SMTP id uo13so5642144obb.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 13:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=5P25uatYCFqFSxEW1z0wzt8j5Yw5yjv2vVW6giUwL88=;
        b=YtS0AzN2GLLCYe/0cA16tOooieN8OZwCAwgJjz5ZcpQgRZP9q8r+xSEuXFYLnMSDkU
         UBn2ZYez2WL4MBr0ZRYU//RZDl+67I9DZdacg+LEJUdpYORMKZlUM7P36uTk/AkinXbH
         6kQ3gB71XlP1X7CQ5AsMcU+J3tLsIUS3hg8MX/Ytyv12uVMJy38Bsd0BLsLPO+ZKkLaI
         io+R/uKZYdGvO/SjPLdPGn/hL7jPYCAzvwDRyeb5EKRYEr0bWZfzcMSnRN30qnqJNgtB
         VKH8+ph2+xdEiLbe2cF9RKCX6ndoHb93B8f54U6xb/CTIBbeRB9oEAo7dha1oSmlMX80
         5O8g==
Received: by 10.60.1.163 with SMTP id 3mr12871572oen.30.1352668929975; Sun, 11
 Nov 2012 13:22:09 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Sun, 11 Nov 2012 13:22:09 -0800 (PST)
In-Reply-To: <29291552-880A-4FEB-88E0-A73A1C7742F7@quendi.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209449>

On Sun, Nov 11, 2012 at 9:49 PM, Max Horn <max@quendi.de> wrote:
>
> On 11.11.2012, at 14:59, Felipe Contreras wrote:
>
>> People seeking for reference would find it useful.
>
> Hm, I don't understand this commit message. Probably means I am j git fast-export --use-done-featureust too dumb, but since I am one of those people who would likely be seeking for reference, I would really appreciate if it could clarified. Like, for example, I don't see how the patch below makes anything "clear", it just seems to change the "import" command of git-remote-testgit to make use of the 'done' feature?

No, the done feature was there already, but not so visible: git
fast-export --use-done-feature <-there. Which is the problem, it's too
easy to miss, therefore the need to make it clear.

> Perhaps the idea of the patch is to make use of the "done" feature so that remote-testgit acts as "reference implementation"? If that is the intention, then perhaps this could be used as commit message:

It's already there.

>   remote-testgit: make use of the 'done' feature
>
>   This might be helpful for people who would like to see how to properly
>   implement the "done" feature.

Everybody should implement the 'done' feature. Otherwise random error
messages quite easily appear.

-- 
Felipe Contreras
