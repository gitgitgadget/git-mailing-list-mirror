From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [ANNOUNCE] qgit new "smart browsing" feature
Date: Tue, 5 Jun 2007 20:48:03 +0200
Message-ID: <e5bfff550706051148v57715bb1q88987e3fc6410899@mail.gmail.com>
References: <e5bfff550706031339v5ffda0a6u6f520f0c7b49f442@mail.gmail.com>
	 <200706041309.54279.andyparkins@gmail.com>
	 <e5bfff550706040915v3689e8afwb3dffd5d4caf137a@mail.gmail.com>
	 <200706042004.01819.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Pavel Roskin" <proski@gnu.org>,
	"Jan Hudec" <bulb@ucw.cz>
To: "Andy Parkins" <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 05 20:48:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hve4i-0002s2-KD
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 20:48:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758671AbXFESsG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 14:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758717AbXFESsG
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 14:48:06 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:9956 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758671AbXFESsE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 14:48:04 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2349902wah
        for <git@vger.kernel.org>; Tue, 05 Jun 2007 11:48:04 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZNApJtCFzqhwtDyGBFvOwdM7pNfgUJiTe07+pnEagRY/kXw6lB/wY5UUbkR5FF4IZk6xPpEnKKPw/Mj3La2rWuzxyQAj5ig6ggIHbSvJReYNfssxEGTT7VMuAKMpAubuWwxceT4zk9Dv6bblkbctvrX8T+i0TVkfU0UFBYMwLPE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cqlI+X4x8Wy/7vLQ05Ew8SDl4Ycs7876228NUZM0GYNUDnnSQTr4/b2vWSQMT+StpJflcSWBFhODF8suGFDlH1NgQ/F2I24HdVLlzo8obJ+FXnLYRpBat61OTx44kHcczh9JC+JXE78ak1fh3o6KuIi4wpfmzyFUw4RZzoWbkd8=
Received: by 10.114.57.1 with SMTP id f1mr822703waa.1181069283906;
        Tue, 05 Jun 2007 11:48:03 -0700 (PDT)
Received: by 10.114.61.9 with HTTP; Tue, 5 Jun 2007 11:48:03 -0700 (PDT)
In-Reply-To: <200706042004.01819.andyparkins@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49218>

On 6/4/07, Andy Parkins <andyparkins@gmail.com> wrote:
> On Monday 2007, June 04, Marco Costalba wrote:
>
> >   I have to say that I really like your idea!
>
> Hurrah!  See - even a blind golfer knocks one in eventually :-)
>
> > Probably I will create a new branch called andy_gui where I'll
> > implement your idea, while continue to refine the current approach.
>
> Great stuff.  If I get a moment, I'll try and chip in with some patches.
>

Hi Andy,

  feel free to go wild.


I've just pushed a patch series that implements your tab widget idea.

I've found that, luckily, the required change is small, so small that
I didn't create a new development branch but just a couple of check
boxes in 'Edit->Settings-Browse' dialog from where you can
enable/disable all these new fancy toys and play with them.

Have fun and let me know!

Marco
