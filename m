From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: How to resume broke clone ?
Date: Thu, 28 Nov 2013 17:20:36 +0800
Message-ID: <CALUzUxrEvuKuN+v-hJLQd5KoV-fzxVYvg5pj7XoLBVap7mgA=Q@mail.gmail.com>
References: <AAA12788-A242-41B8-B47D-1A0A52F33FC1@ancientrocklab.com>
 <5296F343.6050506@gmail.com> <560807D9-CE82-4CF6-A1CC-54E7CCA624F9@ancientrocklab.com>
 <CACsJy8DbJZmBCnfzNqfmEnRpqVcc42Q_-jz3r=sYVRPhsCkS5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: zhifeng hu <zf@ancientrocklab.com>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 28 10:21:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VlxmQ-0001u9-HI
	for gcvg-git-2@plane.gmane.org; Thu, 28 Nov 2013 10:21:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753003Ab3K1JU7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Nov 2013 04:20:59 -0500
Received: from mail-ie0-f181.google.com ([209.85.223.181]:41988 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016Ab3K1JU4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Nov 2013 04:20:56 -0500
Received: by mail-ie0-f181.google.com with SMTP id e14so13602642iej.40
        for <git@vger.kernel.org>; Thu, 28 Nov 2013 01:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=WUzijvnjNsF+ZwCPfsu/hKHPR/bqPgQf7Y2RuntC3FE=;
        b=M5QbqLXBJl3/3rRn37Ucy8KXA0o5w2RPblGEpsc1aUpdzIAb06DbBT/zvnhHmPN255
         uaNkCMs9o1gYZK3WYolnx1IgVUpTzt9OoySoE+2l0HsaX7DCKVhnk19BzA9k+Ul/zsMJ
         huHY2DGMSPVy8Zj+JigHBUPyO2M48c8lAwHHjs96yl/fYacr1tZijQIUMeG1v7NvqOpY
         b37nOKpjdxCIA/dGcWGWdQiLjjuGstK4TKx1+l0IJUJJOD9ls5Wvtg+jsmZkSIaA3tUw
         9JGRfzSLMYMrnfW+BRgfWnKZb0bRZMKGNfe9s8btZzrQB6SG8mvItxi86wd450nYtzUO
         +RNg==
X-Received: by 10.50.26.36 with SMTP id i4mr1244905igg.33.1385630456399; Thu,
 28 Nov 2013 01:20:56 -0800 (PST)
Received: by 10.64.226.195 with HTTP; Thu, 28 Nov 2013 01:20:36 -0800 (PST)
In-Reply-To: <CACsJy8DbJZmBCnfzNqfmEnRpqVcc42Q_-jz3r=sYVRPhsCkS5A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238485>

On Thu, Nov 28, 2013 at 4:14 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, Nov 28, 2013 at 2:41 PM, zhifeng hu <zf@ancientrocklab.com> w=
rote:
>> Thanks for reply, But I am developer, I want to clone full repositor=
y, I need to view code since very early.
>
> if it works with --depth =3D1, you can incrementally run "fetch
> --depth=3DN" with N larger and larger.

I second Duy Nguyen's and Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n's suggest=
ion to 1) initially
create a "shallow" clone then 2) incrementally deepen your clone.

Zhifeng, in the course of your research into resumable cloning, you
might have learnt that while it's a really valuable feature, it's also
a pretty hard problem at the same time. So it's not because git
doesn't want to have this feature.

--=20
Cheers,
Ray Chuan
