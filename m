From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv6 03/10] gitweb: separate heads and remotes lists
Date: Mon, 25 Oct 2010 20:14:13 +0200
Message-ID: <AANLkTim-KAcGE1X_bgOQE+0OCA6PJA2wKb36caPvKDUH@mail.gmail.com>
References: <1287917136-26103-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1287917136-26103-4-git-send-email-giuseppe.bilotta@gmail.com> <201010251701.15334.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 25 20:14:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PARZB-0006j7-77
	for gcvg-git-2@lo.gmane.org; Mon, 25 Oct 2010 20:14:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759299Ab0JYSOg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Oct 2010 14:14:36 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47947 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757525Ab0JYSOf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Oct 2010 14:14:35 -0400
Received: by iwn10 with SMTP id 10so1110129iwn.19
        for <git@vger.kernel.org>; Mon, 25 Oct 2010 11:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=efSPD4uzKin0XIqZQh0sLyn0b8V8lkIOjQ6z65wSNqI=;
        b=MqhJ02LSFCRtHjdWTejoqmXczIQjvErcjrnpXUujdru3SsAE21syiHAjpTNpALp1I2
         uJMO/rLOEQQ0l5UxGYza2QvuHOCHJ2htYmrIMBy68qhBXd4GlIn2v7L58ODl+ZRN9d66
         P/zW2K8F2S5kgzXG+jKUDW0F7KY9BmrV+H8FM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=nSWW39d3r4OlQyQCi6eOx+T7I7KBKwlzPQW83MFpDkQkwXSxg9ko8fby28+32OTaoX
         TngLFNJ22AADTcJtN44eM3I1JcDRDeWcaorMsgNiycwJJvriJzWj8YP+FuAt9LGaZecE
         8DNohsJMoZJbtsOkRkoNkvez7NuGtpd1v/MSM=
Received: by 10.231.11.137 with SMTP id t9mr4543386ibt.9.1288030474050; Mon,
 25 Oct 2010 11:14:34 -0700 (PDT)
Received: by 10.231.149.141 with HTTP; Mon, 25 Oct 2010 11:14:13 -0700 (PDT)
In-Reply-To: <201010251701.15334.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159964>

2010/10/25 Jakub Narebski <jnareb@gmail.com>:
> On Sun, 24 Oct 2010, Giuseppe Bilotta wrote:
>
>> We specialize the 'heads' action to only display local branches, and
>> introduce a 'remotes' action to display the remote branches (only
>> available when the remotes_head feature is enabled).
>>
>> Mirroring this, we also split the heads list in summary view into
>> local and remote lists, each linking to the appropriate action.
>>
>> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
>
>> - =A0 =A0 my @headlist =3D git_get_heads_list(16);
>> + =A0 =A0 my @headlist =3D git_get_heads_list(16, 'heads');
>
>> - =A0 =A0 my @headslist =3D git_get_heads_list();
>> + =A0 =A0 my @headslist =3D git_get_heads_list(undef, 'heads');
>
> Hmmm... I wonder if it wouldn't be better to simply change defaults
> in git_get_heads_list() so that second argument defaults always to
> 'heads', even if 'remote_heads' feature is enabled...

That's a good point. I'll look into that.


--=20
Giuseppe "Oblomov" Bilotta
