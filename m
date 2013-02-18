From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: git clone tag shallow
Date: Mon, 18 Feb 2013 13:49:52 +0700
Message-ID: <CACsJy8Dso-g7foyJhpY20DNrY11PA8ZZUmP6JXxsiJ_Ggbt_KA@mail.gmail.com>
References: <CAByu6UWEF48XvTmRnVDb2Bqxy1dNdUSXpTuy804215Vgs_KJxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Thibault Kruse <tibokruse@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 07:50:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7KYw-0007Os-Uu
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 07:50:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751735Ab3BRGu0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 01:50:26 -0500
Received: from mail-ob0-f171.google.com ([209.85.214.171]:64337 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484Ab3BRGu0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 01:50:26 -0500
Received: by mail-ob0-f171.google.com with SMTP id x4so5300965obh.30
        for <git@vger.kernel.org>; Sun, 17 Feb 2013 22:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=DJeNpIQF/y/UBgNcTTMYWA0+WtGIF+h1arqHGcueM80=;
        b=fHKAeOtXg6oPnb2LlAnN5fkDrgezdMQnoLar0DbOqAfHVmuw9nOrgF4lDgbaRJkKj1
         Rg06yZahFSD7SNS7eZ5vXmNvnL9RGPV1o+DKNia0DoZPxYCouD6IKAXxEBcYiw2WfoVR
         kA/UfZCuHbu83M9f9GBIhZWCd6p2b37/1z+bZuPhlhGk+3TdDlYcTsb5NsEIJo5vUc4P
         877ctvCge1cxyNsyiI7Cs3k+5zUUt54k7cZYpA0QCM9yDZOxZJIt9GDUwBKU/QX7sSGr
         FadsTPisRDAZXindsgK6EM/Sm/oDnHXPKEmMD35XxyCuNfvPTKrL+xHkuB1fVT/6p/Od
         Yvtg==
X-Received: by 10.60.32.67 with SMTP id g3mr5496543oei.77.1361170224396; Sun,
 17 Feb 2013 22:50:24 -0800 (PST)
Received: by 10.76.154.197 with HTTP; Sun, 17 Feb 2013 22:49:52 -0800 (PST)
In-Reply-To: <CAByu6UWEF48XvTmRnVDb2Bqxy1dNdUSXpTuy804215Vgs_KJxw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216440>

On Mon, Feb 18, 2013 at 2:13 AM, Thibault Kruse
<tibokruse@googlemail.com> wrote:
> Hi all,
>
> I notice that using git 1.8.3, I can call
> git clone repo1 repo2 --branch tagname
> with a tag, not a branch. Is this going to be a stable and documented feature?

There is a test for --branch=tag in t5601, so I say it's supported. If
the document is not clear, patches are welcome.
-- 
Duy
