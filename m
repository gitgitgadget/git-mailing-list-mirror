From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: sparse support in pu
Date: Mon, 17 Aug 2009 18:43:16 +0700
Message-ID: <fcaeb9bf0908170443r209cbe75xd361bffb4260c32b@mail.gmail.com>
References: <2729632a0908162309ma6e7d41kc3bafe4575120630@mail.gmail.com> 
	<fcaeb9bf0908170117v67e9f8b1ga56edcda14821e91@mail.gmail.com> 
	<2729632a0908170149o425544dcw52aeb6ac6ee1437d@mail.gmail.com> 
	<alpine.DEB.1.00.0908171113420.4991@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: skillzero@gmail.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 17 13:43:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md0cs-0005SG-CB
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 13:43:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757834AbZHQLng convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Aug 2009 07:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757831AbZHQLnf
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 07:43:35 -0400
Received: from an-out-0708.google.com ([209.85.132.241]:61290 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757799AbZHQLnf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Aug 2009 07:43:35 -0400
Received: by an-out-0708.google.com with SMTP id d40so2789998and.1
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 04:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=cehSctIyj4GCMAJP699paMJSvwLxBCLjXwpbvaooonk=;
        b=eyrbda6SPbt3JL+fIhKnlHOeO1Jm0pUX47n3HgPhcj4oF4QpnRwaRCfgCQIzkgTIaT
         ClaisTJQNShlpGn0adwnZIH1XfOYm96m0ltg6kOKoG9AuPIXpH50Tg83Kc26uNYTqfps
         qDOTWjNbwP1DdEkpmp9KdQWIHfdMQvdVgAD8U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=L+momE0V1XE4nRRmIZ8KwYrQAvlXM22QUR8msYe3sgqL/2s9kmApJLdDrZq+md4YVg
         wHUzOVv5Dn7va5k0h94PdCpGRjQ+agNnZ+GvQJJBwD7XYAvvKhUtcwDvW2xdT2fG2m1e
         gKxpS7PVz5LkGH+00xWv8+MgLfYzVBNNBJNy8=
Received: by 10.101.59.17 with SMTP id m17mr3216857ank.13.1250509416144; Mon, 
	17 Aug 2009 04:43:36 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0908171113420.4991@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126160>

On Mon, Aug 17, 2009 at 4:15 PM, Johannes
Schindelin<Johannes.Schindelin@gmx.de> wrote:
>> >> 3. One thing that was confusing is that I needed a trailing slash=
 on
>> >> =C2=A0 =C2=A0directories in .git/info/sparse to get them excluded=
=2E This seems
>> >> =C2=A0 =C2=A0different than .gitignore, which works for me withou=
t the trailing
>> >> =C2=A0 =C2=A0slash.
>> >
>> > Hmm.. probably because Git feeds directories to .gitignore handlin=
g
>> > functions. There is not much I can do, index does not have
>> > directories. I don't know if it's worth generating "directories" f=
rom
>> > index.
>>
>> Maybe just add a note in the documentation? If there's a default
>> .git/info/sparse file then it might be good place to put a note as w=
ell.
>
> I rather think that this should be fixed. =C2=A0Maybe you can come up=
 with a
> patch to the tests which shows this behavior (with test_expect_failur=
e)?
> Then it will be much easier to come up with a fix.

Agreed. Thanks.
--=20
Duy
