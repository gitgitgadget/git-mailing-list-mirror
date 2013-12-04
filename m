From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] mv: let 'git mv file no-such-dir/' error out
Date: Wed, 4 Dec 2013 20:10:05 +0700
Message-ID: <CACsJy8BdXkzzZpEaOvqkJ8ckubbQ0ArOMUT8qnMHMDscupfj_A@mail.gmail.com>
References: <1386059524-14442-1-git-send-email-Matthieu.Moy@imag.fr>
 <CACsJy8CfvdT2LgRHax3P6k94C3S9ScB4fuNRm7bZWGXRW=NqKA@mail.gmail.com> <vpqa9ghhunu.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Dec 04 14:10:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoCDx-0002Up-LI
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 14:10:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359Ab3LDNKh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Dec 2013 08:10:37 -0500
Received: from mail-qc0-f180.google.com ([209.85.216.180]:38131 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932274Ab3LDNKg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Dec 2013 08:10:36 -0500
Received: by mail-qc0-f180.google.com with SMTP id w7so3374128qcr.25
        for <git@vger.kernel.org>; Wed, 04 Dec 2013 05:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=JZOsZpAVQwhAUCc90cc5dYhga2MI2pJrsHOvBGS9+zc=;
        b=qZl+IbjH/rh84/eS9rWDbTIu01KbH1b6u6vfJoKpfj/4av8p91SwyEYW6fX8HBrBqL
         9OV1oCUVLKfut0JfNHteYoRnAYt2nm273xSwe/xc5mYIL9Up4hb7MAN9iAsXqAguJGTT
         3l7fvy4s69AttR0Y3ivODMrQ7SCujzpWP3/yWT6077EEQI3gbx4pHTJ6NKgl3sAXWkeV
         tvwV9fCyIgE/Tg/I6O0ii2XbTCFiJpgvH3hV8G3yvJF2xbKmxK5Xvywzo1d/UzQK+sZZ
         CcZkLzpw9uOUskGzucqgTp2211vO+nVm7kZd9D2Q3YVqX9nlOlx/HBTpBaxbIZOy8ioc
         cbxQ==
X-Received: by 10.49.12.102 with SMTP id x6mr136127356qeb.5.1386162636175;
 Wed, 04 Dec 2013 05:10:36 -0800 (PST)
Received: by 10.96.124.101 with HTTP; Wed, 4 Dec 2013 05:10:05 -0800 (PST)
In-Reply-To: <vpqa9ghhunu.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238776>

On Wed, Dec 4, 2013 at 3:44 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Tue, Dec 3, 2013 at 3:32 PM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
>> There's something we probably should check. In d78b0f3 ([PATCH]
>> git-mv: add more path normalization - 2006-08-16), it mentions about
>>
>> git mv something/ somewhere/
>>
>> there's no test in that commit so I don't know the actual input and
>> expected outcome.
>
> To me, the expected outcome is "behave like Unix's mv" (which works with
> or without the trailing slash if somewhere exists).
>
>> If "somewhere" is a directory, it errors out with this patch and works
>> without it.
>
> I can't reproduce. I've added this to my patch (indeed, the area wasn't
> well tested), and the tests pass.

Now I can't either. Probably some mis-setups or some local bugs in my
tree. Good that we have more tests.
-- 
Duy
