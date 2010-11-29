From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH 3/6] web--browse: split valid_tool list
Date: Mon, 29 Nov 2010 20:19:06 +0100
Message-ID: <AANLkTik7611p5gun+CmyvOVpcm=_dXVo9FzP_tw7cbRU@mail.gmail.com>
References: <1291042075-19983-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1291042075-19983-4-git-send-email-giuseppe.bilotta@gmail.com> <20101129164435.GI8037@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 29 20:19:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PN9G8-0004BT-9Z
	for gcvg-git-2@lo.gmane.org; Mon, 29 Nov 2010 20:19:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290Ab0K2TT1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Nov 2010 14:19:27 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:36120 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860Ab0K2TT1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Nov 2010 14:19:27 -0500
Received: by ywl5 with SMTP id 5so2251960ywl.19
        for <git@vger.kernel.org>; Mon, 29 Nov 2010 11:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=24OOvmDwBM5QiXBZZDd45OlyCST3L83yxECnBwzL7dU=;
        b=t4gwqZQIlCUZP0u+VpE+ryCpVsCUlEBpjlNf4M2pCWiOIl462j4pi89CuPH754jmQi
         j8zb6oQyfszdSAu+jY6nlFGw2fMqB1fR0nQK+p0tkYT2E0ipcIVw8dEr3Q/+kqxhMpS8
         YA/0riie88lS8zGeHECWbBqv40c9B97wEVqrY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ZRywCbjnPzRqsB9rHBQNES2ELtXaF60IYvBR19pLnhF3X9F1d5COqs4annwKZ5Hj4R
         Ie5cAAXRuXvhyl9kDeyjsCkNT831Wlybv3t3ubcB76UmANpbrMVuzFavIWi66YyDhvd6
         fGdDBxVsc/huawNSvI4aUOwNc+jO7UXgI36pI=
Received: by 10.231.14.10 with SMTP id e10mr6048041iba.132.1291058366469; Mon,
 29 Nov 2010 11:19:26 -0800 (PST)
Received: by 10.231.17.135 with HTTP; Mon, 29 Nov 2010 11:19:06 -0800 (PST)
In-Reply-To: <20101129164435.GI8037@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162417>

On Mon, Nov 29, 2010 at 5:44 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Giuseppe Bilotta wrote:
>
>> --- a/git-web--browse.sh
>> +++ b/git-web--browse.sh
>> @@ -31,7 +31,8 @@ valid_custom_tool()
>>
>> =A0valid_tool() {
>> =A0 =A0 =A0 case "$1" in
>> - =A0 =A0 firefox | iceweasel | chrome | google-chrome | chromium | =
konqueror | w3m | links | lynx | dillo | open | start)
>> + =A0 =A0 firefox|iceweasel|chrome|google-chrome|chromium\
>> + =A0 =A0 |konqueror|w3m|links|lynx|dillo|open|start)
>
> micronit: I think this looks better as
>
> =A0 =A0 =A0 =A0firefox|iceweasel|chrome|google-chrome|chromium| \
> =A0 =A0 =A0 =A0konqueror|w3m|links|lynx|dillo|open|start)
>
> , with the | on the end of the first line.

I opted for the | at the beginning of the line to give a better idea
of the continuation, but I don't have a strong preference in that
direction, so I can fix it up as you suggested, unless there are
specific indications from the 'higher ups' ;-)

--=20
Giuseppe "Oblomov" Bilotta
