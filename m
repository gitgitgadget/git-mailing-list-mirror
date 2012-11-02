From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 4/4] fast-export: make sure refs are updated properly
Date: Fri, 2 Nov 2012 16:35:29 +0100
Message-ID: <CAMP44s1QPNCASyz3sVHPkJGv+PqrV5_Rt1ymVavupkaCtr-DJQ@mail.gmail.com>
References: <1351623987-21012-1-git-send-email-felipe.contreras@gmail.com>
	<1351623987-21012-5-git-send-email-felipe.contreras@gmail.com>
	<20121031003721.GV15167@elie.Belkin>
	<20121102131255.GB2598@sigill.intra.peff.net>
	<alpine.DEB.1.00.1211021612320.7256@s15462909.onlinehome-server.info>
	<20121102151955.GA24622@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Elijah Newren <newren@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 02 16:35:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUJHb-0000sx-FA
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 16:35:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752656Ab2KBPfb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2012 11:35:31 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:54215 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953Ab2KBPfa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2012 11:35:30 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so3717380obb.19
        for <git@vger.kernel.org>; Fri, 02 Nov 2012 08:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=nt6D4Plqz0yreysVHmYxYtlXqP2AHcf+6Mfm9wbvqa8=;
        b=PWfbjgfP/FccBKpP+vMHghrp9DFDRAXnb9gbkPCoOG0DHcZr+ud/zOQvTzcjjxDpBZ
         8Le2WSXHXdoeKzDWnSQZbAmdCRJp812pXNLajmBdvYVD9g3gIZfOSNUoJmhUxKvZpywx
         WdJVpo1ExV0GlaeufSyyO50bPiBEjAi9KJeW67eDhkDTYBDVNFHz7tqh2qCHB9H63g0Z
         ufweDsdXM6BXc6HCjOkTBwO+OpPWQ/98rJbSZ64iWd13fYMflcLzXh1buhRdxP+HW7ig
         tQLp1vo3v9KpT7UKF4LS4cWpp5nupY3/hKa9kZs+usKOiezT2PI9ScqKOSJPpBdktOTq
         zzSA==
Received: by 10.182.235.46 with SMTP id uj14mr1637557obc.40.1351870529729;
 Fri, 02 Nov 2012 08:35:29 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Fri, 2 Nov 2012 08:35:29 -0700 (PDT)
In-Reply-To: <20121102151955.GA24622@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208952>

On Fri, Nov 2, 2012 at 4:19 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Nov 02, 2012 at 04:17:14PM +0100, Johannes Schindelin wrote:

>> May I just ask to include a summary of that rationale into the commit
>> message rather than relying on people having internet access and knowing
>> where to look? Adding the following to the commit message would be good
>> enough for me:
>>
>>       Note that
>>
>>               $ git branch foo master~1
>>               $ git fast-export foo master~1..master
>>
>>       still does not update the "foo" ref, but a partial fix is better
>>       than no fix.
>
> Yes, I think that makes a lot of sense.
>
> Felipe, I notice that you sent out a big "fast-export improvements"
> series. Does that supersede this?

Yes. I noticed this patch fixes other tests.

Cheers.

-- 
Felipe Contreras
