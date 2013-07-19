From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Git Clone Parameter
Date: Fri, 19 Jul 2013 21:14:11 +0530
Message-ID: <CALkWK0kdVrsLy=pwZvn5de+L54gWbU0hmDTXpHHDKQbXiE_wdw@mail.gmail.com>
References: <FB572366-0B1D-4053-9255-979CB213B160@gmail.com>
 <CALkWK0=q62SmQwDPKjRv+Z8D59Uy=Kpanth8QFYFJ=xOA5JCtw@mail.gmail.com> <7vvc46y4il.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Allan Acheampong <allanadjei@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 19 17:44:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0CrY-00065a-Bn
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 17:44:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760446Ab3GSPow (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 11:44:52 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:57455 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752615Ab3GSPow (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 11:44:52 -0400
Received: by mail-ie0-f170.google.com with SMTP id e11so9836548iej.1
        for <git@vger.kernel.org>; Fri, 19 Jul 2013 08:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=DC4QjGtCQAouPk/WXX9GvQgFGcuJHfDtH7RWoW3xwvY=;
        b=UILDshA2rfW9DOZFT51L/ujoP+gFv+ARa0yXqhq/5vooY6e9dyW1QeTuV2XCrj8J0Q
         eOXWumSfzpsDbmFiuOkEtNLlC6Jx8+11IHZsQ2Y5nCe7FWeWghjT83ShQ+Hh8C3n7nop
         YYOsbIpisSbiI4nNSHaf4o8qTCC99vrrYdQVX0+mXSp5M5T0+ncYIhjEwo1uxd8HDf+H
         eGwyA4dPLgBlEk2P98LGEM9E72VnCqlz5S1V8urujQgsCIP3BhnuBGWuoFIAnXzWZx6/
         X1oqbn1AKPypSe6zEYLEr7MT2/VouxTz/2tS9BtSnQjr6/waTumFpjknja13tTdv0bXn
         XrCg==
X-Received: by 10.43.88.3 with SMTP id ay3mr10836103icc.61.1374248691696; Fri,
 19 Jul 2013 08:44:51 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Fri, 19 Jul 2013 08:44:11 -0700 (PDT)
In-Reply-To: <7vvc46y4il.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230818>

Junio C Hamano wrote:
> You would at least need "xargs -n 1" for the produced command line
> to make any sense, and it is wasteful to actually check out each
> and every branch to the working tree only to create it.

Right.  xargs -n 1, git branch, and refname:short.
