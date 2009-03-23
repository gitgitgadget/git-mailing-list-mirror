From: Tim Visher <tim.visher@gmail.com>
Subject: Re: git svn teething problems - initial clone okay - fetches not 
	working
Date: Mon, 23 Mar 2009 17:58:08 -0400
Message-ID: <c115fd3c0903231458t7ac8ac69if6b7bdb3a7d8861b@mail.gmail.com>
References: <2BACA6CC2F9647C19C0463120219E694@HPLAPTOP>
	 <49C7F92A.5050809@obry.net>
	 <0381B9A616514FC2A05BACAB07EE3117@HPLAPTOP>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: pascal@obry.net, Git Mailing List <git@vger.kernel.org>
To: Aaron Gray <aaronngray.lists@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 22:59:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlsBJ-00088a-Ho
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 22:59:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756343AbZCWV6L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Mar 2009 17:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752691AbZCWV6L
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 17:58:11 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:31882 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711AbZCWV6K convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Mar 2009 17:58:10 -0400
Received: by yx-out-2324.google.com with SMTP id 31so2298683yxl.1
        for <git@vger.kernel.org>; Mon, 23 Mar 2009 14:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=qFM04EGIYqYKf8LMFZJQrRzF22py4+3exBf0vj95n8Y=;
        b=Np8e0iO+gBmxm699M/tSXuWq6CMXGmZSncdJ7BM/N6Zcv5wJiNQBAHYlJ9TA8utpP9
         6fplGuycBfMLbEHGN2jvZoSMZyNeV1F86CjI4un6dMNBStI5KrU/Ji0SZnwLJU2DDjUy
         mg5XDfYqYA02bRnP8/38cVootcTL1NQSjzSDY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=p9DLN162d/nxJtwmS5OFrgSf2dASnt86W89gEdb12PyX1UMKvaEMiMVMZJpaqJKc3Z
         uOTrv0+C8ig4scO1h0CR2YPs3NM2OgwOC8/bL+VdzXXiLQqxNKciiR7i0e43yrAXOqwj
         BQTEQANUyQAWJsoBgBxdzvNHtdXzZrMCA9vOQ=
Received: by 10.100.216.10 with SMTP id o10mr6802015ang.137.1237845488359; 
	Mon, 23 Mar 2009 14:58:08 -0700 (PDT)
In-Reply-To: <0381B9A616514FC2A05BACAB07EE3117@HPLAPTOP>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114354>

On Mon, Mar 23, 2009 at 5:31 PM, Aaron Gray
<aaronngray.lists@googlemail.com> wrote:
>> Aaron Gray a =C3=A9crit :
>>>
>>> Anyway I am having the problem that I can do a 'git svn fetch' and =
I see
>>> changes coming in. But the gitweb and another git clone from it do =
not
>>> reflect those changes. The repository is still showing its two days=
 old.
>>
>> You need a:
>>
>>  $ git svn rebase
>
> I tried that.
>
>> to fetch *and* merge the changes into the local tracking branch (mas=
ter
>> by default).
>
> Pascal,
>
> Could you give me a full set of instructions for importing :-
>
>   http://llvm.org/svn/llvm-project/llvm
>

It sounds like your working directory might be dirty.  Are you sure
all of your changes have been committed?

--=20

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
