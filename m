From: John Szakmeister <john@szakmeister.net>
Subject: Re: [PATCH] git-web--browse: recognize iTerm as a GUI terminal on OS X
Date: Tue, 26 Mar 2013 04:54:42 -0400
Message-ID: <CAEBDL5Vx0vjAKUeFrXgpx7mYxk8B+OQC5yrEii9RMP-5-Sjhsw@mail.gmail.com>
References: <CAMxBVSs6dJFnK78E2Da7t4V9ndJFRVDZEd1fR5QuCFz=u2Bnpw@mail.gmail.com>
	<CAMxBVStw-b3J_Fm9x=h3==9ebdLUkpjBSQ9-W4+zJ9N20ojfxg@mail.gmail.com>
	<CAP8UFD2oR5tnYuw7Nbe-CzGx7fw-OpAFW+reN+1Nroh1jXjfsQ@mail.gmail.com>
	<CAMxBVStVXZGGrjHzN7kukVP6_ZGo0miyJaE2FVYPVV4Jb5U82w@mail.gmail.com>
	<CAEBDL5VNodcTGBOvQjyL30qiXhshxhnUH-Vd9xy9=RxZQgH-Yw@mail.gmail.com>
	<CAP8UFD2m8n5RHN-CgyDP1ir_AorpJGnWwNhXuRxDa=DbHfsdiw@mail.gmail.com>
	<20130325101318.GA31409@yoda.local>
	<7vtxnzw3wu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <christian.couder@gmail.com>,
	Timo Sand <timo.j.sand@gmail.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 26 09:55:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKPf3-0003Vv-2K
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 09:55:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759629Ab3CZIyt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 04:54:49 -0400
Received: from mail-wi0-f169.google.com ([209.85.212.169]:49008 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755029Ab3CZIyr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 04:54:47 -0400
Received: by mail-wi0-f169.google.com with SMTP id c10so421850wiw.4
        for <git@vger.kernel.org>; Tue, 26 Mar 2013 01:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=4vtVNy225M47ZYqBtDx+wyExljEeDR8wkiZe3iZNdek=;
        b=DEbqM//mcQFqeLdYe6DtkiK4lGGLdL/s/+LtQHmyN2qFI63u34f+7IpFBZziZ9Jd7N
         68L/nJadEAuy/yCG1+kB+IV7BWHg71NsDVlN5iBqvuel4X8J+F3aV1dg6cHt80+bcfIW
         dFtiFENSbeMayuD1rVMOjDx+JloGNsQTzRFn0JjH33d+WiZh9iSBf6Doqr7HSasy7A+c
         +JiPoQqE9Rgky++AsrUnAWXHPVOcS8cteoQF7lfBTxra2L3ae1duC4KTwplhAwKwqphW
         pbRC17Cx3ZQgkqBdPVBrk9fcvrDKbrIBMLtUPYirGw971HKUASZNi1c09uaL5Ppy+g1R
         rYVw==
X-Received: by 10.194.20.40 with SMTP id k8mr23225249wje.16.1364288082400;
 Tue, 26 Mar 2013 01:54:42 -0700 (PDT)
Received: by 10.180.79.6 with HTTP; Tue, 26 Mar 2013 01:54:42 -0700 (PDT)
In-Reply-To: <7vtxnzw3wu.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: LN3E8V3wjyOeE47xhqRX2hUBX_g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219146>

Sorry about the repeat Junio, I meant to hit "Reply to All".

On Mon, Mar 25, 2013 at 5:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
[snip]
> Your patch makes me wonder if
>
>         test -n "$TERM_PROGRAM"
>
> without any SECURITYSESSIONID or explicit program name checks should
> suffice, though.

So, after downloading a couple of other terminals and trying things
out, I think you're suggestion does suffice.  Should I send an updated
patch?

-John
