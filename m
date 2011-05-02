From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH/RFC 0/4] grep: support to match by line number
Date: Mon, 2 May 2011 13:54:37 +0200
Message-ID: <BANLkTi=NOaWN56qBACoTE2WQWFM3rHXfWA@mail.gmail.com>
References: <cover.1304318972.git.bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Mon May 02 13:55:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGrim-0000aX-3L
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 13:55:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753410Ab1EBLzT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2011 07:55:19 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:43941 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752948Ab1EBLzS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2011 07:55:18 -0400
Received: by qwk3 with SMTP id 3so2577971qwk.19
        for <git@vger.kernel.org>; Mon, 02 May 2011 04:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=ZXizJvwYjLOFte4DaDhzW73mAODt8nTzBa1J17NIz6A=;
        b=CvPE+R1pLWGUY2SMMN23qL/ecmLxqXDBA1VCAG9srVr92PZZ46yF5zphEL8x0CwmhR
         duxwn21wIbP5m9r8UyO8kx+dB6uHwp8/NQmgpq8zxHwHk5tZ0QizJjS1/g6Rro8JKdYa
         YsqnimddSNSyL/QsXatYPq2aEKU2GMMjq0WiE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=cQF4vVvn+3ygGrIAV/S/bht+ZI1CA3q6X7b1nwUaUp1jxceXOvgDlLdEJzvkJZTN5B
         EC3gm6JBJNvdi6FcfjDJzyS+AL6lLEwmeM9sBh/q6yfGvgrAUd9T7NXt/XdN+8HPR+uL
         vJk+rIm+2ftZUuOJlFt/vH2fySKyIXfRWBFIE=
Received: by 10.224.180.80 with SMTP id bt16mr5712683qab.134.1304337317270;
 Mon, 02 May 2011 04:55:17 -0700 (PDT)
Received: by 10.229.75.70 with HTTP; Mon, 2 May 2011 04:54:37 -0700 (PDT)
In-Reply-To: <cover.1304318972.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172577>

Heya,

On Mon, May 2, 2011 at 13:39, Bert Wesarg <bert.wesarg@googlemail.com> wrote:
> This series will teach git grep to match at specified line numbers. This is
> particular usefull, if you want to see the lines which emits warnings or errors
> from a build run (where you only get the line number) and present it nicely to
> the user with function and context lines.

Can you give a concrete example of how you'd use this? I'm not sure I
understand the described use case.

-- 
Cheers,

Sverre Rabbelier
