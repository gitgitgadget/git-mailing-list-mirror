From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: Windows support
Date: Thu, 26 Jul 2007 08:37:19 -0400
Message-ID: <fcaeb9bf0707260537y4233abaamadf4cb6190ea0eeb@mail.gmail.com>
References: <a1bbc6950707250335m3d37d4farceffc50945e31f6c@mail.gmail.com>
	 <7vps2fc196.fsf@assigned-by-dhcp.cox.net>
	 <20070726031838.GO32566@spearce.org>
	 <7v6447bxc1.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0707260614500.14781@racer.site>
	 <46A8378A.6050201@xs4all.nl>
	 <Pine.LNX.4.64.0707260737170.14781@racer.site>
	 <f329bf540707260002p117937tc9bc70050ef87838@mail.gmail.com>
	 <fcaeb9bf0707260429l327f446bq73a8a0a13cd77cf1@mail.gmail.com>
	 <46d6db660707260521u15c2bd85j806d48e0f51a3b9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: hanwen@xs4all.nl,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Dmitry Kakurin" <dmitry.kakurin@gmail.com>
To: "Christian MICHON" <christian.michon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 14:37:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IE2ar-0001VK-5f
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 14:37:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755853AbXGZMhW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 08:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755726AbXGZMhW
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 08:37:22 -0400
Received: from an-out-0708.google.com ([209.85.132.245]:49308 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754028AbXGZMhU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 08:37:20 -0400
Received: by an-out-0708.google.com with SMTP id d31so99909and
        for <git@vger.kernel.org>; Thu, 26 Jul 2007 05:37:19 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PU77dU20WF8c34KXGofEn+rMy+BDv8nKm8VheDFsNlTNG53klR3iZTYUKhX//YzvhmVMLBBvvOMSvuDdJTB38QcsNtcf0PZmvuuQ8QRIRZ75cedMysatgtLWRiS2vdZiT402vsp7vnje1LC1LtMNwOsZVvrgdBh0KvGu4Aa0NV4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bixfVupbmlJyrkbxRhedlVWTFSMyrfNpemxVFpW5ZClGNuWEBe/wqWVjLxkM2fpKRo9kj4BPm0iaedvLquZcpc0t7grFb7cLw88Gl4GVR1t9wdrcgLojO8nqyJwQGHgQIyktch2RC+F+Kn0V3Vyp+PAX7OzRfjC13B/DIsn9+9g=
Received: by 10.100.134.2 with SMTP id h2mr1200444and.1185453439548;
        Thu, 26 Jul 2007 05:37:19 -0700 (PDT)
Received: by 10.100.127.17 with HTTP; Thu, 26 Jul 2007 05:37:19 -0700 (PDT)
In-Reply-To: <46d6db660707260521u15c2bd85j806d48e0f51a3b9@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53825>

On 7/26/07, Christian MICHON <christian.michon@gmail.com> wrote:
> On 7/26/07, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> > microperl [1] maybe? I haven't tried it yet.
> >
>
> it won't work. I tried that few months back.
>
> plus the fact you'll still need perl modules.
>
> I just had a look at your gitbox gitweb. Did you really manage
> to get busybox-1.6.1 to work with mingw ?

Most of tools (that are included) work fine. Ash almost works. It can
run git status, git commit, git clone.. and most of test cases. There
are still some missing pieces and bugs to hunt down though.
-- 
Duy
