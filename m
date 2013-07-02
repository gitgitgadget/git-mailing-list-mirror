From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [Q] Getting the latest available Linux-kernel version
 (v3.x.y-stable or v3.x.y-rcX)?
Date: Tue, 2 Jul 2013 14:16:10 +0530
Message-ID: <CALkWK0nj3BG0VCxkzack_9sHa8oo=aypuv6KRusdRKyO1JCkAw@mail.gmail.com>
References: <CA+icZUV50bn4wjohfmKWL-GXpstidPNsNWqHuq+0gvEorWOaxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: sedat.dilek@gmail.com
X-From: git-owner@vger.kernel.org Tue Jul 02 10:46:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtwEk-00027G-1c
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 10:46:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932480Ab3GBIqx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 04:46:53 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:61651 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932225Ab3GBIqw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 04:46:52 -0400
Received: by mail-ie0-f179.google.com with SMTP id c10so10599354ieb.24
        for <git@vger.kernel.org>; Tue, 02 Jul 2013 01:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Vn44EnLS7TgGb9Pql6Vs/wUf+UYK6CCo0uwfMHpeHNM=;
        b=1DC51IRdB2oOaMKwLvctUffskIWHa7lCwqOvyZFGkCwkOUNAKOBqHwocBIn292bqYf
         Q6Kvk3GUjuDxOQefxKLRPOiWPgQePGwOsvWF/ico33BAUrCyoP5f7gSht0RmsIdZAEcY
         NcpCr+Cg1c++oeKj6xZRz6vScc+xfOQsCNjI1PkzaoWEpn8ucyMqwaew+7EINzjWTtoH
         f/qlON4tI//L9G/rvh85ccaSQQHroaZTwg/ABU41mEiUR3ErmxnUcxnELVWBQE+0hZUe
         YwezwE/OZCmHe+b1awDgv00Xp+cl4KrE4zkinSPPy71I6jOi+NalZ8bliA5vK0X/js+J
         vPfw==
X-Received: by 10.50.7.1 with SMTP id f1mr18940211iga.48.1372754811641; Tue,
 02 Jul 2013 01:46:51 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Tue, 2 Jul 2013 01:46:10 -0700 (PDT)
In-Reply-To: <CA+icZUV50bn4wjohfmKWL-GXpstidPNsNWqHuq+0gvEorWOaxA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229377>

Sedat Dilek wrote:
> for my Linux-kernel build-script I am searching for a reliable check
> of getting the ***latest*** version.

  $ git describe HEAD

If you want a sorted list of tags,

  $ git for-each-ref --sort=taggerdate --format="%(refname:short)" refs/tags

Are you looking for something else?
