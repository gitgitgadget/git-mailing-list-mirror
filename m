From: Atousa Duprat <atousa.p@gmail.com>
Subject: Re: [PATCH] Limit the size of the data block passed to SHA1_Update()
Date: Sat, 31 Oct 2015 23:37:02 -0700
Message-ID: <CA+izobt11C=0hSkW6tivjRDPfbVij9-KOuhikisXrG6PWgMAjA@mail.gmail.com>
References: <CA+izobsBmYHHepYka795K2VnVLYBmN2tFqEyzSweMoS9gvuRVw@mail.gmail.com>
	<1446243500-21580-1-git-send-email-apahlevan@ieee.org>
	<015b01d11362$0b8c1e70$22a45b50$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Atousa Pahlevan Duprat <apahlevan@ieee.org>
To: "Randall S. Becker" <rsbecker@nexbridge.com>
X-From: git-owner@vger.kernel.org Sun Nov 01 07:37:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsmGL-0000ac-NW
	for gcvg-git-2@plane.gmane.org; Sun, 01 Nov 2015 07:37:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751887AbbKAGhF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2015 01:37:05 -0500
Received: from mail-yk0-f169.google.com ([209.85.160.169]:35881 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750830AbbKAGhE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2015 01:37:04 -0500
Received: by ykba4 with SMTP id a4so112406319ykb.3
        for <git@vger.kernel.org>; Sat, 31 Oct 2015 23:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=T0RtofTwm0MN8d63fU4g23TuV8vOB0PDbxNRR/lVTNg=;
        b=JdgnAi0XvW+iCgByyzskUCYq2GA5vvYUBu2guA9k92TvumGotCltv+f/hsdeSBekGR
         06bGq5hJ26U7F8bzXEDEWTxJOes7kaNHhNwYLeotyCjY7nU98nJ+/cvh5E//SPYeRCQh
         W5nn/3XPBRv8zFvgD4Zb5CW02hxXKGOsBc3YdYQjX4jTPeWmX4Dbr6kRqyEmjMP5qPY/
         5AVe1GVejcrLs3T4sRSUI8H5W1McURuoezBGWsUwdUqVTtXpe/jPuzBuP+qwyNTxh8qI
         bk0glAGBf8dV8muOlUmFZ4aHpQ2vJcHuLceyjmfY/2BX2VMnY5/WVFSrTqyLj0b14YO9
         Vkhw==
X-Received: by 10.129.146.205 with SMTP id j196mr13521832ywg.71.1446359822859;
 Sat, 31 Oct 2015 23:37:02 -0700 (PDT)
Received: by 10.37.91.198 with HTTP; Sat, 31 Oct 2015 23:37:02 -0700 (PDT)
In-Reply-To: <015b01d11362$0b8c1e70$22a45b50$@com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280608>

> Didn't we have this same issue with NonStop port about a year ago and
> decided to provision this through the configure script?

I'll be happy to look at it.  Can you point me to the right email
thread or location in the configure.ac file?

Atousa
