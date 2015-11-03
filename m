From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: git gc/prune runs again and again
Date: Tue, 3 Nov 2015 16:01:24 +0100
Message-ID: <CACsJy8DMyjaZ_jKz4B93e6gSgV7ensORqxD-WYOYL9=9SV5tLw@mail.gmail.com>
References: <20151103124420.GA10946@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Tue Nov 03 16:02:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ztd61-0003PV-Dq
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 16:02:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753138AbbKCPB5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 10:01:57 -0500
Received: from mail-lf0-f47.google.com ([209.85.215.47]:33622 "EHLO
	mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751098AbbKCPB4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2015 10:01:56 -0500
Received: by lfbf136 with SMTP id f136so20994360lfb.0
        for <git@vger.kernel.org>; Tue, 03 Nov 2015 07:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=YZjPs0TIU6Lx800S6nmX1aMYZrfQh/SKJp2H0nnVFx0=;
        b=cpYmWyYKieKenMurgQTXMwF0Um4D3MRE/ZxAplaPPBDsEZEXzhGcIyI/GmK9PgLWwo
         zR0kd2Y4Z/lKQYwHGsJZ2ng40tu5dCrNLadFewUVHR9XraQ7T3Bnemn4XbbaXeBWGFfl
         zZt53wq+RwnkZDiT8GSGyCx0FqkGGib+9fwTqf5LY6HHgcT3Yylh+qkvARGm/+gSCRQq
         oZ6IdwqvEQ8WS58NEIpKi8GnQzBzYqc4LouEhMKzxZiI9bUllxpfAnqnKAABqyb7Y0rq
         vLMTR2S5nt2kT16TF02FfYBF/Dd6Pw3rI2CF4JFahPpGfhWgE24tux3/YZKEFC5L2ozH
         eNwQ==
X-Received: by 10.112.202.194 with SMTP id kk2mr12808630lbc.71.1446562914505;
 Tue, 03 Nov 2015 07:01:54 -0800 (PST)
Received: by 10.112.255.229 with HTTP; Tue, 3 Nov 2015 07:01:24 -0800 (PST)
In-Reply-To: <20151103124420.GA10946@inner.h.apk.li>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280799>

On Tue, Nov 3, 2015 at 1:44 PM, Andreas Krey <a.krey@gmx.de> wrote:
> Hi all,
>
> I have a bit of an annoying behaviour in git gc;
> there is a repo I regularly do a fetch in, and
> this kicks off a gc/prune every time. I remember
> there being a heuristic with being that many files
> in .git/objects/17 as the gc trigger.
>
> Which is unfortunate if the gc does not actually
> reduce the number of files there because they
> aren't old enough => gc comes right back.
>
> What can I do there? (This git is a bit old, 2.2.2)

Run "git prune". 2.2.2 hides this suggestion to run git-prune in this
case. The next git version will show it back.


-- 
Duy
