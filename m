From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: git log --since --until
Date: Wed, 4 Jan 2012 13:46:59 -0800
Message-ID: <CAE1pOi30FL+hRSqr3XRNgvOr4yBcTsbTpiNXpxJ=CN1Q=JVo3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Users <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 04 22:47:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiYfr-00069L-4O
	for gcvg-git-2@lo.gmane.org; Wed, 04 Jan 2012 22:47:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756853Ab2ADVrB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jan 2012 16:47:01 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:64533 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756829Ab2ADVrA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jan 2012 16:47:00 -0500
Received: by qcqz2 with SMTP id z2so10669353qcq.19
        for <git@vger.kernel.org>; Wed, 04 Jan 2012 13:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=hyXPDa3fTgItOAiBBMoDYkDenASZa8eA3JsvxNrekV4=;
        b=QGKOjIapLCIew22viBVzgficiwodSorXwcwIE50QRcoKmSdRCYTaoVyismMNqvqUCr
         6Qeo44xMKkkOirNm0YwiSxmzD2dUs+AeC7ISFvzs2zeCBfESI5OW6jkfOV/DFUMXQVql
         5ohYDK652iK76T9ZW49ycf06fe+Nqo0kLFPr4=
Received: by 10.229.69.79 with SMTP id y15mr22224796qci.73.1325713619791; Wed,
 04 Jan 2012 13:46:59 -0800 (PST)
Received: by 10.229.191.140 with HTTP; Wed, 4 Jan 2012 13:46:59 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187944>

Hi all,

I need to write sort of a report listing what we worked on (month by
month) over the last year. Yippie. ;-)

Luckily most of the information I can get from our Git logs but I
noticed some "anomalies". The quotes are there because I do understand
(or I think I do anyway) why those "anomalies" are there.

As an example, I ran (on master)

git log --since="01-Dec-2011" --until="31-Dec-2011"

The returned list of commits also included a few from November. I'm
guessing that's because --since and --until simply determine a start
commit and an end commit in master and any commit that falls in that
range is included, whether its actual commit date is in the originally
specified date range or not.

Is there a way to just get the commits made in December? (I can
manually go through the list, of course, [and that's probably what
I'll do] but playing with Git is more fun than writing a report. ;-) )

Cheers,
Hilco
