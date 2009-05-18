From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: Merging a branch when I don't want conflicts
Date: Mon, 18 May 2009 23:57:54 +0800
Message-ID: <be6fef0d0905180857y538b2c4y7208faa147a57601@mail.gmail.com>
References: <93c3eada0905171930m36765d4fued9c2efdc57e51a4@mail.gmail.com>
	 <4A10FDC6.2040706@viscovery.net>
	 <20090518194548.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>, geoffrey.russell@gmail.com,
	git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Mon May 18 17:58:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M65Ec-00034H-Vg
	for gcvg-git-2@gmane.org; Mon, 18 May 2009 17:58:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754172AbZERP5y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2009 11:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753630AbZERP5y
	(ORCPT <rfc822;git-outgoing>); Mon, 18 May 2009 11:57:54 -0400
Received: from mail-px0-f191.google.com ([209.85.216.191]:61283 "EHLO
	mail-px0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753186AbZERP5x (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2009 11:57:53 -0400
Received: by pxi29 with SMTP id 29so2011955pxi.33
        for <git@vger.kernel.org>; Mon, 18 May 2009 08:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+WrPIEChF3yrNXAoB2OW+ehrli5333DCChE1vr0fvkw=;
        b=DqNy1RRhp9zEqEDoJku5oi48Oyk4dK6s1taM0+6IUFWF/hY/gibiwNgBuoeYikXdR1
         iJHbe4v19F4ZJ0qe4TQRjd8GJ+aQqgtQEA0zNQRtzULRJt6pCksPqWG/1ab40+U095MZ
         vjrxICPQlpZk8OA4SvJv7aiPsO3VWFnDnC4KY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=LqWlo10mzXlqc+hV49D/kr3xJZGVt767YV8WCW5csVJ7dq0KLNJ6trFlG0v6IN1Yy/
         /dEsdKPsZCVxDRqniQZZSvRmmnAJh103UhNZWKvW6TTkjnSb1G6BnXCVvQkO08BocBY1
         P6ZoP7q9hpmS20Vkq59D7zRwGoRiRZb6kJR6s=
Received: by 10.114.130.15 with SMTP id c15mr11880052wad.59.1242662274881; 
	Mon, 18 May 2009 08:57:54 -0700 (PDT)
In-Reply-To: <20090518194548.6117@nanako3.lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119453>

Hi,

On Mon, May 18, 2009 at 6:45 PM, Nanako Shiraishi <nanako3@lavabit.com> wrote:
> I think -Xours enhancement that was developed long time ago

I think this is now called -s ours/--strategy=ours:

http://www.kernel.org/pub/software/scm/git/docs/git-merge.html

-- 
Cheers,
Ray Chuan
