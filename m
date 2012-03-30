From: Yuval Adam <yuv.adm@gmail.com>
Subject: Re: Maintaining historical data in a git repo
Date: Fri, 30 Mar 2012 18:55:51 +0300
Message-ID: <CA+P+rLcWT0SZQjW2LtFXXCDRwjMp8daJ2hVup=7cnsRGbKw7xw@mail.gmail.com>
References: <CA+P+rLeyEcZPudhLWavB74CiDAqpn+iNkk4F8=NK_yGaJPMmyA@mail.gmail.com>
 <201203301510.q2UFAqn6003864@no.baka.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 30 17:56:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDeBV-0001gm-Og
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 17:56:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934380Ab2C3P4N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 11:56:13 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:45121 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753190Ab2C3P4L (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 11:56:11 -0400
Received: by iagz16 with SMTP id z16so1141288iag.19
        for <git@vger.kernel.org>; Fri, 30 Mar 2012 08:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=tRKvNcQPaBPy9m4Za/IElqD6FbHjV2H4SIUC1ADmJwU=;
        b=rBtlgnzzNVfasDaSfaH3HxR7Jnjjki6G2zKyNCdjqWan/CH/PD3rY20/aybTbug5oG
         CMqcToxClV54sOnKEMpHkld6VWgLBkSkRt1io5gBskSaNBiKJTYLTq5RRPoH20WjNLOC
         A0/Miv2+ztqjw55/+eIkEmzcgfMVT+y+vECrf1ppy8sVIMYMQPgr/ykUQZtzZbMMyUBR
         PANGruefe13hD9v1yCwJXhwsEwui37weTSGaaEqpCRMvUgHp3AVZFCBpslwhjHQng3uA
         EyMdrBBwCqLkqJNFzfuh8GsF+tBmlOsfwb0NrwAwLBQ8tW9KLR66PtOzKKuqNJchOOBi
         mhhA==
Received: by 10.42.151.133 with SMTP id e5mr556760icw.7.1333122971449; Fri, 30
 Mar 2012 08:56:11 -0700 (PDT)
Received: by 10.42.137.66 with HTTP; Fri, 30 Mar 2012 08:55:51 -0700 (PDT)
In-Reply-To: <201203301510.q2UFAqn6003864@no.baka.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194368>

On Fri, Mar 30, 2012 at 6:10 PM, Seth Robertson <in-gitvger@baka.org> wrote:
>
> Revision control shouldn't be used to change the past (even if git
> allows this with sufficient amounts of pain/warning to all users).
> What it is extremely good at is preserving the past and tracking the
> changes that are made.

This is exactly what we _do_ want to do.

Our use case for this is like so:
"ok, this is how the law is today, and we're not quite sure how it got
to this point"
But then some X time later:
"so we found out that clauses (1), (e) and (X) were changed on March
30, 1957, and we want to know this for future reference"

So, yes, we do need a way of knowing (blaming?) what happened in the
past and how the law was shaped over time.

Is this something that is definitively complicated with git?

-- 
Yuval Adam
http://y3xz.com
