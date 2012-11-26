From: Igor Lautar <igor.lautar@gmail.com>
Subject: Re: commit gone after merge - how to debug?
Date: Mon, 26 Nov 2012 14:24:53 +0100
Message-ID: <CAO1Khk_r5eubm6M815FCxXLRpm-zPhzfFasug497saev8o-qeQ@mail.gmail.com>
References: <CAO1Khk_eugH--wp3s-gr4HTvuRyL=SaWHWtEXCRZ_Ak7+s5U=w@mail.gmail.com>
	<1353935441-ner-9639@calvin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Tomas Carnecky <tomas.carnecky@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 14:25:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TcygP-0000dP-BE
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 14:25:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754370Ab2KZNYy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 08:24:54 -0500
Received: from mail-vb0-f46.google.com ([209.85.212.46]:55031 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754104Ab2KZNYy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 08:24:54 -0500
Received: by mail-vb0-f46.google.com with SMTP id ff1so5583490vbb.19
        for <git@vger.kernel.org>; Mon, 26 Nov 2012 05:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=LWP58Xf+2WsAMfQczzOmVBZL4xNRF4NBGu3jEIU1EYg=;
        b=aoOVxFZyvsG2Bewpqo4URu87a0ncyVx2b4rHodsaiPFQxk43CqpcVt2uKIwikiQnHE
         ExCVuvP8ePOByR1P98Vg5d6tYa9tdnf5OXRwka50dlvedg8m9sMucqx12Hiao6Y087Re
         y2n/IAffRIXSbci8aLTChgmqfjDq6/6FrUqhnAnDeL1eWKPz2qPwKwhzVFKNLvuJZdgk
         +0xzxsyX5MhLpZkPUfL5OqhNdL72czSACxaXAh0ypm3bDCJybebikXIAisnpPvtJGzS9
         Wp0NJuRC+4Hm9YGJgqU20IWDUORpvXVkVNbiZ4wbD4GW9vmHcjNpBhjtifOiYA50SrEv
         EWsw==
Received: by 10.52.35.84 with SMTP id f20mr9087417vdj.95.1353936293301; Mon,
 26 Nov 2012 05:24:53 -0800 (PST)
Received: by 10.58.69.112 with HTTP; Mon, 26 Nov 2012 05:24:53 -0800 (PST)
In-Reply-To: <1353935441-ner-9639@calvin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210444>

On Mon, Nov 26, 2012 at 2:10 PM, Tomas Carnecky
<tomas.carnecky@gmail.com> wrote:
> On Mon, 26 Nov 2012 14:06:09 +0100, Igor Lautar <igor.lautar@gmail.com> wrote:
>> git log <file modified by commit>
>>  - commit NOT shown in file history any more and file does not have this change
>
> does `git log --full-history <file modified by commit>` show the commit?

Indeed it does.

Did the merge with verbosity set to 5. It says the commit I'm merging
in is virtual (probably as it is a merge commit in itself?).

Why would commit be left behind after merge? What kind of history
triggers this scenario?
Just trying to understand reasoning as its counter-intuitive to what I
know now. This may affect our workflow (ie., change it so we avoid it
happening).
