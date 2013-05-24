From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 0/3] Towards a useable git-branch
Date: Fri, 24 May 2013 22:27:19 +0700
Message-ID: <CACsJy8CaCv4eO2YH_bUKKKZWTxSu9zd3qaDQ5kdZQaKg64ggyQ@mail.gmail.com>
References: <1369405177-7855-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 24 17:27:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UftuM-0007eR-SY
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 17:27:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752426Ab3EXP1u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 11:27:50 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:62992 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751529Ab3EXP1u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 11:27:50 -0400
Received: by mail-oa0-f53.google.com with SMTP id g12so6351178oah.12
        for <git@vger.kernel.org>; Fri, 24 May 2013 08:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=tO9I5nSR7a3jG0vdJSpGswIU7DP/1vAI5wvHCiSVgz4=;
        b=GeP9awtMUktcud5fvV8Sk64aZw7lsw4a3TcpfdVezEKMc47Fy91MGyHg2DbNXFRBrD
         VS8D/utfYvEcVitE1jHnGV3u0CTPqPREa+6gjLOMGeNIsEXuDnOaZMLhQmgwhRw7d39/
         35KgCH1o2x4OksCn7vwDrRicwc7t1OiNOaX0V/x9oOy4CHiLNW3gh/H6lqn3LDeqiEde
         hr9rZTcURqFOaIZ+v8SCP2GTHzFBHRLf5TjYxjobgYRQY2OqCq0UttRk0CJKB0nQqPkl
         QA2pMEodhoXD4VavwJqK8EA+GTcQW3SRVRuzhXvQdy+M493AYte7b8DyhPls50qPrIl7
         emAw==
X-Received: by 10.60.62.162 with SMTP id z2mr12067986oer.140.1369409269851;
 Fri, 24 May 2013 08:27:49 -0700 (PDT)
Received: by 10.76.141.232 with HTTP; Fri, 24 May 2013 08:27:19 -0700 (PDT)
In-Reply-To: <1369405177-7855-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225362>

On Fri, May 24, 2013 at 9:19 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> There is no need to use a hammer and coerce everything into an atom,
> or throw everything out the window and start from scratch to conform
> to pretty-formats perfectly.  Let's extend the existing format to be
> _useful_ sensibly.

Usefulness is one thing. Another is maintenance and in that regard I
still think we should be able to remove -v and -vv code (not the
functionality) with this topic.
--
Duy
