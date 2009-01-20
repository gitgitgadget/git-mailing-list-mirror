From: "Ludvig Strigeus" <strigeus@gmail.com>
Subject: Re: Git rebase -i failing on cygwin -- git checkout-index says File Exists
Date: Tue, 20 Jan 2009 21:12:39 +0100
Message-ID: <4285cd450901201212k504eeb6bp69f6543750f0259@mail.gmail.com>
References: <4285cd450901201209i792195dfmdec1fb14d627b25e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 20 21:14:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPMz9-000141-HC
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 21:14:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757592AbZATUMl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 15:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756225AbZATUMk
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 15:12:40 -0500
Received: from wf-out-1314.google.com ([209.85.200.173]:58664 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753464AbZATUMk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 15:12:40 -0500
Received: by wf-out-1314.google.com with SMTP id 27so3952281wfd.4
        for <git@vger.kernel.org>; Tue, 20 Jan 2009 12:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=E3Em4RrjUPFw8N0cu/khXVGAm9IkOnEXFyD1Quiajww=;
        b=RnP9N55h3Ac5q88VRP77FJmESPbLXbgx7dnMlPWvPtNHj5J9HntB6q8JDXCXXTrvB+
         Af/I8HKgEVQxcuRRcwugXJYbi6nReHiwKT5WHVp3QCfp/5xtA4QPb+Upx9usJFyHKa/o
         CrbUSl2lgqh699kbw8ONQQHS74WRN9uYobaiM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=cK8/QXa2l464TWeljyZauHq39ajxa6DKtmNn4/DYfr4OSJfCmRzDZXnk3niYv9iB3Q
         gKmOnXn6a8yKXJLThFBCvLyQouP+BWQQ8KDyYEFlHvIxCLPHqcruIxHcSSbUhWBpQSL+
         I6Sw/gBCp0u27eQlN+L4LnR+b3/UELB+Pppls=
Received: by 10.142.153.8 with SMTP id a8mr1438497wfe.123.1232482359314;
        Tue, 20 Jan 2009 12:12:39 -0800 (PST)
Received: by 10.143.109.1 with HTTP; Tue, 20 Jan 2009 12:12:39 -0800 (PST)
In-Reply-To: <4285cd450901201209i792195dfmdec1fb14d627b25e@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106516>

By the way, the version I use is:

$ git --version
git version 1.6.1.48.ge9b8

/Ludde

On Tue, Jan 20, 2009 at 9:09 PM, Ludvig Strigeus <strigeus@gmail.com> wrote:
> Hi,
>
> I'm having some weird problem with Git on Cygwin on Windows XP. I
> start with a totally clean repo, and then run interactive rebase to
> edit a historical commit. I exit the editor without doing anything (I
> get similar issues if I modify stuff inside the editor).
>
> $ git st
> # On branch master
> nothing to commit (working directory clean)
>
> $ git rebase -i 4a1552c81b622f85b0e9170c6fd7a22b4a3e633c
> error: git checkout-index: unable to create file util/stringfuncs.cpp
> (File exists)
> fatal: Could not reset index file to revision '4965936'.
> error: Entry 'util/boink-py.cc' not uptodate. Cannot merge.
> fatal: merging of trees 0c27b10e163f00655486976896d096302b0f5c21 and
> 7c7dfd93d678cfc564649738d45260e0b5d9f5a7 failed
> Could not apply d9c7ac9... Various reorganizations.
>
> Any clues?
>
> Thanks,
> Ludde
>
