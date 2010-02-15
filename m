From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v3] Detailed diagnosis when parsing an object name fails.
Date: Mon, 15 Feb 2010 15:16:05 +0100
Message-ID: <fabb9a1e1002150616h6a747f58q41eecf84dac736fb@mail.gmail.com>
References: <vpqws0zcd1c.fsf@bauges.imag.fr> <1260180650-613-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Feb 15 15:16:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nh1kW-0001Pp-Id
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 15:16:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754779Ab0BOOQ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 09:16:27 -0500
Received: from mail-pz0-f197.google.com ([209.85.222.197]:49100 "EHLO
	mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751805Ab0BOOQ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 09:16:26 -0500
Received: by pzk35 with SMTP id 35so249236pzk.33
        for <git@vger.kernel.org>; Mon, 15 Feb 2010 06:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=jXEV5zXrr0SxqmFA3QF1gVx5Mg+s2F1fiKbOB1PENbM=;
        b=T7t3qGVZDfUW8do8u1a+A2K90vbOzD+48HuUsoKIE3ju/ML+MEXKYZE+wBkqDBzCHN
         ASRt/0EG4vuGFPt9gDwmiU0/VThOODFXjdOVVXzasYowxLAtNcPWcivWeWE1K89XjxLu
         ODIAI2OHD0u5S7r331QwKQXK1S+LLv4hMQNhI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=d3zsxskQITRvxOVP8dcc1Dy2P74yGNG/CG6H9GYLzpQXvwKRYWc5vm6m/YT+N1GK5x
         zGnX2WstYM7ZH+cpTdxusbfps1pW3/73b8/l2eEce2DOoZgDxvnFciYvyqG4l4BVjM/j
         ag4d4KtGU3Y6sMjdMEqdwOAqTJhg0ZxYuxC1E=
Received: by 10.142.67.13 with SMTP id p13mr3475906wfa.54.1266243385094; Mon, 
	15 Feb 2010 06:16:25 -0800 (PST)
In-Reply-To: <1260180650-613-1-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140010>

Heya,

On Mon, Dec 7, 2009 at 11:10, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> The previous error message was the same in many situations (unknown
> revision or path not in the working tree). We try to help the user as
> much as possible to understand the error, especially with the
> sha1:filename notation. In this case, we say whether the sha1 or the
> filename is problematic, and diagnose the confusion between
> relative-to-root and relative-to-$PWD confusion precisely.

Thank you, I just got helped by your patch, and was very pleasantly
surprised to see git being so unusually helpful! We'll make a
user-friendly scm out of git yet :).

-- 
Cheers,

Sverre Rabbelier
