From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: [PATCHv2 2/2] git p4: add support for 'p4 move' in P4Submit
Date: Wed, 7 Nov 2012 21:06:58 +0000
Message-ID: <CAOpHH-VRhOHqeROfjeLBQxqft23VemJZntGNJ-y7CX0A8N3q1A@mail.gmail.com>
References: <1342135740-30290-1-git-send-email-pw@padd.com>
 <1342135740-30290-3-git-send-email-pw@padd.com> <loom.20121105T183530-627@post.gmane.org>
 <20121105175724.GB889@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Pete Wyckoff <pw@padd.com>, ggibons@perforce.com
X-From: git-owner@vger.kernel.org Wed Nov 07 22:07:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWCqd-000380-ED
	for gcvg-git-2@plane.gmane.org; Wed, 07 Nov 2012 22:07:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444Ab2KGVHa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2012 16:07:30 -0500
Received: from mail-ia0-f174.google.com ([209.85.210.174]:36216 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751018Ab2KGVH3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2012 16:07:29 -0500
Received: by mail-ia0-f174.google.com with SMTP id y32so1421721iag.19
        for <git@vger.kernel.org>; Wed, 07 Nov 2012 13:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=qY063p9qdVrCA3/e2UMgleH0hQxyTMOWTEu1lPGhsZM=;
        b=Gla/bCq5tzP2VG/5tDOJthDsInHl5CpCw6ct94t/4jTF3aqyCjutwdJU6q8MB59tl9
         8jMmrw6QCqpmr3nB/uymjJeNFOXayY+CT8y6UuhrMhyeVcmC2X/vwjeP2s8Q6LRS1+Vj
         ka0GRYLFv81HoU3oad7txMP1iO2+rGaSUZ6zValYbtGr8gvkr/5fgyuWPd1MgoamtaFz
         WlzDFyEf+vSqRKhbbhlzqM33bGSNxeducUAHORF9y1cbHwlcy6KU72EKLb4GGxLYW4Br
         A9XFuYrLBLLHuFxOHwRFHxLUQQ6ZLxbC62q9yhXq9/G0f+L10BOi/QfAii8hGGYWdPeI
         kzlw==
Received: by 10.50.17.162 with SMTP id p2mr6130555igd.9.1352322448857; Wed, 07
 Nov 2012 13:07:28 -0800 (PST)
Received: by 10.64.81.33 with HTTP; Wed, 7 Nov 2012 13:06:58 -0800 (PST)
In-Reply-To: <20121105175724.GB889@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209140>

On Mon, Nov 5, 2012 at 5:57 PM, Pete Wyckoff <pw@padd.com> wrote:
> vitor.hda@gmail.com wrote on Mon, 05 Nov 2012 17:37 +0000:
>> Hi Pete,
>>
>> I've just been hit by a situation where this command is available but is
>> disabled in the server. I don't know what is the best approach to avoid
>> this issue.
>
> Really?  The command exists in the server because it returns the
> text output for "p4 help move".  But "p4 move" itself fails
> because it is somehow disabled in the server?
>
> I didn't even know it was possible to administratively disable
> commands.
>
> What's the actual error message?  And versions of your client and
> server (p4 -V, p4d -V, p4 info).
>
> Any ideas Gary?

I don't feel comfortable in testing this again because I'm working in a
production server. Can Gary provide any details on this type of
configuration on the server side?

Vitor
