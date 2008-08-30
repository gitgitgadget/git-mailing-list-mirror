From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit] Debian packaging update
Date: Sat, 30 Aug 2008 23:36:57 +0100
Message-ID: <b0943d9e0808301536m6422e6cfv96c14afd0a62966a@mail.gmail.com>
References: <20080818201036.7c2c00f8@whitehouse.id.au>
	 <b0943d9e0808211535s7b829a13hbf28be8116e856a6@mail.gmail.com>
	 <20080822235154.5e1f979c@whitehouse.id.au>
	 <b0943d9e0808221457w42a84fbgdf62e3ddbb417389@mail.gmail.com>
	 <20080828140929.GB3584@khazad-dum.debian.net>
	 <20080828192450.GH4985@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Henrique de Moraes Holschuh" <hmh@hmh.eng.br>,
	"Daniel White" <daniel@whitehouse.id.au>, git@vger.kernel.org,
	"=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>,
	stgit@packages.debian.org
To: "Yann Dirson" <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Sun Aug 31 00:38:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZZ53-0000MD-EE
	for gcvg-git-2@gmane.org; Sun, 31 Aug 2008 00:38:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756141AbYH3Wg7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 18:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755535AbYH3Wg7
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 18:36:59 -0400
Received: from wa-out-1112.google.com ([209.85.146.182]:5655 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756141AbYH3Wg6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 18:36:58 -0400
Received: by wa-out-1112.google.com with SMTP id j37so861010waf.23
        for <git@vger.kernel.org>; Sat, 30 Aug 2008 15:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=uPqUrAhY1+RCGzMmdi75tx4gsrkKiyMz2O/8h6RVg/I=;
        b=C5obsDgDXmnSzqkFUz23YQ629doJ7YrfHlWUBQeCTDLOfJJaEzu32HUXOQ/wxO9KUu
         CH+WiQ8EOxQh259qRdegJZ3Yc/hF+JVk+J4UGKbkjaw3F7LIUcmS+AQcuB4lvsG+oEc2
         KkLNPOIPerUGBgd+FhxgA0Jf5IF2YHwHB6neI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=TJRIoRyBoxtoplxMr/c5Kw4n9jP/M/KZrxa48v4F46Bt84PJ+TveKFzVLtO/vu8iU4
         kfRcdpovIUAI8Yu3WVjDczmVVCiF0qBCtbfbuo9pax2aDQxWzD8X3lcFgsqq/OwKZD8j
         mByI9ZZJSIa2NJPAnWezW1h27wWzGCwkuEFx8=
Received: by 10.114.210.2 with SMTP id i2mr4061408wag.18.1220135818019;
        Sat, 30 Aug 2008 15:36:58 -0700 (PDT)
Received: by 10.114.193.12 with HTTP; Sat, 30 Aug 2008 15:36:57 -0700 (PDT)
In-Reply-To: <20080828192450.GH4985@nan92-1-81-57-214-146.fbx.proxad.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94443>

2008/8/28 Yann Dirson <ydirson@altern.org>:
> Another benefit to having uptodate packaging upstream would be to have
> deb snapshots regularly generated, alhough we don't take advantage of
> this for the moment.

As a side-note, in the Python world it seems that more people started
using the Python Package Index (http://pypi.python.org/pypi) and
install a package easily using "easy_install". This doesn't have the
.deb features but it is more universal across various Linux
distributions (the bad thing, it doesn't seem to allow uninstalling).
At some point I might create a pypi entry (shouldn't take long but
I've been too busy with other things).

-- 
Catalin
