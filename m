From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: clone --bare vs push
Date: Mon, 3 Jan 2011 19:41:07 +0100
Message-ID: <AANLkTimsOxfnKHLRMH6JSQbrGKzaOgh_gLuc1gT4JraF@mail.gmail.com>
References: <AANLkTi=+cRqD_CDFyaYj8uWOxUA1+5Dgr_pv1guaaT40@mail.gmail.com>
	<AANLkTi=RNDYrRbyEJXA_c30JEVr=SYUQ01cfA3FyWpLT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Levend Sayar <levendsayar@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 03 19:41:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PZpLJ-0000xy-Nz
	for gcvg-git-2@lo.gmane.org; Mon, 03 Jan 2011 19:41:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751557Ab1ACSlK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jan 2011 13:41:10 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49619 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848Ab1ACSlJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jan 2011 13:41:09 -0500
Received: by bwz15 with SMTP id 15so13955492bwz.19
        for <git@vger.kernel.org>; Mon, 03 Jan 2011 10:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=EfQFrVjNRJQYGUJVj1/jb4NLcVBAAHSgsC0XnJ4ofmY=;
        b=SYL25lM8J05h6M9ZOJqJzDgTrMFjjsU+vmE2ma+Jf2jSL+ssGOWC4C5i6VWA76LPvT
         saBpBx2New1r975Ebcamgmg1pkykRnqcd1hnTbJMdTZIULfJM0TGYr9tlSLiLt/P5UYr
         F1zCG8C8NeziK6cEfpYv5CMxTDxwTaB2nny80=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=mauEMo55SiPyifm9HKtC8hE8f5t4uUjCvWJpyPSGQHnqw3Mh0vQvhtQe3cX8kxSWE0
         dGnzQqrmCnyoAY26p4mjHK9Phjzo2btpU1qw5Ja5uwDr4d4yA/KtvxMN206RqlO715wW
         C/8+XUF+ZKqjwfIJkxuPPQpWYfhJCktNZKsJ4=
Received: by 10.204.59.72 with SMTP id k8mr16180558bkh.84.1294080067918; Mon,
 03 Jan 2011 10:41:07 -0800 (PST)
Received: by 10.204.55.203 with HTTP; Mon, 3 Jan 2011 10:41:07 -0800 (PST)
In-Reply-To: <AANLkTi=RNDYrRbyEJXA_c30JEVr=SYUQ01cfA3FyWpLT@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164455>

On Mon, Jan 3, 2011 at 19:24, Levend Sayar <levendsayar@gmail.com> wrote:

> 1) When I compare X/.git directory and y.git directory there are many
> objects missing in y.git. What is the reason ?

Maybe things were repacked.

> 2) git clone --bare is too fast. My .git directory is nearly 1GB. How
> can it be copied that much fast ?

It will use hardlinks when using the same filesystem. See
--no-hardlinks in git-clone(1).
