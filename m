From: David <bouncingcats@gmail.com>
Subject: Re: Can't get git rebase --onto to work
Date: Thu, 2 Jun 2011 21:18:06 +1000
Message-ID: <BANLkTi=P_-XbmeJiUs2FaEfXLksKM6jRgw@mail.gmail.com>
References: <BANLkTikF7p_XsU6YJ81bq10S3nL6tBsApg@mail.gmail.com>
	<20110602103833.GA4709@Imperial-SSD-Overlord>
	<BANLkTin92KXYO3YF1UytcesWUV-Nh_LaGg@mail.gmail.com>
	<20110602105223.GB4709@Imperial-SSD-Overlord>
	<BANLkTik-o=h05=d5JH_LirYQkNzgdYaZxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Tim Guirgies <lt.infiltrator@gmail.com>, git@vger.kernel.org
To: Howard Miller <howard@e-learndesign.co.uk>
X-From: git-owner@vger.kernel.org Thu Jun 02 13:18:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QS5v2-0004ZU-Rw
	for gcvg-git-2@lo.gmane.org; Thu, 02 Jun 2011 13:18:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753175Ab1FBLSY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2011 07:18:24 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:35139 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751898Ab1FBLSX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2011 07:18:23 -0400
Received: by bwz15 with SMTP id 15so830647bwz.19
        for <git@vger.kernel.org>; Thu, 02 Jun 2011 04:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=hftOhW+CKbrk/fJ4E2E8VSJn4yNw3rmGvUD2Y7YuHJM=;
        b=kv9d3+YiYYr0Q5Zuf7dZGWYQs1p5C1eko1tzyfOHCsH7zAzYE7ButZ1Yv9cj9ajMic
         UhRdNgVnz0fAmgBvQJewmMXsWZGCG9aQpcLhvLmQ9YMNy5rU8s2khFLMkmDT3EDNofiL
         h02aqcATqKTGGCmd+8VekUxVLW8n2YywstVVo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=bn/ikUHSN2JIdHcsHRFT9NbFLdp0GT5DuKatVAPruU3ma5S9y5qtPdsyhm1BH/+T/l
         I2hdtuB+zLs/x0bmqnMMw1834ow82fQjjPd/egWWvULeMUoGcicviwud7kb5+eVSxL1e
         cH75gbX4nw+cb8pES2JIFuShE65y2IF9xMNzI=
Received: by 10.204.136.210 with SMTP id s18mr593408bkt.56.1307013486804; Thu,
 02 Jun 2011 04:18:06 -0700 (PDT)
Received: by 10.204.71.132 with HTTP; Thu, 2 Jun 2011 04:18:06 -0700 (PDT)
In-Reply-To: <BANLkTik-o=h05=d5JH_LirYQkNzgdYaZxg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174942>

On 2 June 2011 20:58, Howard Miller <howard@e-learndesign.co.uk> wrote:
>
> The examples are very helpful but it could be a little more explicit
> which branches are going to get modified by the rebase. Once there are
> several branches in play it becomes quite a hard think.
>
> Mostly, I just needed a kick to say "look where the branch heads are
> pointing" (in the example diagrams) before and after the rebase. I
> don't think I would have got it without the remark in Pro Git that a
> final merge is required to get the HEADs where I wanted them. Like
> most things - it's completely obvious when you know.

If you have a graphical environment, it might help to take a look with
'gitk --all'.
Also, if you start it before the rebase, then after the rebase you
will need to use its "File>Reload" command to refresh the display.
