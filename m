From: Eric Frederich <eric.frederich@gmail.com>
Subject: Re: Get a git diff without taking index into account
Date: Wed, 18 Feb 2015 10:42:20 -0500
Message-ID: <CAAoZyYPVopmP_bv7EZS912R4bxpzNm49_q0XXZXqa52dTDDM2Q@mail.gmail.com>
References: <CAAoZyYN-ohiq-Od=u-cd5FRH8=NpJNGS+zEo+NYgwAK7Kjaz_w@mail.gmail.com>
	<CAAoZyYPhiKX1F5ymdSijR7=e8CT1sqaomehBjt-NVDz_A4V4UA@mail.gmail.com>
	<CAPc5daU9km+gr-DHJzJF59mugwGeNX69H27E_DaoyBZnuzoiFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 16:42:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YO6le-0002Xw-Gj
	for gcvg-git-2@plane.gmane.org; Wed, 18 Feb 2015 16:42:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752475AbbBRPmW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2015 10:42:22 -0500
Received: from mail-ob0-f176.google.com ([209.85.214.176]:57227 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752471AbbBRPmV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2015 10:42:21 -0500
Received: by mail-ob0-f176.google.com with SMTP id wo20so3277471obc.7
        for <git@vger.kernel.org>; Wed, 18 Feb 2015 07:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=p/PJpTLut9KCwJZEgNrY/529hIOHSq1G39A8CkIXLc8=;
        b=zx2UohtpFNqNG2fbu367swREouLvpKeMiXAI9KWsNU07p2p8MM/yeXXNj0uVi0WF5N
         TVwYoKs85CzjtzVEwHIBqvjp3YCRXnN9Wo7TrZ7/Knz58BiJbTtCTAPlSHTvOv07b88k
         vCx2+t1JRz7MbQ7VPIb5qDt8qOt4wZAJ4FRdwBfGDw8liW1sRVy/9npyR8KfXoOe/+kr
         FFoncJ+FAfVJjXVSiUgiFp4n1KE92o/oAyRd8MQ7iKMfsh8eLhhzKjJ1WQcUsbLRGow6
         xlGLbBZoEjysfnxaHS9Us3OBDsZQdll+T5DDeaH0DyCNSE5uRtwJyCldqJmrvhf8X2VG
         ppsw==
X-Received: by 10.202.49.138 with SMTP id x132mr21429798oix.7.1424274140620;
 Wed, 18 Feb 2015 07:42:20 -0800 (PST)
Received: by 10.202.12.193 with HTTP; Wed, 18 Feb 2015 07:42:20 -0800 (PST)
In-Reply-To: <CAPc5daU9km+gr-DHJzJF59mugwGeNX69H27E_DaoyBZnuzoiFw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264023>

This is from "git help diff".  It seems to imply that I should be able to do it.
It mentions nothing of the index.

       git diff [--options] <commit> [--] [<path>...]
           This form is to view the changes you have in your working
tree relative to the named <commit>. You can use HEAD to compare it
with the latest commit, or a branch name
           to compare with the tip of a different branch.

On Wed, Feb 18, 2015 at 10:37 AM, Junio C Hamano <gitster@pobox.com> wrote:
> On Wed, Feb 18, 2015 at 7:06 AM, Eric Frederich
> <eric.frederich@gmail.com> wrote:
>> # how can I compare a working directory to a commit without taking the
>> index into account?
>
> You don't.
