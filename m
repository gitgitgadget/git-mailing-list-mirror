From: Ping Yin <pkufranky@gmail.com>
Subject: Re: git-difftool
Date: Sat, 17 Jan 2009 22:17:29 +0800
Message-ID: <46dff0320901170617w620015cy2d155dc839dbdaf5@mail.gmail.com>
References: <20081226013021.GA15414@gmail.com> <vpqhc4kz5zh.fsf@bauges.imag.fr>
	 <46dff0320812312338i5a3ee0cem702a6b67ef76e48c@mail.gmail.com>
	 <200901020104.01522.markus.heidelberg@web.de>
	 <46dff0320901011759ke7026d9hafe4fdde099e370b@mail.gmail.com>
	 <1232164040173-2171934.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: enso <a.calhoon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 17 15:18:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOC0k-0007jt-Rg
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 15:18:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757136AbZAQORb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 09:17:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754764AbZAQORb
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 09:17:31 -0500
Received: from rv-out-0506.google.com ([209.85.198.236]:21975 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754865AbZAQORa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 09:17:30 -0500
Received: by rv-out-0506.google.com with SMTP id k40so1977987rvb.1
        for <git@vger.kernel.org>; Sat, 17 Jan 2009 06:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=WfjyvoqvTJCKoWfhNT26G3vWmhlCeW+muu9cz4paRls=;
        b=d+yf/08XVX29WEgF+2+/nOlLVY3vrEJzZOa9Q3XgkVmH2Xu9gHILZ+aC78jg4eOFZJ
         k8ND4ys/YohTgdiGVBLyybSHx0zqMLFcSxK7oivgH/7VRQ+8AnQREoY4l/kAiMKs/edL
         V7uUAki2gwpsZOvnb2h6fzk3uhl6YEhrphI8o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XzA/u4V8M3aYurAYtNeEMdcfsHc48Kh2ZGKUyBI0GKBikJuPg46MSh9j0r8TLTjBZF
         VaSDa86kkcedLqPlRUfOFCIwLNByVvVovv6D9e8Yj6ZM7v/UpUD5hwXlSz1d8HpSof6O
         yppQL/XcvoOj8l7e+EWF7EkfgRKEh7nNe22ps=
Received: by 10.114.194.1 with SMTP id r1mr651562waf.18.1232201849931; Sat, 17 
	Jan 2009 06:17:29 -0800 (PST)
In-Reply-To: <1232164040173-2171934.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106052>

On Sat, Jan 17, 2009 at 11:47 AM, enso <a.calhoon@gmail.com> wrote:
>
>
>
> Ping Yin wrote:
>>
>> Thanks. With GIT_PAGER="" it works now.
>>
>
> Personally, I didn't like having to screw around with environment variables
> directly to get vimdiff to work. So I did the following:
>
> 1) Made a simple diff script gitvimdiff.sh:
>
> #!/bin/env sh
> vimdiff "$2" "$5"
>
> 2) git config --global diff.external ~/path/to/gitvimdiff.sh
> 3) git config --global pager.diff ""
>

I am not aware of these configurations, thanks.

What i current do is to use an alias to use vimdiff for diff
