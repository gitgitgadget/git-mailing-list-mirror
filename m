From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: GSoC Improving parallelism in various commands
Date: Sun, 25 Mar 2012 10:10:23 +0700
Message-ID: <CACsJy8CL1foxWFsLiThHkF5yarTqpFkYTsfbHFxvEYq9BWD1_Q@mail.gmail.com>
References: <CAM6-U1QwaMiSHcRvzgwQVYfAU7=v9gxiAaRrcVBmPpWw2wic4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: John Gamboa <vaulttech@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 25 05:11:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBdrj-0004Wc-2J
	for gcvg-git-2@plane.gmane.org; Sun, 25 Mar 2012 05:11:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754698Ab2CYDKz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Mar 2012 23:10:55 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:45503 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753564Ab2CYDKy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2012 23:10:54 -0400
Received: by wejx9 with SMTP id x9so3492796wej.19
        for <git@vger.kernel.org>; Sat, 24 Mar 2012 20:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=6loxjJKmN9vyYNOHTqomeR0cATYXqPtsRJ62c8ORQKM=;
        b=ZHbFZj/SDFCLpLs8d0g1zinbyD2SgPLPDYkHea4jZyzkX2Y0As9rb9o9fc2JLNdfQg
         V4kovhRf++fFb5D+zCtZOYlZaHIJF3iKJLTxUgHrjs9kA0YtuPNTf0LGR2Uipq4Gf88t
         jkFXgnAn6/EuYeb/jqWZa5VRcYDoaNX6o8N4ZWJEm4qa9r7W3LafbDRh4eHk+Iy0Cxx8
         iIcThdd9ATkG2+pFva9+FM40bAKdP/LIUfIy1hFaWxwypLvXAemEwivK7LWd3HGpS8RX
         XSL+9i7Vg/tipoIy9PC6Hd8gxNsSibB9VqxkMI2kPPs1gctFDXGx+kZ5EvGxkd8jN55G
         xU3Q==
Received: by 10.180.80.40 with SMTP id o8mr8481713wix.10.1332645053321; Sat,
 24 Mar 2012 20:10:53 -0700 (PDT)
Received: by 10.223.109.144 with HTTP; Sat, 24 Mar 2012 20:10:23 -0700 (PDT)
In-Reply-To: <CAM6-U1QwaMiSHcRvzgwQVYfAU7=v9gxiAaRrcVBmPpWw2wic4w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193858>

On Sun, Mar 25, 2012 at 4:06 AM, John Gamboa <vaulttech@gmail.com> wrote:
> Is there any place where I could find more information on what
> commands are already parallel?

pack-objects, grep, index reading and (soon) index-pack.

> And do anyone have any idea on how many
> commands could benefit from parallelism? As I said, I never touched
> the Git code. Would someone recommend me to take a look at some place
> at first?

See http://thread.gmane.org/gmane.comp.version-control.git/193352/focus=193574.

I'd recommend Documentation/technical/pack-format.txt and sha1_file.c
(start with read_sha1_file)
-- 
Duy
