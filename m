From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Re: Announcing Git for Windows 1.9.5
Date: Thu, 18 Dec 2014 23:20:15 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1412182318430.13845@s15462909.onlinehome-server.info>
References: <alpine.DEB.1.00.1412181143570.13845@s15462909.onlinehome-server.info> <1e42d971-8785-4fcc-b623-d42245c8f7da@googlegroups.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Stanzilla <staneck@gmail.com>
X-From: msysgit+bncBCZPH74Q5YNRBJFGZWSAKGQE7ARALPI@googlegroups.com Thu Dec 18 23:20:22 2014
Return-path: <msysgit+bncBCZPH74Q5YNRBJFGZWSAKGQE7ARALPI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f192.google.com ([209.85.212.192])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBJFGZWSAKGQE7ARALPI@googlegroups.com>)
	id 1Y1jQj-0000OB-4L
	for gcvm-msysgit@m.gmane.org; Thu, 18 Dec 2014 23:20:21 +0100
Received: by mail-wi0-f192.google.com with SMTP id em10sf4124wid.19
        for <gcvm-msysgit@m.gmane.org>; Thu, 18 Dec 2014 14:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=fVJlubGccdRG15B24wK3Vh7y9l4gJ8vgBNvsvXNr5h8=;
        b=Hpi4C1YcP4e3tbgJ5fabo9UjU3lt4tenCZIKPvekxts4G/QVppXYBwaghfR1TMkCTB
         YdUvJmH1PagtBjEhxxbiMzIFS0XhLRd38I2ovR6Nhji81uZUpBuxuDR9wZ37yBxxEIVz
         2L8IkA+e/2GDZ+OdKv7xO/+KXT5znwNq8JREUt7qGGaRcQxxTdH7KmgUp1eLr2IAuARr
         gFqrNTQ3qnlc/QOHgYEYS6clDzn1KBX486LfHLrtERRHtAfrvHFX5z3Z31JWjS93e/ME
         UpW9gaRpAcmrw/s3WmBrS0WOxuQp13P5cwGZ98gQ4QNK64BNES89yBYuS3RuEjQuh+SM
         6etA==
X-Received: by 10.180.105.225 with SMTP id gp1mr242wib.10.1418941220794;
        Thu, 18 Dec 2014 14:20:20 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.19.129 with SMTP id f1ls6583wie.24.gmail; Thu, 18 Dec 2014
 14:20:20 -0800 (PST)
X-Received: by 10.180.98.38 with SMTP id ef6mr7249wib.4.1418941220099;
        Thu, 18 Dec 2014 14:20:20 -0800 (PST)
Received: from mout.gmx.net (mout.gmx.net. [212.227.15.15])
        by gmr-mx.google.com with ESMTPS id j6si8685wix.1.2014.12.18.14.20.20
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Dec 2014 14:20:20 -0800 (PST)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.15.15 as permitted sender) client-ip=212.227.15.15;
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx003) with ESMTPSA (Nemesis) id 0Lfjxq-1XYkGj13JS-00pMYv;
 Thu, 18 Dec 2014 23:20:15 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <1e42d971-8785-4fcc-b623-d42245c8f7da@googlegroups.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:cCQbH9V1HLuLUMa5XXvop2jsK6nhcyFXKe6mIQBz+Gu0Q6p+c5i
 5VRRODMlYW4Y2GvG4qDaC+/9XzrNzXsmm6Kl3eLhZy5rOyv/3vx4mGEvhHDWPxB0jeXEvRm
 EfE6QdIFEdqEQKSZ2AwZ+/k2nFgZpqZaNAWoNo9iVcuZ9MB56s/+GA5CRy7ELoHmCWCVV31
 6a8FSlBs0ja3HA3tU1rEg==
X-UI-Out-Filterresults: notjunk:1;
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.15.15 as
 permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261539>

Hi Stanzilla,

On Thu, 18 Dec 2014, Stanzilla wrote:

> Release notes at
> https://github.com/msysgit/msysgit/raw/master/share/WinGit/ReleaseNotes.rtf
> are *not* up to date.

Yep, the 'master' branch is intentionally behind. It will be updated
tomorrow, as well as the msysgit/git.git repository. The installer was
updated, which you are welcome to download and install.

Ciao,
Johannes
