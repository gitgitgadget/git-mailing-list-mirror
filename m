From: Chris Rorvick <chris@rorvick.com>
Subject: Re: [PATCH] git-push: update remote tags only with force
Date: Wed, 31 Oct 2012 07:52:08 -0500
Message-ID: <CAEUsAPYOS8YYw3NjRN+Hnaib9jSTZttFVR+FJjGWWaEK4jsmVw@mail.gmail.com>
References: <1351661875-4307-1-git-send-email-chris@rorvick.com>
	<CAMP44s2T9Rmfjd8r+2+eYh8JBPXEofm3cHuEkkY+R3cW6R6HxA@mail.gmail.com>
	<CAM9Z-nk6YRtNXNHbp-ReXB78V0O01qng+zmWfzm7Yxz51x22Yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Angelo Borsotti <angelo.borsotti@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Kacper Kornet <draenog@pld-linux.org>
To: Drew Northup <n1xim.email@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 13:52:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTXmR-0004ej-Gd
	for gcvg-git-2@plane.gmane.org; Wed, 31 Oct 2012 13:52:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932495Ab2JaMwL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2012 08:52:11 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:55425 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757158Ab2JaMwJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2012 08:52:09 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so1019764lag.19
        for <git@vger.kernel.org>; Wed, 31 Oct 2012 05:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=cyaYbpa1+TkV6WOoQj3mbpFzvgVQPJUqu3a1pvaEY5c=;
        b=f5b+2M12Bk4Ai8d2a9y2eHH0qFwBvoyx3YRSuC9AOQmXYN0htGOYU7DgxeTXDOvfqG
         5t2VlWVLfDra9CaBwLuS5uJIg6C4zTOBzHd/izcOK+y67uxRURqcJUHQXdxD/T4CmYmV
         MziPNzFbvu8lEcJoOtdZHj0UrG2L2mpyvqzOyEVLC5QnNaxESIZyFsoocXNB6xFqvoUi
         75We7oA0sPxnwoowkImKE8Jia59SilDJrCfGrw90pkYa76D3bZUY0+I1iP7oVw8iIk+k
         /MhxoEUovgFKc3gOzRGShz2Be9Ehv/Is9p9SwHl/h4QF3WPZ4owRwWOk8P5maVwcwYqS
         MW7A==
Received: by 10.112.14.107 with SMTP id o11mr14531645lbc.98.1351687928199;
 Wed, 31 Oct 2012 05:52:08 -0700 (PDT)
Received: by 10.114.2.45 with HTTP; Wed, 31 Oct 2012 05:52:08 -0700 (PDT)
In-Reply-To: <CAM9Z-nk6YRtNXNHbp-ReXB78V0O01qng+zmWfzm7Yxz51x22Yw@mail.gmail.com>
X-Google-Sender-Auth: IfCA8-HRJZBrp1zLskjabSfGq0E
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208816>

On Wed, Oct 31, 2012 at 7:26 AM, Drew Northup <n1xim.email@gmail.com> wrote:
> On Wed, Oct 31, 2012 at 1:55 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>
>> but I wonder if it might be
>> possible to split it to ease the review.
>
> Agreed.

I'll look at splitting it up, probably not tonight though.  :-)

> Also, do please CC ALL interested parties from the pre-patch
> discussion thread as well as those who previously maintained that
> chunk of code.
>
> [Attempted to reconstruct CC list of discussion]

Thanks for fixing that.

Chris
