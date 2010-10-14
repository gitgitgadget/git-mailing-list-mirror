From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Manual hunk edit mode + emacs + ^G == garbage
Date: Thu, 14 Oct 2010 09:37:51 +0000
Message-ID: <AANLkTimM92SdY_+v5JcOx2kYbDKBJJzBofFm0FLF_S6K@mail.gmail.com>
References: <39CB17A9-2717-491B-8E01-F3E855F90649@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Thu Oct 14 11:38:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6KG6-00081P-6P
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 11:37:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755452Ab0JNJhx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Oct 2010 05:37:53 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:50963 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755251Ab0JNJhw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Oct 2010 05:37:52 -0400
Received: by fxm4 with SMTP id 4so2249291fxm.19
        for <git@vger.kernel.org>; Thu, 14 Oct 2010 02:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=jIg3FUC9wuxmb9uj5IXX+MGV2LgpNy6UqG7yWilddUU=;
        b=usQg2L/sXRJFu1r10vuWbVw5+srcPy0dzv4A2/AbH+S6fMKcjIvjEhDw9WQDj7Xm6i
         BCb3WRK2oKq7aBuIRvM4y/HmhMTlEbueRWveEn4Z/kro9MzWZmJ6o/L6KPfzP0kSFf6S
         LbaqTCouqA5sHK74M6xiIpefbYFfgwhD6ipK8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=cgfS7DV5jtwj5OEyzQZRr/UGaB3H0fnzJgLY34cnLDW/DZj95DnvNGsSxwuftV1eqs
         0tlek2o+03joPliIOCSD3M0kIwJIsIZ8TJgLXsvx8ZoPlhzbK0uqbuzERf17PblTiNIX
         3UTwSFxxRV2aDCEkvPgLnrmbFi7yPGBqzkMvw=
Received: by 10.103.124.7 with SMTP id b7mr1803495mun.102.1287049071170; Thu,
 14 Oct 2010 02:37:51 -0700 (PDT)
Received: by 10.223.119.17 with HTTP; Thu, 14 Oct 2010 02:37:51 -0700 (PDT)
In-Reply-To: <39CB17A9-2717-491B-8E01-F3E855F90649@sb.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159038>

On Wed, Oct 13, 2010 at 21:37, Kevin Ballard <kevin@sb.org> wrote:

> I've been having a rather strange problem using manual hunk edit mode (`git add -p`, e)

Aside from this bug you might want to check out magit.el, it's a much
nicer hunk edit more for Emacs than running git add -p in an Emacs
terminal is.
