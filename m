From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: How to split a big commit
Date: Tue, 5 Apr 2011 09:52:04 +0700
Message-ID: <BANLkTim5j8cezy8jhs9dqPXYJRkRGf0GMA@mail.gmail.com>
References: <BANLkTikFXzut7fY5Tr0u-abu5Q0rMUOCmA@mail.gmail.com> <20110405000852.GA1704@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 05 04:52:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6wNx-00086Z-Kf
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 04:52:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752334Ab1DECwj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2011 22:52:39 -0400
Received: from mail-px0-f179.google.com ([209.85.212.179]:57348 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980Ab1DECwf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2011 22:52:35 -0400
Received: by pxi2 with SMTP id 2so2363348pxi.10
        for <git@vger.kernel.org>; Mon, 04 Apr 2011 19:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=6uqIh1iEZHnD37+KF4ELqL9fFj3rI545ODDbR3h68mk=;
        b=GVgySUdB8Wz0b4DiCdOTfTMVZV/l6VVdFzS4c1kBKtAu0iAB+Upz8p63nuukg38qXu
         HrXqNaPPNL+l35FcPIczQfvL28Cwv5vv4ktx1B7Z6JoCXKSP+sIGr8dPdUGTpA3S1GZr
         yfEtXwwhM6ODqFkwpRjLqqqLOLGhPEJvl86v0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=I4FQM94EmWnSChWxucP+ot5tlVl9y3w0sLfPswACn5VDvcUbsU9LVxXa+wqME2t2qL
         fAQhM7gADfKqwjLj6AQZBA2t6oUS/qnj1ZCa5wkMPtOZeDa08c3zNOylOEeJCtsKdPp/
         9YsnQRPz6hom4QLcL+NSHFOIFk4Qlw907keTg=
Received: by 10.143.87.1 with SMTP id p1mr7013664wfl.271.1301971954159; Mon,
 04 Apr 2011 19:52:34 -0700 (PDT)
Received: by 10.68.54.201 with HTTP; Mon, 4 Apr 2011 19:52:04 -0700 (PDT)
In-Reply-To: <20110405000852.GA1704@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170864>

On Tue, Apr 5, 2011 at 7:08 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi Duy,
>
> Nguyen Thai Ngoc Duy wrote:
>
>> After a lot of small commits and a few mixed up large commits, it was
>> too messy that I merged them all into one big commit then started
>> spliting it into smaller, reasonable patches. Just wonder if anybody
>> else faces the same thing and how they deal with it. I used "git reset
>> --soft <big commit>^" and "git add -N" because there were new files,
>> but it was clumsy.
>
> I tend to do "git reset HEAD^ -- ." and then "git add -N ." and
> "git add -p", for what it's worth.

But you would need to undo "git add -N" for those files you don't want in yet?
-- 
Duy
