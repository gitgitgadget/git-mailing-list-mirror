From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Add new git-remote-hd helper
Date: Thu, 18 Oct 2012 11:38:16 +0200
Message-ID: <CAMP44s0yqBFWFyYx6VdNhq43U1u2S-OPrbKAyMWBGS1n=ffQMg@mail.gmail.com>
References: <1350478721-3685-1-git-send-email-felipe.contreras@gmail.com>
	<alpine.DEB.1.00.1210171759230.3049@bonsai2>
	<CAMP44s1WY+Q7jyy4PQvwff7JSxHsnkhrPWozOLnNuNOrn7FGBA@mail.gmail.com>
	<alpine.DEB.1.00.1210171936170.3049@bonsai2>
	<CAMP44s2=hhMz35SpYXMBLcQPfVaPxY4pBWZDF7zbqVwz=tbedA@mail.gmail.com>
	<CAGdFq_i4c=ei4ni5bv9nNEbCfNG4sbRkqyip2voW17GhkRAKPQ@mail.gmail.com>
	<CAMP44s2-BCuA5v7jE8S3d-Gg+DxKf6Yte9MvTDBDr4jEkLKZ9g@mail.gmail.com>
	<alpine.DEB.1.00.1210181031320.3049@bonsai2>
	<CAMP44s2wOX0-UrTM5t5ewZ4yhOJJU=+SfB9PoTQKdsP4Pzsnpg@mail.gmail.com>
	<7vbog0m8r0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 18 11:38:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOmZ2-0001d6-2e
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 11:38:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755170Ab2JRJiS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2012 05:38:18 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:42836 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754798Ab2JRJiR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2012 05:38:17 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so8330016obb.19
        for <git@vger.kernel.org>; Thu, 18 Oct 2012 02:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=9PkXWHSKdOyRnPROviCeo4D2h53Fb6gYBNX8rG3pvWc=;
        b=giCq4NSR2F8BNwi56cijMX5iAssGALXkASodXxtL8viba6BYXQsg6t8wJrRGgH3pOO
         uN7Q//CapuB2N7StL+yYocoxN4q1PtlPOMOF3iqsb0Hz239UwhS5gr9jW6bgGEwkZvk+
         +lRtUW5R0PhfEl6s16bpFwgnkh/3mw877LWPAtWRnrj1+oMJ1FPkKn6vW3zQ/ciK57zy
         D9/8gHryTtdtyE9YQ25uAw60OODlsr92XQ6oeFRIPksM/LsZPsS1rvxTITWl+2O/n5mP
         7OA+64R+KxeaqBkV/poPtmMZF6qq5Cc7jfn2bMjrG/6dDGYNLRgE4e4HGgW3/g+jhUKu
         1wrg==
Received: by 10.60.170.179 with SMTP id an19mr13313174oec.46.1350553096946;
 Thu, 18 Oct 2012 02:38:16 -0700 (PDT)
Received: by 10.60.58.137 with HTTP; Thu, 18 Oct 2012 02:38:16 -0700 (PDT)
In-Reply-To: <7vbog0m8r0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207988>

On Thu, Oct 18, 2012 at 11:26 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>>> As to the functionality you seek: git-remote-hg found in
>>> git://github.com/msysgit/git works. It has the following advantages over
>>> every other solution, including the one proposed in this thread:
>>>
>>> - it works
>>>
>>> - no really, it works
>>
>> Not for me.
>
> Felipe, an argument along this line would not help very much.
>
> Please elaborate a bit to describe what does not work and where you
> are having problems more concretely.  Even for people who may want
> to see if they agree with your "It does not work", "Not for me"
> alone is too little for them to try out.  Others who may want to and
> are capable of helping you won't know where to start.

Basically what I already described:
1) You need a non-vanilla version of git
2) It's not easy to set up
3) It's not even clear which branch you should be using (in case you
are not using msysgit)

-- 
Felipe Contreras
