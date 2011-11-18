From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: A flaw in dep generation with gcc -MMD?
Date: Fri, 18 Nov 2011 18:34:25 +0700
Message-ID: <CACsJy8BuCdT3rRjc5u6Ex5RRgSbL_0SFF0GW-dTGqet4sG2cwg@mail.gmail.com>
References: <CACsJy8BZMDyf4MCiKxPJ5Z+XS+C-MC82SpMFyWgiXmb9xCnScw@mail.gmail.com>
 <20111118034142.GA25228@elie.hsd1.il.comcast.net> <CACsJy8A44PFtYrm8NQU+48sVkOe8mjJyO9opO5-TwRtAd-TKsQ@mail.gmail.com>
 <buor516m3w7.fsf@dhlpc061.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Fri Nov 18 12:35:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRMio-0002GL-3v
	for gcvg-git-2@lo.gmane.org; Fri, 18 Nov 2011 12:35:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756258Ab1KRLe7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Nov 2011 06:34:59 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:50890 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755480Ab1KRLe6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Nov 2011 06:34:58 -0500
Received: by bke11 with SMTP id 11so3295430bke.19
        for <git@vger.kernel.org>; Fri, 18 Nov 2011 03:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=qLk/7OIisWwyo6xnTCef6VnphKRZAGXMPWycDyaIePo=;
        b=FBhuC4fUR6UY6HA5K1asi5FFHSp3fGgkhDd7Ue3yzhfqTvhJ8gjnrfUyOqFjg1h28d
         NSKwFEA4iSFr0GGdtDIF1EhNy3j3LCsMDx5M7KG8j30xaBf1WpzMZn83iLE1LSEEuFnU
         9xko8DTWoskwhc0uDnOaMKUBBe5jqVc1Be9II=
Received: by 10.204.152.66 with SMTP id f2mr2876589bkw.137.1321616096942; Fri,
 18 Nov 2011 03:34:56 -0800 (PST)
Received: by 10.204.23.2 with HTTP; Fri, 18 Nov 2011 03:34:25 -0800 (PST)
In-Reply-To: <buor516m3w7.fsf@dhlpc061.dev.necel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185653>

On Fri, Nov 18, 2011 at 11:49 AM, Miles Bader <miles@gnu.org> wrote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>>> Interesting. =C2=A0What compiler do you use?
>>
>> $ gcc --version
>> gcc (Gentoo 4.4.4-r2 p1.2, pie-0.4.5) 4.4.4
>
> FWIW, gcc 4.4.6 on debian does the correct thing too...
>

OK it's not gcc problem. I upgraded to 4.5.3 and still had the same
problem. I used ccache though. Without ccache, gcc produced correct
=2Eo.d files.
--=20
Duy
