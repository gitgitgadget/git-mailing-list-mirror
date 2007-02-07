From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [RFC/PATCH] fast-import: Fix compile warnings
Date: Wed, 7 Feb 2007 13:19:00 +0100
Message-ID: <81b0412b0702070419t2293f776wb4f3f7beb76c986c@mail.gmail.com>
References: <Pine.LNX.4.63.0702071237360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 07 13:19:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEllT-0005gB-VH
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 13:19:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161280AbXBGMTE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 07:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161288AbXBGMTE
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 07:19:04 -0500
Received: from wx-out-0506.google.com ([66.249.82.232]:36032 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161280AbXBGMTC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 07:19:02 -0500
Received: by wx-out-0506.google.com with SMTP id h31so173470wxd
        for <git@vger.kernel.org>; Wed, 07 Feb 2007 04:19:01 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IBxULyM3AAFN0cqw0vpwGm4qh/ohOs9EdJAnKVwTrS0BiIThOEdxdbFQCd9UwlZOAMj5qbUO2EIOKffFs2xKI//sNx53jj6P7Tz9iCziBumedUyix0SmJHoZYN6421UTqgLsF5wML+6puz8lUXfk6LDQuaGCYXMEqvQjTuwt50M=
Received: by 10.78.138.6 with SMTP id l6mr2181695hud.1170850740680;
        Wed, 07 Feb 2007 04:19:00 -0800 (PST)
Received: by 10.78.139.9 with HTTP; Wed, 7 Feb 2007 04:19:00 -0800 (PST)
In-Reply-To: <Pine.LNX.4.63.0702071237360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38918>

On 2/7/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
>         I have no idea how portable %z is, but there are so many
>         experts on this list. Care to enlighten me?
>

IEEE Std 1003.1[1] mentions it, but I never was able to rely on it:
AIX, Solaris, QNX-libc at least didn't have it, last time I checked.
Micro$oft doesn't have it, of course.

[1] http://www.opengroup.org/onlinepubs/009695399/functions/fprintf.html
