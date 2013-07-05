From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: Re: [PATCH v9 1/5] t4041, t4205, t6006, t7102: use iso8859-1 rather
 than iso-8859-1
Date: Fri, 5 Jul 2013 12:42:41 +0400
Message-ID: <20130705084241.GD32072@ashu.dyn1.rarus.ru>
References: <cover.1372939482.git.Alex.Crezoff@gmail.com>
 <cover.1372719264.git.Alex.Crezoff@gmail.com>
 <cover.1372939482.git.Alex.Crezoff@gmail.com>
 <38cdab6c314e858ec580b1d0fbf87098c2d92cb0.1372939482.git.Alex.Crezoff@gmail.com>
 <7vy59la4gn.fsf@alter.siamese.dyndns.org>
 <20130705080011.GB32072@ashu.dyn1.rarus.ru>
 <7vwqp58lyy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 05 10:42:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uv1bO-0000YW-Uc
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jul 2013 10:42:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757176Ab3GEImr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jul 2013 04:42:47 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:39237 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757167Ab3GEImp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jul 2013 04:42:45 -0400
Received: by mail-la0-f49.google.com with SMTP id ea20so1854104lab.36
        for <git@vger.kernel.org>; Fri, 05 Jul 2013 01:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=cXx9AF8yHLa0V22+IanPXlcJyWCy9NQKVDuXrIwQLMs=;
        b=NqdU+yAgXaLcdUcdtGxdIr9wMvCfzBBW5nzhAovo8JDMrVFDbkIjAQFjuu9vdqCob8
         zm61zfdddck+hp8L98lc7uTFH+rifjLi2BKcZcXuSAMqAMGbtBU3IN5NcfaJVoeySVhn
         ZcS4JHkLyqrPH+qxh46kShGsi3iETtkk3yy/4X9U4gbZTrvXdgFGlwdI6yuC17eQ/8b9
         ZwwDbPlhMkg6jjT44rZ542lXpc23QbTR7C2NRFztAAWcplNMznjYjkGAfqgcTzbIOHUM
         kQdzC0honhONdNbAdbCytAXP1+Boi07yofXrnfMZ+C1n+n+0xJG17eQbkuGfCh5cItKR
         e7pA==
X-Received: by 10.152.6.228 with SMTP id e4mr4483633laa.61.1373013764180;
        Fri, 05 Jul 2013 01:42:44 -0700 (PDT)
Received: from localhost ([85.21.218.130])
        by mx.google.com with ESMTPSA id c4sm2464199lae.7.2013.07.05.01.42.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 05 Jul 2013 01:42:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vwqp58lyy.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229639>

On Fri, Jul 05, 2013 at 01:11:49AM -0700, Junio C Hamano wrote:
> Alexey Shumkin <alex.crezoff@gmail.com> writes:
> 
> >> 	Both "iso8859-1" and "iso-8859-1" are understood as latin-1
> >> 	by modern platforms, but the latter is not understood by
> >> 	older platforms;update tests to use the former.
> >> 
> >>         This is in line with 3994e8a9 (t4201: use ISO8859-1 rather
> >> 	than ISO-8859-1, 2009-12-03), which did the same.
> > Yep, it whould be better, I thought to do like this but I didn't )
> >> 
> >> > Signed-off-by: Alexey Shumkin <Alex.Crezoff@gmail.com>
> >> > Reviewed-by: Johannes Sixt <j.sixt@viscovery.net>
> >> 
> >> I do not recall this exact patch reviewed by J6t, but perhaps I
> >> missed a message on the list?
> > I've reread 'SubmittingPatches' doc, and I can say I used "Reviewed-by"
> > incorrectly. Sorry for this. It must be "Suggested-by" there, I guess.
> 
> OK, then I'll queue this patch (but not 2-4/5 yet) with log message
> amended.
Excuse me, you've said "Ok" for 2/5 message, and then explained (as I
understood) then "subtle difference" between EOF and \EOF.
Should I change the message somehow?
> 
> Thanks.

-- 
Alexey Shumkin
