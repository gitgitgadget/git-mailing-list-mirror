From: FusionX86 <fusionx86@gmail.com>
Subject: git p4 clone - HEAD + partial history
Date: Tue, 12 May 2015 13:31:19 -0600
Message-ID: <CAFcBi8_sARUkD2iDeto2CXr1vOm473aOSbj9dCiERTj51ot59A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Users <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 12 21:31:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsFtl-0006Ws-5I
	for gcvg-git-2@plane.gmane.org; Tue, 12 May 2015 21:31:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933570AbbELTbV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2015 15:31:21 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:36147 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932924AbbELTbU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2015 15:31:20 -0400
Received: by qku63 with SMTP id 63so13243574qku.3
        for <git@vger.kernel.org>; Tue, 12 May 2015 12:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=AxmkwTEMpjlb4s4Eu97D9MRqYC7YFlLGg36rfohGpd4=;
        b=XvmKwpih3oevlEvGDOlHLcsOQqzRiB8rG01rGc0DEVDwN5Zfl092dr+Y4dKV4Dp0GH
         vfirxdnhnVzZUb+Y/l7TNjLyNzOqIdRx7qgqI7T71OeSjJ70A0GXT6e0ZzBu4Fdlfu4o
         5anm/OU/VVuc8O42kgMplaVeCEzckR9HD6qqz2RWeCulB3yl4BFyw1lGbnzvexr6RxuG
         loaLdD8jRBldLabFrjqYCPOm63cXiKt7jK/9k/n4KpJf1EKHPf6Z4yjjyfjxyCwVQISK
         5hx5dFB5NSRPVdo2vdMSNKDjwjVmd+I+t1SV+e8mSMM4XB2coXhMNEPIJwVRWxqBegpW
         Tr2w==
X-Received: by 10.55.23.78 with SMTP id i75mr35493621qkh.82.1431459080011;
 Tue, 12 May 2015 12:31:20 -0700 (PDT)
Received: by 10.140.93.4 with HTTP; Tue, 12 May 2015 12:31:19 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268874>

Hello,

I'm migrating my company from Perforce to Git. There is history in
Perforce that goes back to 2006 and I'd like to migrate it with some,
but not all of the history. I'm not having luck so far.

>From what I see, a simple git p4 clone grabs HEAD only. Using @all
grabs all history and is way too much to migrate. I have tried using
//depot/folder@2015/01/01,@all when cloning, but it doesn't grab the
current stuff in HEAD.

Is it possible to grab what is currently in HEAD and the last few
months of history only?
