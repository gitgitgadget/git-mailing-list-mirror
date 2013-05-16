From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/3] fetch: add --allow-local option
Date: Thu, 16 May 2013 03:53:46 -0500
Message-ID: <CAMP44s1SWORAzBP-WO_Xc62F=YFckgU4knLyse0DSDRW33crZA@mail.gmail.com>
References: <1368689474-28911-1-git-send-email-felipe.contreras@gmail.com>
	<1368689474-28911-2-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0=OTBVauqpxZO5br5zRy8D_o3DzgLfaDRVx9Y_EVm19qA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 16 10:53:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uctwh-0003jt-1q
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 10:53:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756287Ab3EPIxv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 04:53:51 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:41923 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755427Ab3EPIxs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 04:53:48 -0400
Received: by mail-la0-f49.google.com with SMTP id fp13so2078438lab.8
        for <git@vger.kernel.org>; Thu, 16 May 2013 01:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=ofNUBi+eP3iT1IDxBkUkao2+x7PdNZMA//xrw3XFWLc=;
        b=Vev09yO+84wB3uuFU48Poccb1fboEL5E0q0hGQSy1QD/AHP/CD5sjO1OiA1V6JSt5g
         SxPAaPhUqpMzchrmW3/PisHorON9r27N6UO1wfKJQPsBWkC0E3NuN1VLqfIvE3Vu33K3
         vEpxw1ZcsfNiDM2lNSot7sjE+8k2I1gSSsYOrchYnJE9M3l3k2g0E8jLD1Uiznb8+ZrS
         wSheQoRWk5FdDtTiLGlFnC5sgTyNM+peOCDeGjRNmAtRNyQUIGULugyjqV1D8kVS5JCV
         T1wQBuvut6SW1214mEJ8qF7VYMYIODQ9LSuWb1t7/k9QvHaa76RmrgcRUppLEQ9sCbc+
         nBdQ==
X-Received: by 10.152.22.168 with SMTP id e8mr19787564laf.20.1368694426846;
 Thu, 16 May 2013 01:53:46 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Thu, 16 May 2013 01:53:46 -0700 (PDT)
In-Reply-To: <CALkWK0=OTBVauqpxZO5br5zRy8D_o3DzgLfaDRVx9Y_EVm19qA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224512>

On Thu, May 16, 2013 at 3:25 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>> So that it becomes possible to override the behavior when the remote
>> tracked is '.'; if it is, we default back to 'origin'.
>
> What is the problem you're trying to solve?  Why do you have
> branch.<name>.remote set to '.' in the first place, if you meant
> origin?  'git fetch .' currently just updates FETCH_HEAD; while I'm
> not sure how that is useful, I still don't understand _why_ you want
> to change that behavior.

% git checkout -t -b devel master

-- 
Felipe Contreras
