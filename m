From: Carlos Pita <carlosjosepita@gmail.com>
Subject: Re: [bug] Graph log and orphan branches
Date: Wed, 30 Dec 2015 17:46:59 -0300
Message-ID: <CAELgYhf+EvcTHmZw3w4+WRg_wzJCo0b_Ft87J+1-rqJxeZ+r+g@mail.gmail.com>
References: <CAELgYhe4u2qU0-+mBKGwf8CpdZ=MuWMFZmeOhojtdMQZ3-nfhQ@mail.gmail.com>
 <xmqqziwremqh.fsf@gitster.mtv.corp.google.com> <1451508209.9251.13.camel@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Wed Dec 30 21:47:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aENeV-0004AH-9V
	for gcvg-git-2@plane.gmane.org; Wed, 30 Dec 2015 21:47:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754343AbbL3UrU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2015 15:47:20 -0500
Received: from mail-oi0-f44.google.com ([209.85.218.44]:34040 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754506AbbL3UrT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2015 15:47:19 -0500
Received: by mail-oi0-f44.google.com with SMTP id o124so207368465oia.1
        for <git@vger.kernel.org>; Wed, 30 Dec 2015 12:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=LcH+NYaQEQsoPl3Dl/scS9TgHGYDLGjlENoE2jxMltw=;
        b=ZWgBbUyZm2iSGSRIbsHg6FiJXSuxN5qZkvbj1GM8ga54o5inucoZo60C+rFhiHXiF1
         /Q2XIC44rX62YqX5DNXOmkEGVL7OVtovIhtY0G5rKAR59m2jyHW8BVVhCBNy/MjXZjZG
         plC3bfPDalVioEMlXcIo0DdIJo2+UZXH5W9h1hwt9gVe+sFCvjmGbqMuDuc586Ycc5B3
         7JrpyfB9/cRbQhDM0dFCOCOkm3ohe6yVSoW4YJB1sH6AZ7p35RnYuKQex1IY4F3CqSDh
         W9FD4mfdiUTZHu93zw6I38UdK6CwDklRbQhXYXFCLBqVCCpf0xdKkEUwNl/OqbnYi4lg
         mgug==
X-Received: by 10.202.71.147 with SMTP id u141mr23008424oia.45.1451508438471;
 Wed, 30 Dec 2015 12:47:18 -0800 (PST)
Received: by 10.182.135.167 with HTTP; Wed, 30 Dec 2015 12:46:59 -0800 (PST)
In-Reply-To: <1451508209.9251.13.camel@kaarsemaker.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283197>

> -               return "*";
> +               return commit->parents ? "*" : "^" ;

I like this idea.
