From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Proposal: branch.<name>.remotepush
Date: Fri, 8 Feb 2013 01:19:57 +0530
Message-ID: <CALkWK0=_0hZP_SjMCjooUAr+MrRoXCCzdQF8y9RhW1g7ShsC7w@mail.gmail.com>
References: <CALkWK0nA4hQ0VWivk3AVVVq8Rbb-9CpQ9xFsSOsTQtvo4w08rw@mail.gmail.com>
 <5113E849.8000602@elegosoft.com> <CALkWK0=53riU3xKbKkyAVS8--9VoAU5P6h88MQ9-geW=H5+a-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Michael Schubert <mschub@elegosoft.com>
X-From: git-owner@vger.kernel.org Thu Feb 07 20:50:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3XUb-0002JB-JB
	for gcvg-git-2@plane.gmane.org; Thu, 07 Feb 2013 20:50:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030243Ab3BGTuT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2013 14:50:19 -0500
Received: from mail-ob0-f171.google.com ([209.85.214.171]:41096 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030222Ab3BGTuS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2013 14:50:18 -0500
Received: by mail-ob0-f171.google.com with SMTP id x4so2981046obh.2
        for <git@vger.kernel.org>; Thu, 07 Feb 2013 11:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=0nBrrj7+x04ys0ziuJun0x9xKPV9j3Vh0K0iIpM7rB0=;
        b=GFdsvc/JV4m5TRswX9Jn1DOodbV3EKbwQJJfOgTaiq2CKoWHk0lykCrW3NnvvHQ7YB
         1xfEjkEvVUyanGmc3e2LOMKS015pF+MrclJH/6lUXdsHw3IDDvdydXHBlJz7gCZYw7Ww
         Fzt7zwl52NvZCisWdxN6Ry2P9ByDJMCSjUGEz3Xu5XaY3XjY5wG+XGGfKsUud0WENkk2
         Vb4HB47OI8EQzeANxG8un/sq0XEvcEQ+bkazWNJYRU9F6snhsW3dme3gKK/642d3bakk
         CbAbUa5lPWruqHt/u4YkTde1a4I3+BocDLCX57tLX7bSQQEE0YlA6MCEB1pvD3ZqAvMt
         81hA==
X-Received: by 10.182.95.173 with SMTP id dl13mr2212854obb.43.1360266617244;
 Thu, 07 Feb 2013 11:50:17 -0800 (PST)
Received: by 10.76.128.79 with HTTP; Thu, 7 Feb 2013 11:49:57 -0800 (PST)
In-Reply-To: <CALkWK0=53riU3xKbKkyAVS8--9VoAU5P6h88MQ9-geW=H5+a-w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215719>

Ramkumar Ramachandra wrote:
> And yes, a regular `git push origin refs/for/master` is just retarded.

Actually a git config remote.origin.push refs/heads/*:refs/for/* makes
more sense here.
