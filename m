From: Lars Hjemli <hjemli@gmail.com>
Subject: Re: [PATCH] git-log: allow --decorate[=short|full]
Date: Sat, 15 Aug 2009 12:26:20 +0200
Message-ID: <8c5c35580908150326i661a3203kdd82023bb694734d@mail.gmail.com>
References: <8c5c35580908150250y62b1042cmf6071016bac98a48@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 15 12:31:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McGXp-0004fh-LU
	for gcvg-git-2@gmane.org; Sat, 15 Aug 2009 12:31:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752946AbZHOKbV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2009 06:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752532AbZHOKbV
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Aug 2009 06:31:21 -0400
Received: from mail-yx0-f175.google.com ([209.85.210.175]:36608 "EHLO
	mail-yx0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752096AbZHOKbU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Aug 2009 06:31:20 -0400
Received: by yxe5 with SMTP id 5so2524744yxe.33
        for <git@vger.kernel.org>; Sat, 15 Aug 2009 03:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=u7sOLk2qVWf8MP549VUQMOH0Ue56PWnU+DT9p0HPms8=;
        b=fezYQWgmrljvh8nzDwsvl0HBUs7uGEU3eOVx6kbSDaUxpN5pmy1Y9AQwxeovoeUlBn
         mVWHq2DmRzexG2wWUFbX+zJXpbO/tluty1jTWOaqy6Z0wmGIj/KPP7yco4WrshGkHt2R
         zrvGO0FxlTlyEZqdeK8qwgaKTuqTtH5TcooC8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vlxvqYP67NkOkHLHAAWxDMXbcnP5v4XatyFMqWbpD/AWvhQ847MdVlY+vnrfYaDGTE
         qRUyLI6qaofpJl/YhcaduncLLCO5Pv1kr3E/YTtrRHDnwaa1hO+/xbhGhdq9tLYpAyNS
         uhEwM//9FwZKFgPDyHamFgFIf++7j5p5eXXsM=
Received: by 10.150.175.8 with SMTP id x8mr3379448ybe.40.1250331980989; Sat, 
	15 Aug 2009 03:26:20 -0700 (PDT)
In-Reply-To: <8c5c35580908150250y62b1042cmf6071016bac98a48@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125997>

On Sat, Aug 15, 2009 at 11:50, Lars Hjemli<hjemli@gmail.com> wrote:
> This extension to --decorate makes it possible to generate decorations
> similar to pre-1.6.4 git, which is nice when the output from git-log
> is used by external tools.

BTW: the patch was made on top of current master (b2139dbd) - if
accepted, it might be considered for maint.

--
larsh
