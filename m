From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: partial checkouts
Date: Mon, 25 May 2009 11:51:46 +1000
Message-ID: <fcaeb9bf0905241851i768b4c5bl9bca9faeb12ff4a@mail.gmail.com>
References: <200905231401.11651.chanika@gmail.com> <fcaeb9bf0905231907q16160ad1t8aa8ef71e2adc8b0@mail.gmail.com> 
	<18071eea0905240857x2433e7a1x5776def3209afbf5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Chani <chanika@gmail.com>, git@vger.kernel.org
To: Thomas Adam <thomas.adam22@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 25 03:53:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8PNi-0007xq-HG
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 03:53:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754079AbZEYBwH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 May 2009 21:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753862AbZEYBwG
	(ORCPT <rfc822;git-outgoing>); Sun, 24 May 2009 21:52:06 -0400
Received: from an-out-0708.google.com ([209.85.132.249]:43524 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753184AbZEYBwE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 May 2009 21:52:04 -0400
Received: by an-out-0708.google.com with SMTP id d40so6538328and.1
        for <git@vger.kernel.org>; Sun, 24 May 2009 18:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=EABsCb8J6/eWhsErSZMmeJA6m5QkL4Td3YOaPudJUvw=;
        b=ds6aHHVx6RsBUDra2IAMG0BMGfwmU9T93rXcDNt+yi5Idvu/tFx/FNojzxDfy6xg4M
         ituJw03O+3a4VZq75GOXwjwyIAlJWH3lLWYxMQT0LmPGsYZXxQK1eMs8+Uk3cIkRFjz6
         inIgSXws+/CfiWPa2usI4iqkH7OzvjIEpZ+sk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=k0I7TRwEopOLhJBC600oEvMca1HBVCK2ts73IFy4sLlbcMUPZRsYD/O0KFBGY4Llzr
         eRPSa0U6CLMirS8DKaSmfm9/1T2SSKV/4YdvGA4wp3pz6aETUDHnc5Wf4UU/dcFDsFow
         DWhE01AXog1KTmlbRcedc2dTVSZ4h0DpZlLyA=
Received: by 10.100.126.15 with SMTP id y15mr11048459anc.14.1243216326097; 
	Sun, 24 May 2009 18:52:06 -0700 (PDT)
In-Reply-To: <18071eea0905240857x2433e7a1x5776def3209afbf5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119882>

On Mon, May 25, 2009 at 1:57 AM, Thomas Adam <thomas.adam22@gmail.com> =
wrote:
> 2009/5/24 Nguyen Thai Ngoc Duy <pclouds@gmail.com>:
>> On Sun, May 24, 2009 at 7:00 AM, Chani <chanika@gmail.com> wrote:
>>> checking out the entire git repo isn't really feasible, because onc=
e KDE
>>> finishes switching to git that'll mean checking out all of KDE.
>>> I don't think that turning every doc folder into a submodule is fea=
sible,
>>> either - they sound kinda awkward to work with, and I can imagine l=
ots of
>>> people getting confused and messing them up...
>>
>> If you don't mind cloning the entire git repo (which may be quite
>> large in KDE case, I guess), then you may want to try "sparse
>> checkout". The patch series is available as a topic branch "tp/sco" =
in
>> this branch:
>>
>> http://repo.or.cz/w/git/pclouds.git?a=3Dshortlog;h=3Drefs/heads/inst
>>
>> Or I can send the patch series to you. It lets you specify what part
>> of the tree you want to checkout.
>
> I recall following this series when you first announced it. =C2=A0Do =
you
> have any plans to try and get it included in mainline? =C2=A0ISTR the=
re was
> some more work needed to be done on it before then.

It was pulled off because of big, intrusive and not well-designed patch=
es.

http://mid.gmane.org/20081128192033.GF23984@spearce.org

I may submit it again when I get code insertions down to ~500 lines or
something like that ;-) Anyway you could always help by giving more
use cases to test against the current design.
--=20
Duy
