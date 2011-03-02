From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH/alternative/raw and rough] setup.c: denote repo wide
 pathspecs by ':'
Date: Wed, 2 Mar 2011 07:12:16 +0700
Message-ID: <AANLkTim2HmBEQv=buRG7-87+c99FnsxXUTQzKy__azfM@mail.gmail.com>
References: <AANLkTi=xrnxUtkayyW1Merh49N6uHy5p-GMrYe6+p==t@mail.gmail.com>
 <bc49592f5e524a0d12aa55eeca1c5ca659b6525f.1298974647.git.git@drmicha.warpmail.net>
 <AANLkTimJ7QsPTW0Vm9JgYVbcRQRoTnuiXUxOK=0unk6P@mail.gmail.com> <4D6CD593.2090705@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Mar 02 01:12:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuZgT-0000PU-0z
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 01:12:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757254Ab1CBAMs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 19:12:48 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:48742 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756679Ab1CBAMr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 19:12:47 -0500
Received: by wyg36 with SMTP id 36so5269008wyg.19
        for <git@vger.kernel.org>; Tue, 01 Mar 2011 16:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=2cvTdvumLuZrlbpzw0DzT44ulKgPIpxZrE5Q78wCfg4=;
        b=cTRRTaW4gqmMXy+b6lHnuPnony2QyhIbaxuV4O+bPHpDe8pyQAlFC0hlU140X/KFKT
         1c2OuxEPyI4u6GDfplL+pCCNhVdznvF4OuIpmlqs14t01eCiFl0Yp5fSp2aOHji6tvXS
         3QTI9GJzXas1RRBXwvbnBs/ptDGc5nWwFBJxE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=O162ENa6W+LBEpPkkRlIt3LHo+k1i+s0vE2z9C36k+jLcuUdQh2rKGqBQioRt1EfZg
         BHdd8Wx3HooouPf5aA3K/SkbJp8AK5GZEVaIrHeNkb/FU7zv69KxAG547wJI/Eem/2Kn
         39p5NAx1XDV9iBdjo0T+t+6H+Tr1knxnn2+pk=
Received: by 10.216.87.130 with SMTP id y2mr6628744wee.58.1299024766143; Tue,
 01 Mar 2011 16:12:46 -0800 (PST)
Received: by 10.216.239.5 with HTTP; Tue, 1 Mar 2011 16:12:16 -0800 (PST)
In-Reply-To: <4D6CD593.2090705@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168283>

On Tue, Mar 1, 2011 at 6:16 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Nguyen Thai Ngoc Duy venit, vidit, dixit 01.03.2011 12:13:
>> 2011/3/1 Michael J Gruber <git@drmicha.warpmail.net>:
>>> Introduce a leading ':' as the notation for repo-wide pathspecs.
>>>
>>> This is in line with our treeish:path notation which defaults to
>>> repowide paths.
>>>
>>> Heck: Even ':./path' works for pathspecs, and I have no clue why!
>>
>> If you are going to turn pathspecs into something more complex,
>> reserve room for future extension. I have negative pathspecs that can
>> utilize it.
>>
>> I take it, from now on people must refer file name ':foo' as './:foo'
>> with your patch?
>
> That is up for discussion, of course. When discussing a new approach for
> file mode dependent attributes, I was hoping to get through with
> symlink:path, and did not. But it was decided that something like
> :symlink:path would be good enough, in the sense of avoiding enough
> possible conflicts. That made me hope that :path would be, too.

Good morning! I'm saner now. How about :/path? That would reserve
anything next to ':' except '/'.
-- 
Duy
