From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [patch 00/16] Portability Patches for git-1.7.1 (v4)
Date: Wed, 28 Apr 2010 12:26:37 +0000
Message-ID: <n2x51dd1af81004280526v2b0bb38ax90b9550a8840da7e@mail.gmail.com>
References: <20100427135708.258636000@mlists.thewrittenword.com>
	 <4BD7032D.9050508@drmicha.warpmail.net>
	 <20100428093205.GH36271@thor.il.thewrittenword.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
X-From: git-owner@vger.kernel.org Wed Apr 28 14:26:52 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O76Ll-0002Eo-UW
	for gcvg-git-2@lo.gmane.org; Wed, 28 Apr 2010 14:26:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452Ab0D1M0k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Apr 2010 08:26:40 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:39781 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840Ab0D1M0j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Apr 2010 08:26:39 -0400
Received: by bwz19 with SMTP id 19so12035bwz.21
        for <git@vger.kernel.org>; Wed, 28 Apr 2010 05:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=o6fJbb3KSG39BvrZM+ON8C1hZVMgOZqKYE0hhI9uRK4=;
        b=D4G1pGfa8VgyJReNt0m75+LF4s+T7kv4cZGgibgDL0mcnkAZN8kXLakJTn1T0aCC01
         GP93lSuImaEzTGK23vJXgMeKAhqj8U8HYFlfGQu3EyfRNcypjMy4d6l+sJpWL05OJxuR
         TjVdWgddF4u7BxqeKEZqlql90x2YfW3JZYUTE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=vED0WqIow3C8jZi74UiL2sVUKU0WW3dUhRddVGak0pXFk2d0kcK3jWYF7aytZEE/qQ
         Q0s5oNCJ7LOI0OCb0HfmH5E7mw7jZX4bDmCiy887xpxVjE+U99s0CkB1Z6kDQC3t9Hko
         RAniQdr3Yp/8tElTQiesmOUklNtNkWifiXzZ4=
Received: by 10.204.33.131 with SMTP id h3mr4729084bkd.53.1272457597704; Wed, 
	28 Apr 2010 05:26:37 -0700 (PDT)
Received: by 10.204.65.144 with HTTP; Wed, 28 Apr 2010 05:26:37 -0700 (PDT)
In-Reply-To: <20100428093205.GH36271@thor.il.thewrittenword.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145990>

On Wed, Apr 28, 2010 at 09:32, Gary V. Vaughan
<git@mlists.thewrittenword.com> wrote:
> I'm afraid not, though I can send you (off-list) a zip of the patch
> series and a quiltrc to apply using quilt or repeated calls to gnu
> potch, or if you prefer, a sumo-patch containing all the changes in
> one file for gnu patch?

I know of someone who'd like to test these on HP-UX, but it can be
hard to extract patches from the list:)

You can attach your patch series to the list with, e.g.:

    git format-patch --stdout -M origin.. > series.patch

Or maybe put up a forked repository somewhere, like on GitHub.
