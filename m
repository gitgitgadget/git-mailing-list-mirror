From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH 1/4] Allow e-mails to be sent with the Unix sendmail tool
Date: Tue, 15 Jul 2008 22:47:52 +0100
Message-ID: <b0943d9e0807151447s657a6bcao82548c930c0c8c6b@mail.gmail.com>
References: <20080713113853.18845.37686.stgit@localhost.localdomain>
	 <20080713114026.18845.77979.stgit@localhost.localdomain>
	 <20080715122203.GN25448@sirena.org.uk>
	 <20080715123432.GB17008@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Mark Brown" <broonie@sirena.org.uk>, git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 23:48:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIsOG-0002S9-6n
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 23:48:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752337AbYGOVry convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Jul 2008 17:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751722AbYGOVry
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 17:47:54 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:15115 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382AbYGOVrx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jul 2008 17:47:53 -0400
Received: by yx-out-2324.google.com with SMTP id 8so1706365yxm.1
        for <git@vger.kernel.org>; Tue, 15 Jul 2008 14:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=NkjAHzHzYczcpmcJ3RyUC5UliwjweiTA1MI9Ttt2WYg=;
        b=tq3gq7wZukVbrlAgctBz0t/xGOUvhkdNB49qkuBKZAtrCF9Phuh1lX41uj4bEgthSk
         ulJD8mOTV/g33z2pR9arIxHc6rACXQKBokqUwNpGtX/cafr+a/Fc0O8obp0i4sYTUjwY
         qAmGmKjZKb4QWxZWNWDO1KETIdwn+ZYxmcsK0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=G6NzDFK/MIGMR0QNAFDIvQf4MgiAbvYPq7RyoaCK+rov5YzP6HgeIKBsOaJ+KcEmzh
         116OEXRN3uHoB/hgi4vppAutg3qsAzgsH3S2D5a9h4MNOlfhW9CzlMp+H35/4DedOTFz
         7KmHfETnZvwFuLbqfuXk1ZIj1ZZBvhSn1H8Rg=
Received: by 10.114.148.1 with SMTP id v1mr5900506wad.199.1216158472225;
        Tue, 15 Jul 2008 14:47:52 -0700 (PDT)
Received: by 10.114.193.12 with HTTP; Tue, 15 Jul 2008 14:47:52 -0700 (PDT)
In-Reply-To: <20080715123432.GB17008@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88599>

2008/7/15 Karl Hasselstr=F6m <kha@treskal.com>:
> On 2008-07-15 13:22:20 +0100, Mark Brown wrote:
>
>> On Sun, Jul 13, 2008 at 12:40:26PM +0100, Catalin Marinas wrote:
>>
>> > If the stgit.smtpserver configuration option does not have a
>> > host:port format, it is assumed to be an external tool. For
>> > example, to use sendmail just set this variable to
>> > "/usr/sbin/sendmail -t -i" (see the examples/gitconfig file).
>>
>> I'd really expect to be able to just specify the hostname alone if
>> using the standard SMTP port. Perhaps checking for a / in the server
>> might be less surprising?
>
> This is actually what the code does, and what the documentation claim=
s
> it should do. It's just the commit message that's confused. Catalin?

Yes, indeed, but too many things to keep in sync :-).

--=20
Catalin
