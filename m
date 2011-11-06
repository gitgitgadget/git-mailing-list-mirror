From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] Introduce commit.verbose config option
Date: Sun, 6 Nov 2011 09:51:51 +0700
Message-ID: <CACsJy8BzAMR17GKxvUrG7Svbum7Xn=+ytBDyu05Nh9f3duHu-w@mail.gmail.com>
References: <20111105182339.27C069004A@inscatolati.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Fernando Vezzosi <buccia@repnz.net>
X-From: git-owner@vger.kernel.org Sun Nov 06 03:52:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMsqR-0006TN-Tv
	for gcvg-git-2@lo.gmane.org; Sun, 06 Nov 2011 03:52:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753440Ab1KFCwX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Nov 2011 22:52:23 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41503 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753195Ab1KFCwX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Nov 2011 22:52:23 -0400
Received: by bke11 with SMTP id 11so2877604bke.19
        for <git@vger.kernel.org>; Sat, 05 Nov 2011 19:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Egi6ZBpchndjjGq53T8F39vpYs/j8Q1aYFaLI+B/4wQ=;
        b=qFS609X1EZJ+gmyW5DrhNODR2k+fXrj7NTT6065Wh0KoDb3jjk6+ISmLNYLzy4ULmV
         UoXhJiGrpI21D68bFnc9sZWimDzmp3Z8HcICCCvUGRia0eDKveh+bu0JisXilLKW34Do
         RGPZaKD/D9SH7JJ2/YKqsLdWOhFUDA/ad/egQ=
Received: by 10.204.16.67 with SMTP id n3mr15638742bka.6.1320547942132; Sat,
 05 Nov 2011 19:52:22 -0700 (PDT)
Received: by 10.205.134.1 with HTTP; Sat, 5 Nov 2011 19:51:51 -0700 (PDT)
In-Reply-To: <20111105182339.27C069004A@inscatolati.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184895>

On Sun, Nov 6, 2011 at 1:07 AM, Fernando Vezzosi <buccia@repnz.net> wrote:
> Enabling commit.verbose will make git commit behave as if --verbose was
> passed on the command line.

Is it necessary? If you want short command, you would use alias
instead of typing "commit". Adding --verbose to the alias to make the
command even shorter is straightforward.
-- 
Duy
