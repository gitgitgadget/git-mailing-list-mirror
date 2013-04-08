From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Remote helpers and signed tags
Date: Sun, 7 Apr 2013 17:02:48 -0700
Message-ID: <CAGdFq_g+kk-Fy1fcV6D5x4kroRXX63T8wjKNUqqfu39wUkSO6A@mail.gmail.com>
References: <20130407103418.GT2222@serenity.lan> <20130407214626.GC19857@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Keeping <john@keeping.me.uk>, Git List <git@vger.kernel.org>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 08 08:48:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UP5ri-0000sy-Cz
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 08:47:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934643Ab3DHAD3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 20:03:29 -0400
Received: from mail-ia0-f171.google.com ([209.85.210.171]:44788 "EHLO
	mail-ia0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757616Ab3DHAD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 20:03:28 -0400
Received: by mail-ia0-f171.google.com with SMTP id x2so222276iad.16
        for <git@vger.kernel.org>; Sun, 07 Apr 2013 17:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=UtW+0u0P8zbAMMuQUparnGha+JPYiqwaFl13bk4QsmQ=;
        b=m344XpfMKwb0dtiOM8EvRwU5lUnFMMDy0KMkTAIDnnv7U9QW+b3o2DB6z+64spoQSW
         97WLJ1CfLTNXFcQXZfkQDrp55KWlAtDr7qdY+pUAsJj8c5XzEl4egtlqwW7zKJfL4LYH
         9p/qWEjJglCDA67YBfYyV87GoDeklTzq+vPeEHkTLP9h0QUiTMJFNvE2KN1ISsT0BSqG
         KKjlX8ARX1RtpkXL7HvQp5kwOgBsb5jbxPIOBxcatE3Ml2DQRAgmk/afNm0EUV9avAnr
         GJo1BavpVlvBFQk2Jz0e3jG7e/dZ92f3BHkqA82D1JT5MHDlqHGTd++GJ0wC2Ec8MkrT
         fRZw==
X-Received: by 10.50.6.202 with SMTP id d10mr5150503iga.28.1365379408349; Sun,
 07 Apr 2013 17:03:28 -0700 (PDT)
Received: by 10.50.157.229 with HTTP; Sun, 7 Apr 2013 17:02:48 -0700 (PDT)
In-Reply-To: <20130407214626.GC19857@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220389>

On Sun, Apr 7, 2013 at 2:46 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> The remote helper infrastructure is certainly being unhelpful here.  I
> wonder if transport-helper should just pass --signed-tag=strip and be
> done with it (leaving open the possibility of a capability to switch
> to --signed-tag=verbatim when someone wants to teach the testgit
> helper to support that).  What do you think?

I think that's (at least for now) the right thing to do. Passing
anything but signed-tag=strip should be triggered by a capability from
the helper, since most helpers won't know how to deal with signed
tags.

--
Cheers,

Sverre Rabbelier
