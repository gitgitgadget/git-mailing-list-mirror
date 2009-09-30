From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How can I download a git commit as a diff patch?
Date: Wed, 30 Sep 2009 13:10:51 -0700 (PDT)
Message-ID: <m3tyyk9ost.fsf@localhost.localdomain>
References: <20090930154410.GA31502@thumper2>
	<20090930085500.a5856301.rdunlap@xenotime.net>
	<20090930190014.GA22161@csclub.uwaterloo.ca>
	<20090930213809.71c2a8e8@varda>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: lsorense@csclub.uwaterloo.ca (Lennart Sorensen),
	Randy Dunlap <rdunlap@xenotime.net>,
	Andy <genanr@emsphone.com>, linux-kernel@vger.kernel.org,
	git@vger.kernel.org
To: =?iso-8859-15?q?Alejandro_Riveira_Fern=E1ndez?= 
	<ariveira@gmail.com>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755292AbZI3UKv@vger.kernel.org Wed Sep 30 22:11:09 2009
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755292AbZI3UKv@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mt5W1-0000Qf-3R
	for glk-linux-kernel-3@lo.gmane.org; Wed, 30 Sep 2009 22:11:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755292AbZI3UKv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 30 Sep 2009 16:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754686AbZI3UKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Sep 2009 16:10:50 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:28762 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753784AbZI3UKt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Sep 2009 16:10:49 -0400
Received: by fg-out-1718.google.com with SMTP id 22so1524862fge.1
        for <multiple recipients>; Wed, 30 Sep 2009 13:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=jT72hcSerXE0Azt15ERZE0n094JG8UlRVCXkHQTiNdg=;
        b=UieYKkshWjTqAdwNjtlCqOLfpoJN8jIqjVLSCfZ30dY//E+O07hMW5xN3V30h3Vm41
         QUqVPxbbdeLjMjklFQTqiBg5hiluZA/I56fV+DA31OOXQ+E38/GNbzzrozTMlncefgtS
         WIsYZon5gDdj6kTkA/zO+rmh1f7tKRJsEYT7I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=Q4lpkaH7gPX9oB0n7+HzI3da0/Sn6Ao1Ac5CvxaCrfCuFPjb7fAJB8um2jxJPRtaZG
         4w8VVKKf0ZhP30sk2gjuxvr4WTPeqViGgjoHYDiNF9aWmvjp1xKuhavKMgsHS7mBE+8M
         hMzJ16JJdAdjZH7HiZ1kR1DFyv17lMavzg0gg=
Received: by 10.86.17.27 with SMTP id 27mr368261fgq.31.1254341452659;
        Wed, 30 Sep 2009 13:10:52 -0700 (PDT)
Received: from localhost.localdomain (abvd215.neoplus.adsl.tpnet.pl [83.8.201.215])
        by mx.google.com with ESMTPS id 12sm58458fgg.23.2009.09.30.13.10.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 30 Sep 2009 13:10:51 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n8UKAd6X021974;
	Wed, 30 Sep 2009 22:10:40 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n8UKARDT021964;
	Wed, 30 Sep 2009 22:10:27 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20090930213809.71c2a8e8@varda>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129353>

Alejandro Riveira Fern=E1ndez    <ariveira@gmail.com> writes:

> El Wed, 30 Sep 2009 15:00:14 -0400
>=20
>  CCing git@vger.kernel.org ??
>=20
> lsorense@csclub.uwaterloo.ca (Lennart Sorensen) escribi=F3:
>=20
>> On Wed, Sep 30, 2009 at 08:55:00AM -0700, Randy Dunlap wrote:
>>> On Wed, 30 Sep 2009 10:44:10 -0500 Andy wrote:
>>>=20
>>>> I just want to down a particular git commit as a patch, not a git =
commit or
>>>> anything.  Yes, I can see the diffs on the web, but unless I am mi=
ssing
>>>> something all are in unless html formats for me.  And cut and past=
 from the
>>>> web page does not help either because some lines get mangled.  Is =
there some
>>>> site, or git itself, that would allow be to get the git commit as =
a simple
>>>> patch?
>>>=20
>>> Look at the commitdiff using the web interface, then click on "raw"=
 near
>>> the upper left corner.

Or better yet, if given installation of gitweb supports it, on the
'patch' link just on the right of 'raw' view.  Such patch can be
applied better by git-am (but both should work for GNU patch or
git-apply).

>>=20
>> Of course some git diff's are not in a format that patch will like a=
s
>> far as I can tell.
>>=20
>> For example commit 6cdee2f96a97f6da26bd3759c3f8823332fbb438 which ha=
s
>> stuff like:
>> diff --cc drivers/net/ixp2000/ixpdev.c
>> index 588b44d,92fb823..1272434
>> --- a/drivers/net/ixp2000/ixpdev.c
>> +++ b/drivers/net/ixp2000/ixpdev.c
>> @@@ -67,9 -68,9 +68,9 @@@ static int ixpdev_xmit(struct sk_buff *
>>         ip->tx_queue_entries++;
>>         if (ip->tx_queue_entries =3D=3D TX_BUF_COUNT_PER_CHAN)
>>                 netif_stop_queue(dev);
>> -       local_irq_enable();
>> +       local_irq_restore(flags);
>>=20
>>  -      return 0;
>>  +      return NETDEV_TX_OK;
>>   }
>>=20
>>=20
>>=20
>> Ehm, what does that mean?  patch doesn't like it.
>>=20
>> Do git merges cause weird diffs?

Yes, by default for merges the 'commitdiff' view (and the 'raw'
version, i.e. 'commitdiff_plain' view) shows **combined** diff of
changes brought by merge (see git-diff manpage for details on this
format).

=46or merge commit you have to choose which of parents you want to have
diff from.  Go to 'commit' view, there in the header would be two or
more parents.  Click on the 'diff' link beside chosen parent, check if
it is the diff you want to get, and then click on 'patch' (or 'raw')
link.

--=20
Jakub Narebski
Poland
ShadeHawk on #git
