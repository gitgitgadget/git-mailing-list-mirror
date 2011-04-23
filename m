From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Cloning into an existing, non-empty directory?
Date: Sat, 23 Apr 2011 05:37:58 -0500
Message-ID: <20110423103758.GA1883@elie>
References: <BANLkTi=VwiqN99AMEJb6jb1uFya2Hipibw@mail.gmail.com>
 <20110421220327.GA3396@elie>
 <BANLkTikY7c7rP+yv5vt2vxw5nu84k_H=Xw@mail.gmail.com>
 <20110423101500.GB1500@elie>
 <BANLkTi=uNpruRhPcxKMUy4CH2V5q-z9U7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Richard Hartmann <richih.mailinglist@gmail.com>,
	Git List <git@vger.kernel.org>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 23 12:38:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QDaE8-00020h-NG
	for gcvg-git-2@lo.gmane.org; Sat, 23 Apr 2011 12:38:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753156Ab1DWKiJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Apr 2011 06:38:09 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:36179 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752493Ab1DWKiF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2011 06:38:05 -0400
Received: by mail-iy0-f174.google.com with SMTP id 14so914636iyb.19
        for <git@vger.kernel.org>; Sat, 23 Apr 2011 03:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=kN3JXa3nYMUiFIqVOarBn6mw/qfoyzpNk9MSpUyH5nA=;
        b=kkGSAcRb74y8bfEM/xD1eDB77UBJHyehM0FXyAZl3D1YpMrLAxnVFqKUOpnVp4Mwj3
         LMMunj5upj9F8e7H2+QEgKqv1epWXgfanmn3vSJOoDVAG7VljnZ9sZSruP/SKWcHyRoS
         Oy9JZcglzNKJC0agjTByrszVZppC8Ts1QLIqc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=CwELLhEtjM1aY1OI6ZWELk13w7UFdlwovxE8dHihg639puOAjJQwFnUB3CbLrO2eUU
         NuepnN5SDE0ckEN6is5okxNbK/TKs8EVdCAVqg79IZUxjp6fCwqsOpig43tuzvicjuQx
         TejTrWhkRjQUQFFdG7+GcjUYsKw5apqc+TuIU=
Received: by 10.42.21.204 with SMTP id l12mr2279919icb.341.1303555084462;
        Sat, 23 Apr 2011 03:38:04 -0700 (PDT)
Received: from elie (adsl-69-209-64-141.dsl.chcgil.sbcglobal.net [69.209.64.141])
        by mx.google.com with ESMTPS id ul1sm281147icb.16.2011.04.23.03.38.02
        (version=SSLv3 cipher=OTHER);
        Sat, 23 Apr 2011 03:38:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTi=uNpruRhPcxKMUy4CH2V5q-z9U7Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171981>

Nguyen Thai Ngoc Duy wrote:
>> Richard Hartmann wrote:

>>> 2) running `git pull` as suggested results in:
>>>
>>> fatal: /usr/lib/git-core/git-pull cannot be used without a working tree.
[...]
> Does this patch help?
> 
> http://article.gmane.org/gmane.comp.version-control.git/150986

That's what I was thinking of but on second thought that can't be it.
Richard's script does chdir into $GIT_WORK_TREE.

So it's still puzzling, and a reduced testcase would be nice. :)

Thanks, both, and sorry for the nonsense.
