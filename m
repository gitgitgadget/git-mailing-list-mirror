From: David Aguilar <davvid@gmail.com>
Subject: Re: Wrap commit messages on `git commit -m`
Date: Sat, 3 Nov 2012 00:41:49 -0700
Message-ID: <CAJDDKr4ta2Xu5zO6yASSNewZXxu=LWuNO0zU8YnSP4Kq9ZJn-g@mail.gmail.com>
References: <CALkWK0kQ+qCsOa87yY4wma279mp+9h+LFv3qCP_qrNdDyGNcsQ@mail.gmail.com>
	<m3a9v170ca.fsf@black.gullik.net>
	<CAO54GHDRBDyQYvo-g_xEvsQJRgtfbbT-4-kop8hoSK1D37G44w@mail.gmail.com>
	<20121101221203.GE6213@elie.Belkin>
	<CALkWK0n3nvu4neica==bXaGCtDish8cfUhcsmJT0w3ihrq6coA@mail.gmail.com>
	<20121103063855.GA8326@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Kevin <ikke@ikke.info>,
	=?UTF-8?Q?Lars_Gullik_Bj=C3=B8nnes?= <larsbj@gullik.org>,
	git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 03 08:42:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUYMm-0000Sm-W6
	for gcvg-git-2@plane.gmane.org; Sat, 03 Nov 2012 08:42:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347Ab2KCHlv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2012 03:41:51 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:58475 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002Ab2KCHlv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2012 03:41:51 -0400
Received: by mail-vb0-f46.google.com with SMTP id ff1so4488040vbb.19
        for <git@vger.kernel.org>; Sat, 03 Nov 2012 00:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=H0dnRxom65tspqW4HHMoGUaRvSO0Di8kcfQCiNNpsYE=;
        b=IW3sn9sqQCva6OwrGE9nI11vyEwUxsNmgec38KgfKfh7QYFVbzyT5Xu9V9rzfjdfN8
         BbvXefl32/YQspRSSq0+yq6i3LZS4kE9K4HNLB5BTyOSOnKeZU+TRbOxsBrpympHT3/N
         q6n0mEQP516L7mq9LXwmngdciE/EYE6Dm4gW7x4n8QzIVOU6NbjyqhWiTNcxif9Rmn7A
         Nvb/pSmzR/fKW79o0KQR0CarM57HspU/mtct7DhY3dmqpiaixq+ZyAytc5bmuohKZHoD
         PW3Xxls+3MG3nyVwSZRQQhZPIWUFhlWFO8fzGpUmWomc3ScGS9/d4UXlwoPyH/83cOsp
         F+gQ==
Received: by 10.220.231.138 with SMTP id jq10mr4002245vcb.29.1351928509838;
 Sat, 03 Nov 2012 00:41:49 -0700 (PDT)
Received: by 10.58.182.10 with HTTP; Sat, 3 Nov 2012 00:41:49 -0700 (PDT)
In-Reply-To: <20121103063855.GA8326@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208978>

On Fri, Nov 2, 2012 at 11:38 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ramkumar Ramachandra wrote:
>> Jonathan Nieder wrote:
>
>>> Ram, what platform do your colleagues use?
>>
>> Red Hat Enterprise Linux 5.
>
> Oh, ok.  In that case I blame habit.
>
> I think the best option you have is to just complain to your
> colleagues about the long lines.  Then they would get a chance to
> explore what the UI currently offers and to complain to this list
> (perhaps via you :)) about missing features that would make their work
> easier.
>
> To put it another way: I don't see yet how a hypothetical "git commit
> --wrap-lines -m 'long message'" would make life easier than just
> running "git commit" and entering the message using $EDITOR.  There's
> probably a UI or documentation bug lurking somewhere, so thanks for
> thinking about these things.
>
> Regards,
> Jonathan

If your colleagues do not mind using a GUI then git-cola
might help them form better commit messages.

It auto-wraps long lines and enforces a very clear distinction
between the one-line summary and extended description.
-- 
David
