From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 2/4] pull: pass --allow-unrelated-histories to "git merge"
Date: Thu, 21 Apr 2016 12:36:14 -0700
Message-ID: <CAGZ79kZgenHyvAKxKNGxKkybM=LgTfsvB7s91s1sQxxbp1xoFg@mail.gmail.com>
References: <20160421192500.23563-1-gitster@pobox.com>
	<20160421192500.23563-3-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 21 21:36:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atKOi-0003tD-3G
	for gcvg-git-2@plane.gmane.org; Thu, 21 Apr 2016 21:36:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753083AbcDUTgQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2016 15:36:16 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:33460 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751697AbcDUTgP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2016 15:36:15 -0400
Received: by mail-io0-f180.google.com with SMTP id f89so76511313ioi.0
        for <git@vger.kernel.org>; Thu, 21 Apr 2016 12:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=kusf2Ti9UAJqjRkTK3I4EP0PD+B+zPIkV+REcLF4P+4=;
        b=gBB1UQs4FCr3afsY/uP2jtZ1OXLR3YBkUVM4DmIP/QeH7ESH9BZMWENTq4SiMbzcQR
         GXM/jmzkI6sGafsv5XLWtD7TaUs4FkUBuQ0CatVW+zUofcy1rbtCe3FQjHLRSpq3szYJ
         fUxtDdAgzKF4sIK4nW7p3mPJTMZ4v27TPjRayRTMpkO4ypVYK9Gs/onois8W0yL2y2cV
         BQPEnCVGCRGVXEl8Q0+GTCdm6LWQvd4QV2vbXPNTLVXmflwiUtTbBAtGUTJV6RXcZ1DH
         ZD/LLSU2TtI/JWaHcb42DhGrPe2h1gQfakktXs/wMeJp4qPrcu4ac+BiNKQR0qC9MfC4
         Qm/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=kusf2Ti9UAJqjRkTK3I4EP0PD+B+zPIkV+REcLF4P+4=;
        b=X67wbDjORFL528J6GEAZiTT9k951k4lGdelfA17vG2TM/htniE9++rGkawAPOlvH/z
         BsJykCIbttqUuJeTnc77szVwseL2xvQv33kn8Xl3IGUHTqOsXY8z5gsqVTBfb8Gf81xS
         TTzrhXGkNxrEIwSWxf59oQpsSp1Qh7/jl4hO1Rxa5qT5IiJ2fqMcSwIhiOxkRT0G2d66
         xyrAkx5glCz0wqtOGUkKvBebf1Sx+LpolqhEERgsvNust8gD7O8cabYvjIFe0bkdSZqH
         tSpcV6igQCsysgovKJ7nnxxzRGli9UCtiBHk4kcLY12C+YusQrjZvNCg+z7xECOmoE55
         UHTQ==
X-Gm-Message-State: AOPr4FXw5brb0n0Mc2oXcY8ncw61609+Bj1Ui6sgRQg0Evk2CkcPLlawlOv4EnMSelqbU7xjYUf57JzTG4SkWmuH
X-Received: by 10.107.184.8 with SMTP id i8mr18557268iof.96.1461267374660;
 Thu, 21 Apr 2016 12:36:14 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Thu, 21 Apr 2016 12:36:14 -0700 (PDT)
In-Reply-To: <20160421192500.23563-3-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292149>

On Thu, Apr 21, 2016 at 12:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
> An earlier commit said:

And by earlier you meant to say e379fdf34f (2016-03-18, merge: refuse
to create too cool a merge by default)?
