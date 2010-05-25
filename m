From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv5 GSoC] gitweb: Move static files into seperate  subdirectory
Date: Tue, 25 May 2010 02:37:50 +0200
Message-ID: <201005250237.53529.jnareb@gmail.com>
References: <1274714564-7553-1-git-send-email-pavan.sss1991@gmail.com> <201005242205.43194.chriscool@tuxfamily.org> <AANLkTilqa8HAs9jHJQ5KxWic1IYOZxCj10f11KBRMA-b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Eric Wong <normalperson@yhbt.net>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Tue May 25 02:36:14 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGi7x-0000Ew-5M
	for gcvg-git-2@lo.gmane.org; Tue, 25 May 2010 02:36:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758022Ab0EYAgG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 May 2010 20:36:06 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58592 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755709Ab0EYAgF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 May 2010 20:36:05 -0400
Received: by fxm5 with SMTP id 5so2766664fxm.19
        for <git@vger.kernel.org>; Mon, 24 May 2010 17:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ZIgIrQaXXyLJBYCYpuHLojD51orJKhofzTEZJdJeMLs=;
        b=sIOdHmcIZ1Vobl3ijU7dpMzBj4K3BuZo8F47P6rjJIfiIebs+zq9/f5h3BkYsGwDiJ
         S3blZZ84yeRD/dq90ayvMdJmppoMRlwYS1D7oc8zD9bAS2OedGLKFpwFOzxkKwiuSZA0
         9B7T+GfFGYv4wWNf0JRP+LRTAJFB4a5ICEwFM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=a3K7Bd3jQOoFTWchiBtEJeZWf5xaZZmg12tENSMVaxUgv+nB2BrMHWmkOC0UAzfpO/
         X7hf3VlpRW3RFZfuedrJJ5KrCAZcoy4SKc4g3XksAnv+SC60oPVVvoJPHlw8GIspitwp
         ac4eWIhNL3QP9VKQeM4MVELaiu7MnWZkioAOw=
Received: by 10.102.207.1 with SMTP id e1mr4507740mug.122.1274747763615;
        Mon, 24 May 2010 17:36:03 -0700 (PDT)
Received: from [192.168.1.15] (abvf124.neoplus.adsl.tpnet.pl [83.8.203.124])
        by mx.google.com with ESMTPS id j2sm17672884mue.23.2010.05.24.17.36.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 24 May 2010 17:36:02 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTilqa8HAs9jHJQ5KxWic1IYOZxCj10f11KBRMA-b@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147655>

On Mon, 24 May 2010, Pavan Kumar Sunkara wrote:
> On Tue, May 25, 2010 at 1:35 AM, Christian Couder <chriscool@tuxfamily.org> wrote:
>> On Monday 24 May 2010 17:22:44 Pavan Kumar Sunkara wrote:
>>>
>>>  gitweb/{ => static}/git-favicon.png |  Bin 115 -> 115 bytes
>>>  gitweb/{ => static}/git-logo.png    |  Bin 207 -> 207 bytes
>>>  gitweb/{ => static}/gitweb.css      |    0
>>>  gitweb/{ => static}/gitweb.js       |    0
>>
>> The patch is supposed to move git-favicon.png and git-logo.png into
>> gitweb/static but it doesn't.
>>
>>>  diff --git a/gitweb/gitweb.css b/gitweb/static/gitweb.css
>>> similarity index 100%
>>> rename from gitweb/gitweb.css
>>> rename to gitweb/static/gitweb.css
>>> diff --git a/gitweb/gitweb.js b/gitweb/static/gitweb.js
>>> similarity index 100%
>>> rename from gitweb/gitweb.js
>>> rename to gitweb/static/gitweb.js
>>
>> Only gitweb.css and gitweb.js are moved into gitweb/static [...]
>
> I don't understand why the binary files aren't moving into static/ dir.
> I haven't faced this type of problem before. Give me some time to figure it out.

You have found a bug in git.  When you do a pure rename of a binary
file, it doesn't show as a pure rename patch:

  $ git init
  $ echo foo > foo
  $ echo -e "bar\0" > bar
  $ git add .
  $ git commit -m 'Initial commit'
  [master (root-commit) 4bd35b8] Initial commit
   2 files changed, 1 insertions(+), 0 deletions(-)
   create mode 100644 bar
   create mode 100644 foo
  $ mkdir sub
  $ git mv bar foo sub/
  $ git commit -m 'Moved to sub/'
  [master 00356a5] Moved to sub/
   2 files changed, 0 insertions(+), 0 deletions(-)
   rename bar => sub/bar (100%)
   rename foo => sub/foo (100%)
  $ git show -C -C --raw --binary --stat
  commit 00356a5ec458fa64ab3eca2c23ebc53e9f2d54ba
  Author: Jakub Narebski <jnareb@gmail.com>
  Date:   Tue May 25 02:23:26 2010 +0200
  
      Moved to sub/
  ---
  :100644 100644 080090e... 080090e... R100       bar     sub/bar
  :100644 100644 257cc56... 257cc56... R100       foo     sub/foo
  
   bar => sub/bar |  Bin 5 -> 5 bytes
   foo => sub/foo |    0
   2 files changed, 0 insertions(+), 0 deletions(-)
  
  diff --git a/foo b/sub/foo
  similarity index 100%
  rename from foo
  rename to sub/foo

As you can see there is not

  diff --git a/bar b/sub/bar
  similarity index 100%
  rename from bar
  rename to sub/bar

and that adding '--binary' option doesn't help
-- 
Jakub Narebski
Poland
