From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Should git-citool be in mainporcelain in command-list?
Date: Mon, 6 Sep 2010 17:31:20 -0500
Message-ID: <20100906223120.GI26371@burratino>
References: <AANLkTi=Hn_GG1y3gkVxgnsKyVD+VutG5SU5HhmhRfktH@mail.gmail.com>
 <20100906213937.GF26371@burratino>
 <AANLkTimRoAgAtrkpyd08mVG93prQ40B1y=ReLRdNfbWt@mail.gmail.com>
 <20100906220757.GH26371@burratino>
 <AANLkTiknz1vmXj+jOHudyW1QQkZhy+EgMG7_56_50GT6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 07 00:33:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OskFl-0004Gn-Ns
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 00:33:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754717Ab0IFWdZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 18:33:25 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:44841 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753542Ab0IFWdY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Sep 2010 18:33:24 -0400
Received: by qwh6 with SMTP id 6so4169005qwh.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 15:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=DmJc8NoTGKz4T4GYyUUtRkbZsi5Zqu87mStd0RzIpyo=;
        b=jtf5VON8CfeS3qxcisJ6NyqBfijB3KjqrCsKH9Zpn5TK466Q9ZJogngVSM8VfPhqjh
         ZDQpTu12LO6oo1jyTwalqBt55lK0S/E6rmVSn4V7G+VjxAVvFxrjdk04//MMBHkNqOv4
         D9X1lGjkMV0RTO9K7+W8a7JlpkGFYDN+GTJoY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=pnoDS7ewCBTZkWbxuyWi9ad4x54/OnHGv03w4J0TG9/rJbnx39mynEpQlsY48eP2vy
         Jha4E3xSEK0HCdLMrsMurPHF6OFkN2qMMLEg5xeLrq3IwBdMk2vVrBuQXi0GyOEpX/Rw
         tK/jwqHYUTnWj9YV560DEaMqvsr0M1lfg7xn0=
Received: by 10.224.3.21 with SMTP id 21mr311280qal.337.1283812403145;
        Mon, 06 Sep 2010 15:33:23 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id t24sm6177556qcs.35.2010.09.06.15.33.21
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Sep 2010 15:33:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTiknz1vmXj+jOHudyW1QQkZhy+EgMG7_56_50GT6@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155636>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Mon, Sep 6, 2010 at 22:07, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:

>> =C2=A0 =C2=A0 =C2=A0 git citool is actually a standard alias for git=
 gui
>> =C2=A0 =C2=A0 =C2=A0 citool. See git-gui(1) for more details.
>
> I.e. `git gui citool` and `git citool` launch the same thing, the
> latter is just a shorter way to do it.

All I meant is that it is not an alias for "git gui" but for
"git gui citool".  I can imagine a person reading git(1) and
learning about the ability to say

	git citool

though I guess by the same token a person might wonder why
the list does not include similar

	git blametool

and

	git browsertool

commands.  Anyway, I have nothing against a separate "aliases" category=
=2E
Sorry for the noise.
