From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/3] test: improve rebase -q test
Date: Sat, 8 Jun 2013 05:15:52 -0500
Message-ID: <CAMP44s012kdYH5tRBnH4ijsGuVVDUe1Zbo4XkFx+wQNwOt_trg@mail.gmail.com>
References: <1370637143-21336-1-git-send-email-felipe.contreras@gmail.com>
	<1370637143-21336-3-git-send-email-felipe.contreras@gmail.com>
	<CACsJy8DHeqOz=WbxurCvPiDq73k4eftwrEEZzWBbifS51PDbLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stephen Boyd <bebarino@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 08 12:15:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlGBj-0004ge-E0
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 12:15:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751972Ab3FHKPz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jun 2013 06:15:55 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:42574 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751924Ab3FHKPz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 06:15:55 -0400
Received: by mail-la0-f48.google.com with SMTP id lx15so3378760lab.21
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 03:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=o7dTFpKpHgMyxqp6UvAe7m6NLrMgTYxThI+leVSIcmI=;
        b=iLfstXOpMJeylEmWN3n/w4GBMeq9wtPOah1RCsYi/EneLZbTHm+YGGnZSdkyqOU7xl
         cQTkxgqxOXd8f/S+CsxiqpwP+J3hfHMllceXZtM/2rqnixEEU/2lLNBX6MDrh1VfukyX
         Te5olLxO8rlbX3x7YVF/Xd0FRDwxuMq+0iTkzNXrEktOplHk9e8Twc3r1/b0gOCSbW5A
         r0Ihz3t0X0lA/W2G6KTkQLbgWgqydZXoJKSQKDD4FHsYFsGCqH6VYPL1kDAsbDv4RDww
         KHJRaQ96oDvu++mIkK5+R4yaMoRoYzt3Nb0lJkpWPmlWRdm7HsBgq+nYKI01OrzJPl1c
         atPQ==
X-Received: by 10.112.52.97 with SMTP id s1mr2897103lbo.8.1370686552264; Sat,
 08 Jun 2013 03:15:52 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sat, 8 Jun 2013 03:15:52 -0700 (PDT)
In-Reply-To: <CACsJy8DHeqOz=WbxurCvPiDq73k4eftwrEEZzWBbifS51PDbLQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226797>

On Fri, Jun 7, 2013 at 9:44 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sat, Jun 8, 2013 at 3:32 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> Let's show the output so it's clear why it failed.
>
> I think you can always look into trash-directory.t3400 and figure why.
> But if you show this, I think you should use test_cmp to make it clear
> what is not wanted. Something like
>
> : >expected &&
> test_cmp expected output.out

Feel free to send that patch. I'm done with this one.

-- 
Felipe Contreras
