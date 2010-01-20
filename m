From: John Tapsell <johnflux@gmail.com>
Subject: Re: git locate
Date: Wed, 20 Jan 2010 11:07:05 +0000
Message-ID: <43d8ce651001200307r651a6a54ib298c4b708016b11@mail.gmail.com>
References: <43d8ce651001191717l58d10919j691f4e5b056fe9b5@mail.gmail.com>
	 <m3zl49bk0o.fsf@localhost.localdomain>
	 <alpine.DEB.1.00.1001201021060.31129@intel-tinevez-2-302>
	 <201001201106.20739.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 20 12:07:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXYP3-000439-JO
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 12:07:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753167Ab0ATLHH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Jan 2010 06:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752352Ab0ATLHH
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 06:07:07 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:52647 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752972Ab0ATLHF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jan 2010 06:07:05 -0500
Received: by pwj9 with SMTP id 9so3081104pwj.21
        for <git@vger.kernel.org>; Wed, 20 Jan 2010 03:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=cWtOV1kkwQknitmcEzFtzUsQLYPgyFb1FyXPKxHWjzU=;
        b=X0XwaXAJqS4rDtUbi08PR7b9oSnJT5/YGnB47BctmoYFe1D+sm2QuYc1jWS/WkEkv9
         gxjNFuMoT8CCWiAb6wM7towbmbUxBMfIZJUALPs0J+rU/7EI9Dp+H0fP4uQh8j7bofLl
         7Uh0zC1WQytsYB2ConjidD+JLOCBQUfiX2kk0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=h/v7KVzPAz5U4+yQCgeZL4LqsfJeFCBGJtm9A0xsWb7Ycn828B7V9WCtBPmN3w7sOv
         /6OEY2nFDdG6+c6VpyB/7GF67lnq+wPj7fOmXloIC7aqmABLewQBMpJYNu/nRn11OmTP
         qe+KRaKATGJ8/f3Egb2+L21aw8795dxvvcAXM=
Received: by 10.114.30.7 with SMTP id d7mr6152675wad.30.1263985625086; Wed, 20 
	Jan 2010 03:07:05 -0800 (PST)
In-Reply-To: <201001201106.20739.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137543>

2010/1/20 Jakub Narebski <jnareb@gmail.com>:
> On Wed, 20 Jan 2010, Johannes Schindelin wrote:
>> On Tue, 19 Jan 2010, Jakub Narebski wrote:
>>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>>> On Wed, 20 Jan 2010, John Tapsell wrote:
>>>>
>>>>> =C2=A0 Could we add a: =C2=A0git locate <filename> =C2=A0 =C2=A0 =
=C2=A0 or git find <filename>
>>>>
>>>> How about "git ls-files \*<filename>"?
>>>
>>> Or "git ls-files '*filename'...
>>>
>>> ... but how to make an (git) alias for this?
>>
>> Add something like this to your $HOME/.gitconfig:
>>
>> [alias]
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 locate =3D !sh -c 'git ls-files "\\*$1"'=
 -
>

I think having this alias by default would be very nice though - it's
pretty common to locate/find files, and it's nice to have unixy
equivalents in git.

If this really isn't wanted, then perhaps the ls-files command should
be bash auto-completed?

Thanks!

John
