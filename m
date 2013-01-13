From: Ping Yin <pkufranky@gmail.com>
Subject: Re: How to setup bash completion for alias of git command
Date: Sun, 13 Jan 2013 11:13:18 +0800
Message-ID: <CACSwcnRs3vxm0L4XrD0mUvgmQfz=qQH1yT7fX9kBwODiWcuxzQ@mail.gmail.com>
References: <CACSwcnQu8Rx83mcGYR6NGzEhoreNR6DfiK876LF7pa9PGm30JA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 13 04:21:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuE90-0003OX-AR
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 04:21:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754448Ab3AMDTe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2013 22:19:34 -0500
Received: from mail-ia0-f176.google.com ([209.85.210.176]:55856 "EHLO
	mail-ia0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754239Ab3AMDTe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2013 22:19:34 -0500
Received: by mail-ia0-f176.google.com with SMTP id y26so2679905iab.35
        for <git@vger.kernel.org>; Sat, 12 Jan 2013 19:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=eeKLwR5eqg4V0TwA1EPOKoT4Qm29lZde2kHw62v0yy8=;
        b=ZV0P5jh0QyQWBzDqTmOz7dwHPK5Io0M0E+YNDsDs+0KdEfuP+V0q0tbIrjUwAONB4P
         Kl7gmmEh8Y20J5UBI6warqD48QsJ3L+jBcl8LAt02kdxQqL8TEm/rBQOhbK2jS2svx+e
         tctbifl2B1QSCFjvc2p2Xkz5McDonrbjhoI2NRsE5L4iqWbe+cUOtWaMmnITczamODfr
         0VU7fTYKUw9S4zzhLxrBcq6MFl372R08xTvkYnV67gLYnQD2eg8aMhBiMznJTIgnvHzp
         8UK+r9Tu25FqbjNe0gvmMMVo+us8P1EandqD4wLPDRPH2eFGOCG8MhivaGXn8RpE3J4T
         1uuQ==
Received: by 10.42.49.15 with SMTP id u15mr47895852icf.6.1358046798385; Sat,
 12 Jan 2013 19:13:18 -0800 (PST)
Received: by 10.231.133.10 with HTTP; Sat, 12 Jan 2013 19:13:18 -0800 (PST)
In-Reply-To: <CACSwcnQu8Rx83mcGYR6NGzEhoreNR6DfiK876LF7pa9PGm30JA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213328>

On Sat, Jan 12, 2013 at 10:30 PM, Ping Yin <pkufranky@gmail.com> wrote:
> Following setup works for me  in ubuntu (10.04,11.04) for a long time
>
> alias gtlg='git log'
> complete -o default -o nospace -F _git_log gtlg
>
> However, in debian (testing, wheezy), it doesn't work
>
> $ gtlg or<TAB>
> gtlg or-bash: [: 1: unary operator expected
> -bash: [: 1: unary operator expected
>

with newest git version built with next branch, the same problem remains.

Ping Yin
