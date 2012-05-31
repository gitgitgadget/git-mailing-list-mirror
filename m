From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] Remove perl dependency from git-submodule.sh
Date: Thu, 31 May 2012 11:07:22 +0200
Message-ID: <CACBZZX6fV5PpgV6GMhDMYgXeeP_QYK9jnP15tMn9Y-a-O6Pn3A@mail.gmail.com>
References: <1338454126-30441-1-git-send-email-iveqy@iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, jens.lehmann@web.de, gitster@pobox.com
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Thu May 31 11:07:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sa1MC-0002Hb-SP
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 11:07:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753397Ab2EaJHo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 May 2012 05:07:44 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:40133 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751331Ab2EaJHo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2012 05:07:44 -0400
Received: by obbtb18 with SMTP id tb18so1077395obb.19
        for <git@vger.kernel.org>; Thu, 31 May 2012 02:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=s9LcfhmwV7m/PXReFepokCWnVhW8Ny0yr2iprGzW3Ew=;
        b=Csm4yMp2OxalbZsPyn8lhNJoWscASiFtaqw834aJgGViZtGcu707OhWxSFs1nS0EyA
         zq6CWapDMw+ih4bHJoSihp0iehTz+Qaxo3Xny/EpYuilxeJaDGB+Ab355wLO/InYQptM
         LjhpJ2CELizWc2wLUFQzf3jxbAhhEjWj+d+vnKt02beRGyNPKHOXjGWNZptVU6hhVC/U
         zzaaAu1gzrM7bcTuAYX0tpOQzv8p0HCu7MeBYiST/ggBwU1Xl49HoPhWWdCUBW9Zlya4
         kG2fG0KNSA/hWY/s599VJnSm+1+sUIQXqrhkCpfgHKvdzK3VVqhVBFFyPAtKomHGFYBu
         /AdQ==
Received: by 10.182.47.105 with SMTP id c9mr1290397obn.49.1338455263631; Thu,
 31 May 2012 02:07:43 -0700 (PDT)
Received: by 10.182.167.65 with HTTP; Thu, 31 May 2012 02:07:22 -0700 (PDT)
In-Reply-To: <1338454126-30441-1-git-send-email-iveqy@iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198874>

On Thu, May 31, 2012 at 10:48 AM, Fredrik Gustafsson <iveqy@iveqy.com> wrote:
> Rewrote a perl section in sh.
>
> The code may be a bit slower (doing grep on strings instead of using
> perl-lists).

May be? Did you test it, if so what's the difference?
