From: Ping Yin <pkufranky@gmail.com>
Subject: Re: Summary of the problems with git pull
Date: Wed, 7 May 2014 18:39:01 +0800
Message-ID: <CACSwcnQDtf5pE2Uoab68ZmQ-1K9MWTZaR_b7qExDd2myY8h+kg@mail.gmail.com>
References: <5366db742d494_18f9e4b308aa@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git mailing list <git@vger.kernel.org>,
	"W. Trevor King" <wking@tremily.us>,
	Philip Oakley <philipoakley@iee.org>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Richard Hansen <rhansen@bbn.com>, Andreas Krey <a.krey@gmx.de>,
	Marat Radchenko <marat@slonopotamus.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 07 12:39:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhzFo-0005QS-VA
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 12:39:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbaEGKjG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 06:39:06 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:49708 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932180AbaEGKjD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 06:39:03 -0400
Received: by mail-wi0-f179.google.com with SMTP id bs8so1060672wib.12
        for <git@vger.kernel.org>; Wed, 07 May 2014 03:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=X1IUko4Ormu13CZZv/WCcQbbY7YgQFpc1VTM5zyjr0E=;
        b=wpIpDurCLZM7Gp4PO6DxdECGqPEUTAdCX8Zegu1g1nkvNBF1rl+8Khx7GLu4oCifIG
         upFA2bveqyI9CrTzsr6ieK7tEw6hQ8Apeb08+bki4h86JvFYscFrinDMHWyN5x9/D1/B
         BIlPHEMWJ7kgNOWPF6V/BQM9b3RwL2o3H5IBuwtI9GKWujiJJ2QWMulFXlGJSlbX4D1h
         RNkvymdnPTWXoTqy0ks0hxN+Zw1vo89TUvH+LgWe6UJnB7vgsK2u5Yc0YHUdIhrIvfeW
         DpPiDfzWkXDO+waoeqqvDMCFRz7FUZa1eVyrNE7AyqnqcphvExNRdwgToL2Op497nCSY
         c6FA==
X-Received: by 10.180.185.100 with SMTP id fb4mr25583307wic.11.1399459141767;
 Wed, 07 May 2014 03:39:01 -0700 (PDT)
Received: by 10.227.0.130 with HTTP; Wed, 7 May 2014 03:39:01 -0700 (PDT)
In-Reply-To: <5366db742d494_18f9e4b308aa@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248295>

Ping Yin


On Mon, May 5, 2014 at 8:29 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Hi,
>
> == git update ==
>
> Another proposed solution is to have a new command: `git update`. This
> command would be similar to `git pull --ff-only` by default, but it
> could be configured to do merges instead, and when doing so in reverse.
>
+1 for git update
