From: Michael Witten <mfwitten@gmail.com>
Subject: Re: 'git gc --aggressive' effectively unusable
Date: Sat, 3 Apr 2010 15:42:41 -0600
Message-ID: <g2kb4087cc51004031442jb2d825casc0b66454490288a@mail.gmail.com>
References: <201004030005.35737.elendil@planet.nl> <p2gb4087cc51004031433xc57e52bbq733d1d3c5f37f238@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
X-From: git-owner@vger.kernel.org Sat Apr 03 23:43:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyB7Y-00011s-DH
	for gcvg-git-2@lo.gmane.org; Sat, 03 Apr 2010 23:43:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756044Ab0DCVnF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Apr 2010 17:43:05 -0400
Received: from mail-fx0-f223.google.com ([209.85.220.223]:56816 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756042Ab0DCVnD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Apr 2010 17:43:03 -0400
Received: by fxm23 with SMTP id 23so2137041fxm.21
        for <git@vger.kernel.org>; Sat, 03 Apr 2010 14:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=bMX7F+TqyEL/4KYWAnthOGvmb5/4dhDQU5SaaO6UYDk=;
        b=GDvYLOagFGS0VKUU7cFUH+QGtTGqGoZCVLGeu75YqLnvBxTVxUp0+mvhvQLzv19xpu
         LlUyzAdH2b5/Got/Sp7KvocHXz8uSeEjd2VcYrXq9DfH1FUMZ6ORpONCqYfVG2p96AHs
         2EGrqiWsKgp3iZKmz+ChZ+Rc5D7rYrf4bRQEs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Cws+e29JWCs12djRqIpPiJ4Hn62XQtuwAZDImrHVYORUV+GoclTI8r0qikJQPz4wBL
         kS20e2LCtTine/kmIkHYWBKdwR1bI8Zt4nBduWt/JoQK6f9KniGYZm6pxE1lSQsRZrjY
         sy8u3h1zqdOFMKV+/iDMHuhb89NkDjqisPN88=
Received: by 10.239.133.140 with HTTP; Sat, 3 Apr 2010 14:42:41 -0700 (PDT)
In-Reply-To: <p2gb4087cc51004031433xc57e52bbq733d1d3c5f37f238@mail.gmail.com>
Received: by 10.239.185.81 with SMTP id b17mr339893hbh.191.1270330981147; Sat, 
	03 Apr 2010 14:43:01 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143905>

On Sat, Apr 3, 2010 at 15:33, Michael Witten <mfwitten@gmail.com> wrote:
> $ git help gc | sed -n /--aggressive$/,+3p

As an aside: I didn't realize I copied that in there; this would
probably be better:

$ git help gc | sed -n /--aggressive$/,/^$/p
