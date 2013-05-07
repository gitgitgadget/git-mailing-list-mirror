From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Pitfalls in auto-fast-forwarding heads that are not checked out?
Date: Tue, 7 May 2013 10:27:46 -0400
Message-ID: <CACPiFCJ9Jcd8VG3aTocaJ_jkcY8=3aUJUbDMJcfRXOaW41EsmQ@mail.gmail.com>
References: <CACPiFCLnjCeCpt8wR71bFweFyA3rFCsnbEiR1yRD1n=X5K84Mw@mail.gmail.com>
 <5184B9F9.2010708@kdbg.org> <CACPiFCK=8KFX++Bg+LhymorSMnWgrj5Js+-f=UYyZnNY=n9WiA@mail.gmail.com>
 <20130504185146.GD25863@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 07 16:28:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZisL-0001PT-Ac
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 16:28:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754054Ab3EGO2K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 10:28:10 -0400
Received: from mail-ve0-f181.google.com ([209.85.128.181]:57438 "EHLO
	mail-ve0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753738Ab3EGO2H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 10:28:07 -0400
Received: by mail-ve0-f181.google.com with SMTP id d10so582901vea.12
        for <git@vger.kernel.org>; Tue, 07 May 2013 07:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=f4A0oLOldHSQCvmxkSccQYuvDp2hIjJmOCdDR1tMTrw=;
        b=bTD5wfTMlI2144v4Z0Oiydg/BMBZULAWIYmoOA3Yo+v3SJQKUqkhWSdMy/ZEt6KwwO
         mk/x0jfIl7F2eZDk33twQD20+udZYMSxrI/aflSlruvJZrVc3o8ldxyL4ncXS9Jtvo6q
         CFBvF9COQT7vsO0pDZ7CzlwAg6loYnGmFDRxdofFeN4LChz7ZVtN03UBgSF6VesUj1cH
         nk9MfEk4YS6mSNTNwLkagq9eqhgWy2GuaLYuPhUvMpmUCG4GgX2WmJbIJQXbqyQvUK/o
         wABTW0JD8ZF3xyzqZdz6OBO2Sv7s31jU8O94Uf7GIcSnvJgGp0PafSRt/NnXtPLkqulp
         52TA==
X-Received: by 10.220.168.6 with SMTP id s6mr306954vcy.41.1367936886175; Tue,
 07 May 2013 07:28:06 -0700 (PDT)
Received: by 10.220.248.79 with HTTP; Tue, 7 May 2013 07:27:46 -0700 (PDT)
In-Reply-To: <20130504185146.GD25863@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223572>

On Sat, May 4, 2013 at 2:51 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Another trick is to use "git push":
>         git push . $production_sha1:refs/heads/master

Great trick -- thanks! In use in ppg now :-)



m
--
 martin.langhoff@gmail.com
 -  ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 ~ http://docs.moodle.org/en/User:Martin_Langhoff
