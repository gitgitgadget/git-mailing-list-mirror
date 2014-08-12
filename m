From: Luke Campagnola <luke.campagnola@gmail.com>
Subject: Re: Error "fatal: not a git repository" after auto packing
Date: Tue, 12 Aug 2014 12:16:19 -0400
Message-ID: <CACZXET-O0SZnJp_LWg_v8ZFfkUXbYtS-j96UYmMkDtbv+NZM5w@mail.gmail.com>
References: <CACZXET_qPzBtqJLXBbou+iZ_Muj=VqCBe5qMADN72VScsuHRVQ@mail.gmail.com>
 <1407859882.17965.1.camel@spirit>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Tue Aug 12 18:16:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHEko-0004kT-5d
	for gcvg-git-2@plane.gmane.org; Tue, 12 Aug 2014 18:16:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753299AbaHLQQu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2014 12:16:50 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:45061 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752866AbaHLQQt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2014 12:16:49 -0400
Received: by mail-ob0-f171.google.com with SMTP id wm4so7372727obc.30
        for <git@vger.kernel.org>; Tue, 12 Aug 2014 09:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=5zA2QkIyNc38Z5AWGTBcpB0X57h5ZD+lql2Ks9x21Us=;
        b=HOUd2W2MZCzpYqrAnBuKWVeJjndAXiXlKcm7KhXH6VZTSwojUImZLeGZb7PK9A77Lh
         8XanrLDp5KMpkIxYXBtoofWgz04guSKv/8mmky/w8mT3WxBXQBp2cftjSzGQ4bAKdGjR
         sWMzg/3ilTudYTqTOnpcsvodHe0C10+JoxzBQ24QmBFjCQ6nazL+hY80dl+DVjE00d45
         LyjRcBzb3080UyqMnOGYiJK5bjC8FpOwiRygm7yPtkMkGl7biO+Jnr43DC0utxwuYGpe
         aDaNcIWeZbmpvbCVlbh1D+wWdjXTd2SLZODDSVhAouAgvXdudG1a9w4yHX+Wg+lLmcHG
         DfpA==
X-Received: by 10.182.204.102 with SMTP id kx6mr6026176obc.16.1407860209073;
 Tue, 12 Aug 2014 09:16:49 -0700 (PDT)
Received: by 10.202.18.203 with HTTP; Tue, 12 Aug 2014 09:16:19 -0700 (PDT)
In-Reply-To: <1407859882.17965.1.camel@spirit>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255153>

On Tue, Aug 12, 2014 at 12:11 PM, Dennis Kaarsemaker
<dennis@kaarsemaker.net> wrote:
> On ma, 2014-08-11 at 18:56 -0400, Luke Campagnola wrote:
>>
>> raven:/home/luke/vispy (transform-cache)$ git checkout master
>> Switched to branch 'master'
>> Deleted 103 .pyc files
>> Deleted 11 empty directories
>
> This looks like you have a local post-checkout hook that deletes empty
> directories. Fix that hook to not do anything in .git and it should be
> fine.

Of course you are correct. Sorry for the noise.
