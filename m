From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 4/4] fast-import: only store commit objects
Date: Mon, 6 May 2013 16:06:45 -0500
Message-ID: <CAMP44s27ewVqLhJ5gT6T2B7V3vP=HX4Ughy9Q7zSi61X_9so_w@mail.gmail.com>
References: <1367555502-4706-1-git-send-email-felipe.contreras@gmail.com>
	<1367555502-4706-5-git-send-email-felipe.contreras@gmail.com>
	<87y5bw3q1s.fsf@hexa.v.cablecom.net>
	<CAMP44s1R9hAMZ=DQoPiTVi3+40NpADjVFU7tYovZA8W-PWEhhg@mail.gmail.com>
	<518785B3.3050606@alum.mit.edu>
	<87ip2wflg0.fsf@linux-k42r.v.cablecom.net>
	<alpine.DEB.1.00.1305060720060.8213@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Antoine Pelisse <apelisse@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 06 23:07:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZSce-0005VA-Mj
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 23:07:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757669Ab3EFVGs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 17:06:48 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:47643 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756405Ab3EFVGr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 17:06:47 -0400
Received: by mail-lb0-f176.google.com with SMTP id v20so22990lbc.7
        for <git@vger.kernel.org>; Mon, 06 May 2013 14:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=MEuL0wtczs9grTSBdgXrLVnHXergNspAQWyiLyCP9nU=;
        b=EpPfC5u7KkolIKwJBhCsV4DWm/Igh4Q8n3k1ymzBVt9sDJL3Ts7hxqYeOXNadZbOqS
         nfVnnRqSgwRHJxwC0jOiyrmVnyonGctcs9wQj2yTPLdFRQ39Bb3WldT1Ip7KbiEsn00N
         JoJjEOKV5V/uWlTmzW634Rcdx2rmzEn6RKr5Idmrb+oUk26anxkHSOhhldbS1duX+zVG
         AOVTL1OqMKykLDyQ/zdRJ8LpSJeo0eq6au3ONwwWdsG2iZYrIgFfWqD1eYS3+vZ0Ri2l
         DntJ2TEIO4D8ZoSHd8xkzQRYPtxASGtI0ez1WludnsaSsJSLkD0anOHbYnFY+Vt+tknW
         UsRA==
X-Received: by 10.112.145.72 with SMTP id ss8mr8051027lbb.12.1367874405730;
 Mon, 06 May 2013 14:06:45 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Mon, 6 May 2013 14:06:45 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.1305060720060.8213@s15462909.onlinehome-server.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223506>

On Mon, May 6, 2013 at 7:20 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Thomas,
>
> On Mon, 6 May 2013, Thomas Rast wrote:
>
>> The proposed patch wants to stop writing marks (in --export-marks) for
>> anything but commits.
>
> Then it should not go in.

If that rationale was valid, no change in behavior should ever go in.
Of course, that is not the case, we want to move forward, so changes
in behavior do happen.

-- 
Felipe Contreras
