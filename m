From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Mon, 8 Apr 2013 16:40:13 +0530
Message-ID: <CALkWK0=LW1850irkcJDkdMwKRf8-QrDotRY-ciuxy7KiY1kkyg@mail.gmail.com>
References: <CALkWK0n=vtPT7aFn9+T+bRxUpfXG+mYvV29YKC=_OAampQXJSA@mail.gmail.com>
 <20130407182112.GJ2222@serenity.lan> <5161BC33.8060707@web.de>
 <CALkWK0mBW63P0i6OhuujmAYO99pxLsS=ffFeqw8gBcBDgUpOPg@mail.gmail.com>
 <5161D3C5.9060804@web.de> <CALkWK0k_vmXZr-x8=ZctouWbuVgv-1sptC0WX2aJ+yYD-T8cxA@mail.gmail.com>
 <20130407212342.GA19857@elie.Belkin> <CALkWK0=Q-P-fGLmkoiV3_CJ43MNmFzpfkvFjNUwxB+zOsqTxmg@mail.gmail.com>
 <5162763D.5030708@web.de> <CALkWK0m5iN8h0J1EkbMTJoXy6QHHzyTjRfPnhL3XMgi=NAi2eg@mail.gmail.com>
 <20130408081959.GD20159@elie.Belkin> <CALkWK0nz878Xh9BFSCrtBGT=g3fys3uBy7QQs9cdWaFtoS8Rsg@mail.gmail.com>
 <CACsJy8CAW1h4rAOK_2+EAFEL28CKeqf4vqROsLByjZaMU3D-ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 08 18:28:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPEvi-0003oz-TQ
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 18:28:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759814Ab3DHLKy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 07:10:54 -0400
Received: from mail-ia0-f172.google.com ([209.85.210.172]:62519 "EHLO
	mail-ia0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752895Ab3DHLKx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 07:10:53 -0400
Received: by mail-ia0-f172.google.com with SMTP id k38so1348424iah.17
        for <git@vger.kernel.org>; Mon, 08 Apr 2013 04:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=EFJ7GD+ZHh5ywZlHVaiYLQoNQxs4pHspEBR37pvGt5o=;
        b=zh71ATonVo0ptNMSsFn7SVRUx97P7L2EHq1pM1490fZofr4kwb/zSXbjN7ET9pxaEn
         8LDTFp9c65qnUMyIU90UEryaYS3qra7PH4RIdICrpj8QiITxSOPZEe7neMU28V7wfAOS
         u3pdRrhG+6HqxCUGWtg/CvhiaaiB8qYHuKEZNkmcvs1IfOlqJ+fpa9PsdZOcj/tfCMNC
         lgvOjzp5cZu77pBxt/ARPPhYTFSPlfyeGGDd0orCxF4KDkHgCqH4GMsvmf4SGmufPQCi
         8OP9xPuQOiHY/uj1VgpUyFvr19+5JsdWum2ID46EPcgm070O4cR2RtKMNu6kAlKZKGSx
         oDog==
X-Received: by 10.50.117.3 with SMTP id ka3mr6047802igb.107.1365419453358;
 Mon, 08 Apr 2013 04:10:53 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Mon, 8 Apr 2013 04:10:13 -0700 (PDT)
In-Reply-To: <CACsJy8CAW1h4rAOK_2+EAFEL28CKeqf4vqROsLByjZaMU3D-ow@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220419>

Duy Nguyen wrote:
> Probably off-topic, but I'm starting to find ".gitignore can be found
> in every directory" a burden to day-to-day git operations. So imo it's
> not done right entirely ;-)

Or are you saying it's hard to implement elegantly and efficiently in
git-core?  If so, I agree wholeheartedly.  I'm not yet sure what to do
about the situation.
