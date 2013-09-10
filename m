From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] version-gen: avoid messing the version
Date: Mon, 9 Sep 2013 20:13:14 -0500
Message-ID: <CAMP44s28ZVRTRj+2cX1q0SaGyY16TZKmJtCscPUgF_hY=KJiwA@mail.gmail.com>
References: <1378702889-21638-1-git-send-email-felipe.contreras@gmail.com>
	<1378702889-21638-3-git-send-email-felipe.contreras@gmail.com>
	<7vtxhuilv1.fsf@alter.siamese.dyndns.org>
	<CAMP44s1B4F8k_TEgXT8reatCw9UKATDAH=D31v=79QA6voEKOw@mail.gmail.com>
	<20130909233028.GB101065@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Tue Sep 10 03:13:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJCW8-0002tZ-Va
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 03:13:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756229Ab3IJBNR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 21:13:17 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:57411 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756168Ab3IJBNQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 21:13:16 -0400
Received: by mail-la0-f46.google.com with SMTP id eh20so5502764lab.19
        for <git@vger.kernel.org>; Mon, 09 Sep 2013 18:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=dE0k/Y/qN375ouDXKhieT2mMR3OB5osPEKWBohNUbQc=;
        b=aZGmTQekGe4Sf3iGceqfsHghW6mjIZL/3nOgHtml4MjoqNq78SBiS6r/zpCtvj3FeD
         13FWhkcqQ7WWG+f8PGGyxOpfams2ErXAzISBEoAn32YxNRPttUPlBfkU3vn59j/EqSld
         8I1San7/jRNYrXn/6q4m/8pL/0kLsAX7BwmenNN/g4VD7XiU/Y8bjv+OKlRhqF8GHt3q
         oMs+/L4IU/I5n/Hvr8kE5JEQnAEvV1LaEeW3DZK2q5Qz9yhkaG05/De1VZM7cS5Ap2Am
         Awn94peOVNGfv5LW4uVH9i4rkWz/5pliNl0e1hk5+DoZXPpBNa/DiuBRVQ7yZz078Oe3
         dA9A==
X-Received: by 10.112.14.102 with SMTP id o6mr4425849lbc.28.1378775594982;
 Mon, 09 Sep 2013 18:13:14 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Mon, 9 Sep 2013 18:13:14 -0700 (PDT)
In-Reply-To: <20130909233028.GB101065@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234415>

On Mon, Sep 9, 2013 at 6:30 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Mon, Sep 09, 2013 at 02:00:55AM -0500, Felipe Contreras wrote:
>> Of course not. First of all, who exactly is packaging release
>> candidates nowadays? And second, why they can't they use the existing
>> tools, like the 'version' file?
>
> Debian unstable, for one.  However, they don't use RPMs and the version
> would be rewritten to use ~ anyway.  Fedora rawhide might.

Debian uses their own version; 1:1.8.4~rc3-1, it doesn't use Git's
version 1.8.4.rc3, so if we change it to 1.8.4-rc3, that doesn't
affect them one bit because they are not using it anyway.

As for Fedora rawhide, they don't even use rc versions:

http://koji.fedoraproject.org/koji/packageinfo?packageID=1864

-- 
Felipe Contreras
