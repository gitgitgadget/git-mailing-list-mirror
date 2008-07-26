From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Mailing lists, was Re: [RFC] Git User's Survey 2008
Date: Sat, 26 Jul 2008 20:17:03 +0200
Message-ID: <200807262017.04413.jnareb@gmail.com>
References: <200807230325.04184.jnareb@gmail.com> <m38wvovbh2.fsf@localhost.localdomain> <20080726175121.GA15015@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jing Xue <jingxue@digizenstudio.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marek Zawirski <marek.zawirski@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Jul 26 20:18:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMoLP-0003YC-8H
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 20:18:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753696AbYGZSRP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 14:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753552AbYGZSRP
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 14:17:15 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:57157 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753194AbYGZSRO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 14:17:14 -0400
Received: by ug-out-1314.google.com with SMTP id h2so72895ugf.16
        for <git@vger.kernel.org>; Sat, 26 Jul 2008 11:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=92BdeCKVzLxMisfeQdQ1apaIEItasOCd/wZx9N4IXTM=;
        b=qfOTbaAhcv3I+NheCVy5XSxEZj5LP0+chnSO9gyh+SKqFmlEoHQoNCHnid871f1a+T
         Zufv2FwGKdmgBcIcO7IGUc+17lPqT0aTOBOQNaUgudBUbqwoQp2wPgvhcgoCzwFsD7cI
         4dmrESZR2I4svXAi7Pdjrlupi3iMPX67yXKjI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=MctH9iG7aTwmVxFrw8mwSeqcTZgVZVbJQdZ5gJ54CCeHvySjNi65VxnQWObBYKo9mX
         JUWSl4qz5DHpGt9gVKTbV+xj61foCpK1g4ZuFNUN+Xt2tn++IuF1tC7dE1yBc3wvLyaj
         OmHItjuwC1GY8Bh+WnqXiz8yObDv5Fow1E87k=
Received: by 10.67.40.6 with SMTP id s6mr937938ugj.33.1217096232366;
        Sat, 26 Jul 2008 11:17:12 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.225.191])
        by mx.google.com with ESMTPS id 27sm3771712ugp.82.2008.07.26.11.17.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 26 Jul 2008 11:17:11 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080726175121.GA15015@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90268>

On Sat, 26 July 2008, Shawn O. Pearce wrote:
> Jakub Narebski <jnareb@gmail.com> wrote:
>> Jing Xue <jingxue@digizenstudio.com> writes:
>>> 
>>> Just a thought - how about a question polling whether people would be
>>> interested in build tool wrappers around jgit - ant tasks, maven
>>> plugins, etc.?
>> 
>> True, there are a lot of tools written in Java, which have or could
>> have support for Git: Ant tasks, Maven plugins, Hudson rules
>> (continuous integration), JIRA (bug/issue tracker).  Some of them
>> perhaps could use jgit, although if I understand correctly jgit is not
>> yet full implementation of Git: it is enough for egit, for local clone
>> of repository.
> 
>   xx. What Java based build tools would you like to see Git support in?
>       (choose zero or more, multiple choice)
>    -  Ant, Maven, Hudson, JIRA, other

Some of those tools have more or less official support for Git, for
example there is Git plugin for Hudson (e.g. continuous integration)
  http://hudson.gotdns.com/wiki/display/HUDSON/Git+Plugin
and Maven SCM git provider
  http://jira.codehaus.org/browse/SCM-182

>> I wonder if similar tools like mentioned above, but for the Ruby camp,
>> like Capistrano, Merb, Gitosis, whatever use git directly, or do they
>> use Ruby interface (and which interface).  I don't think there is
>> implementation of Git in Ruby... hmmmm....
> 
> There is an implementation in Ruby, but I'm not sure what its
> state is.

What it is? URL or name, please?

It looks like alternate Git implementation are cropping left and right:
jgit in Java, widgit/Git-R-Done and git# GSoC Mono project in C#,...
but not all of them maturing.

-- 
Jakub Narebski
Poland
