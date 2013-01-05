From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Add getenv.so for catching invalid getenv() use via
 LD_PRELOAD
Date: Sat, 5 Jan 2013 14:53:38 -0800
Message-ID: <20130105225338.GB3247@elie.Belkin>
References: <CAEvUa7niTJVfp8_kuWs50kvhfZ59F-yAuAmeOXEduHXOq-tRFA@mail.gmail.com>
 <1357376146-7155-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	David Michael <fedora.dm0@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 05 23:54:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Trcct-0006po-P0
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 23:54:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755933Ab3AEWxo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Jan 2013 17:53:44 -0500
Received: from mail-pa0-f54.google.com ([209.85.220.54]:52283 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755900Ab3AEWxn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Jan 2013 17:53:43 -0500
Received: by mail-pa0-f54.google.com with SMTP id bi5so9975974pad.27
        for <git@vger.kernel.org>; Sat, 05 Jan 2013 14:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=viS5Ms9irz/d9uxxHqiH9X0aliJXAvX97LEA2J3h8Q0=;
        b=xDIi8JABi+yjSqlebGXcLRv0T9hbk0tKsh2FGAqYOfB7MOPqaUMY3+x04whQqS35L6
         zxFA/zp7XzHnVGN1buNO7F05/eTsTk9FI7PypTQUkWsOP/3njr1VsaNDpWaVsNoRTrvE
         WbIQy6WSL09XF6hw1uhUGuUzLossHXWRRh0iRlEwbuRsuBjJScN07kFUoaf84mUsCzpS
         9Na8UAEhrwB/j6sPvF4nz3XEM+jFGtNfMV/jIRgmYT/ZDxCfeDOpZzmsxl2fLUn6TaPo
         zRSfaTdxpq1gUeqJhVTaa/YUBlN7scehhQvOQSHPGnwS5YJCHi6x4Sk8IQovF4f8Xq0e
         oEyw==
X-Received: by 10.68.213.33 with SMTP id np1mr173409775pbc.64.1357426422859;
        Sat, 05 Jan 2013 14:53:42 -0800 (PST)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id qt3sm34723779pbb.32.2013.01.05.14.53.41
        (version=SSLv3 cipher=OTHER);
        Sat, 05 Jan 2013 14:53:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1357376146-7155-1-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212734>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Perhaps this will help the getenv bug hunting

Even if no one decides to do the getenv hunting (I haven't decided yet
whether it's worth the trouble, though patches like the setup_path()
one that make string lifetimes clearer are valuable anyway), this
looks useful as a debugging tool when people on strange platforms
report problems.  And unlike the trick I sent a while ago, it doesn't
involve recompiling git.  So for what it's worth,

Acked-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
