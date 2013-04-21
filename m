From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 4/5] git-log.txt: rewrite note on why "--" may be required
Date: Sun, 21 Apr 2013 13:27:20 +0530
Message-ID: <CALkWK0nwrwPSqOCabBsnGsrAfxphYiUXhfpT7DnSvo6RKftqjA@mail.gmail.com>
References: <1366458313-7186-1-git-send-email-artagnon@gmail.com>
 <1366458313-7186-5-git-send-email-artagnon@gmail.com> <7vtxn0wf4j.fsf@alter.siamese.dyndns.org>
 <CALkWK0nFAzPPb0_jTRev6nuicCV81sRQAbe=277nhyyY8TnQ7A@mail.gmail.com>
 <7v8v4cwd6g.fsf@alter.siamese.dyndns.org> <7v4nf0wcw3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Thomas Rast <trast@inf.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 21 09:58:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTpA0-00043p-0r
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 09:58:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751708Ab3DUH6B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 03:58:01 -0400
Received: from mail-ia0-f172.google.com ([209.85.210.172]:49961 "EHLO
	mail-ia0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751141Ab3DUH6B (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 03:58:01 -0400
Received: by mail-ia0-f172.google.com with SMTP id i20so437482ian.31
        for <git@vger.kernel.org>; Sun, 21 Apr 2013 00:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=tl55M3NB2wGie938/eVVnML9hLqGpaqEFbLsTPqa8Js=;
        b=Kqa5E4Y1L0pTyG3b2zZYUHix/EutDAyHk3UcLtFhN9nMrCyYBROCfiu/e6eoMXTNKe
         RYxo89W/pgO0C8AuJcT3c4KR9LN+JiQfr85fF6yQrfPQZthRrlMHbz2MlLGwR+dz+l0p
         O7vNKnAlx7DccNf1AT78a8lHG85tWKdqYuSUpYGuzh0hknf3jH+LmTAIFHuhGcGM8ZSa
         ywMUam2+YpswcgAZm4SmNiz5VCXTD0TigYLLK7HFIRECxn72IMzDTDbgODUS7OpIq9kF
         RXC91Vj0iZAWckQo/ZcE1x+rlIuEsLuUMFL5/uCKTQDloSJF3UpiUlDviATTCxSHPcba
         nlvw==
X-Received: by 10.50.117.3 with SMTP id ka3mr18082134igb.107.1366531080747;
 Sun, 21 Apr 2013 00:58:00 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Sun, 21 Apr 2013 00:57:20 -0700 (PDT)
In-Reply-To: <7v4nf0wcw3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221912>

Junio C Hamano wrote:
> I think you are trying explain "git log --short A B ^C" as if it
> takes "--short" (which is an option), "A", "B", and "^C" (all of
> which are revisions).  And I am saying that is wrong.
>
> It is "--short" (which is an option) and "A B ^C" (which is a
> revision range).

Got it.  Your explanation makes more sense.
