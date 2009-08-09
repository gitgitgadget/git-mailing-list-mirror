From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 8/8] Allow helpers to request marks for fast-import
Date: Sun, 9 Aug 2009 14:27:11 -0700
Message-ID: <fabb9a1e0908091427q5dc871dax4fa866d4e0fe8016@mail.gmail.com>
References: <alpine.LNX.2.00.0908091527480.27553@iabervon.org> 
	<200908092325.53040.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Aug 09 23:27:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaFvX-0007zg-Fa
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 23:27:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753035AbZHIV1b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2009 17:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753003AbZHIV1b
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 17:27:31 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:34184 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752885AbZHIV1b (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2009 17:27:31 -0400
Received: by ewy10 with SMTP id 10so2647154ewy.37
        for <git@vger.kernel.org>; Sun, 09 Aug 2009 14:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=JoWu53k2KQri83RkgaL/Alm/5MZX1Jvv82slt26toH8=;
        b=eaTKwme2qoWael4OdcSDvQpWBM+iyiMetCg+Zo4nGgoSRt6vT/JkJPqPsy3UjWwINL
         aeUYZMatzOPjOEmI5Ag47So7wTLttP1QCjsljSE7/CxB9S6wqOBHNhld/gokS/ri7I6o
         CLVGOjU3S8fkmzkgTGHULsauTZqqthF5dQu5I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Q6kj1MnVYayoKZPhLQGKfIfSy2vCsBwBOt/LRpzms4oo/nYTrDj5ikr8tXBkobQHAH
         j7nIGBKGTevB/udUCaZkA5ROZUXL0FM+3p1gjVU9gS3FHP8Gl0TpGxP4X0yw4reV2Lq3
         xKYckWtFKcbLU9Kirn2YpCMGf5awUW4VVHO+g=
Received: by 10.216.29.210 with SMTP id i60mr701280wea.84.1249853251096; Sun, 
	09 Aug 2009 14:27:31 -0700 (PDT)
In-Reply-To: <200908092325.53040.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125384>

Heya,

On Sun, Aug 9, 2009 at 14:25, Johan Herland<johan@herland.net> wrote:
> In that case, the CVS helper (or any other helper) can use the "option"
> fast-import command instead of having to tell transport-helper.c to invoke
> fast-import appropriately. Seems like a somewhat cleaner solution to me...

Ah, another use case! I guess I'll go clean up my series and resend it then ;).

-- 
Cheers,

Sverre Rabbelier
