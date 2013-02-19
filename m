From: Blind <stoycho.sleptsov@gmail.com>
Subject: Re: [RFC/PATCH] Introduce branch.<name>.pushremote
Date: Tue, 19 Feb 2013 13:18:10 +0200
Message-ID: <CAGL0X-qLikj3bKervpASEixnEVLjBGDN=8QX8K6SG-A2Z_dVUg@mail.gmail.com>
References: <1360307982-20027-1-git-send-email-artagnon@gmail.com>
	<CAGL0X-rKnWBy-Ff=YmEdqgo8RFb40FXTxvUM5X77YaQvhAGHYg@mail.gmail.com>
	<CALkWK0kBjsHtK1_7imJx-7CATSKFzpUgGzH6Hs9DAQ8c7jRUPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 12:18:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7lDX-0004T6-RW
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 12:18:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932714Ab3BSLSM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 06:18:12 -0500
Received: from mail-vc0-f170.google.com ([209.85.220.170]:47857 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932354Ab3BSLSL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 06:18:11 -0500
Received: by mail-vc0-f170.google.com with SMTP id p16so4271821vcq.29
        for <git@vger.kernel.org>; Tue, 19 Feb 2013 03:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=oeVpf7lkIU4/jLYXRb5MUbnbs9ThbrjWAMlGKFomlCc=;
        b=Zkkf5UffhNxymwfld6cAfiCd70AiDJFK66Spk8+F66vvKkfQwB9MU/GapbW+JFQ1vc
         AipYJ8Mvg7epGMMZvXRUIROGIm98zIJXxYtAEyHvjHK83tKdLrstQoDdpoTUm/rvpAee
         MQK1hXVHiB2XyDRlXHPV63JUUMHQtKvPglfTl/YDFziOGJVw4TYFki7xv1BZWJlzjb2H
         fIViGgAR4yOOKqYlmjzNF06UkTbGYzQYogfH8Ks8sLiKz214u+nm/qwfWgW9FUEraVno
         OSx3bWwDqcngfZCQzZ/5WCzU8ErojoLSBW4aR2kvD8X/1wXtU5DnzEJAvxzDoJcsHvAg
         8l3g==
X-Received: by 10.52.175.66 with SMTP id by2mr18002095vdc.53.1361272690493;
 Tue, 19 Feb 2013 03:18:10 -0800 (PST)
Received: by 10.58.55.228 with HTTP; Tue, 19 Feb 2013 03:18:10 -0800 (PST)
In-Reply-To: <CALkWK0kBjsHtK1_7imJx-7CATSKFzpUgGzH6Hs9DAQ8c7jRUPw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216605>

2013/2/19 Ramkumar Ramachandra:
> No.  I don't see why push.default is limiting.

I just want to find a way to exclude a branch (or infact a group of
branches) from $git push --all.
so when I read your thing, I thought for a second that it could be a
possibility... But seems its not the case.

... or branch.<name>.pushremote can support some kind of a "none" value?

Blind.
