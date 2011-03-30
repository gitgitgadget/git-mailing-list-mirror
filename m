From: Sebastian Thiel <byronimo@googlemail.com>
Subject: Re: Git Pack: Improving cache performance (maybe a good GSoC practice)
Date: Wed, 30 Mar 2011 11:53:33 +0200
Message-ID: <4D92FD9D.8040707@gmail.com>
References: <4D925B63.9040405@googlemail.com> <AANLkTin6z3hM7nyMqOUPdHrY9TmRVAzpchM+4O=S7KKj@mail.gmail.com> <4D92EDA0.8030309@googlemail.com> <AANLkTim+Ge2c-i_jUi8YN8g+cQmXuyKYrdHC+jYukjQy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
To: Vicent Marti <vicent@github.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 11:53:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4s5x-0001cH-0i
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 11:53:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755694Ab1C3Jxj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 05:53:39 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:50682 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755008Ab1C3Jxj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Mar 2011 05:53:39 -0400
Received: by fxm17 with SMTP id 17so897265fxm.19
        for <git@vger.kernel.org>; Wed, 30 Mar 2011 02:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=6bH+Z+QAPrs9eK9NtiL4e/svp1QRnGIGJ+YO/3UmPcI=;
        b=Y1mSqCYlrYH94TBJb/zORhDeh0fBciGTVQnCh9WRaupBHTURKz8cFvoK02xigSvqDk
         xVUS33DWdizuitXvocttyNEoRH4inBxCBnr0CigdbB0W8cDlTGqlAdbKGxMo6TYN1+fQ
         mDqAHb12veIu9Us688GNwx9+GmzY/l9+fe0RM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=tXXuAXivgNjFze0UwAJDG1OH8/XfLaa1EGl6pZZAFMstmYDzvnpjj9P6yKJ5ocvlAF
         qGnTBCxviUpDioFZLSzcqwn8vTfTVgfSgaKY9DfmZDHTyE5JESXYVllSDPXLFyJf+A7x
         Yc1bsAjT+ZSgIWWVBaZ3K389L7XoYtJJZnA8Q=
Received: by 10.223.97.142 with SMTP id l14mr982399fan.111.1301478816570;
        Wed, 30 Mar 2011 02:53:36 -0700 (PDT)
Received: from steelbook.local (91-65-187-112-dynip.superkabel.de [91.65.187.112])
        by mx.google.com with ESMTPS id b18sm2305385fak.32.2011.03.30.02.53.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 30 Mar 2011 02:53:35 -0700 (PDT)
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-GB; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <AANLkTim+Ge2c-i_jUi8YN8g+cQmXuyKYrdHC+jYukjQy@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170373>

Thank you very much for the heads-up - I was using old mirrors it appears:

git://repo.or.cz/libgit2.git
git://repo.or.cz/libgit2/raj.git

Its quite terrible that I was left thinking that the project stalled for
so long, and it was hard for me to understand why people would continue
to bring it up :).
Now it all makes sense !

Cheers,
Sebastian

On 30.03.11 11:46, Vicent Marti wrote:
> On Wed, Mar 30, 2011 at 11:45 AM, Sebastian Thiel
> <byronimo@googlemail.com> wrote:
>>> Have considered wrapping libgit2 with a C++ binding? Just curious.
>> The project appears to be silent for nearly 5 months now, and it is in a
>> rather early stage of development. There is no delta cache yet, nor is there
>> a sliding window mmap implementation which would be required on 32 bit
>> systems, at least if you want to have big file support.
> wat?
>
> http://libgit2.github.com
> https://github.com/libgit2/libgit2
>
> Cheers,
> Vicent
