From: "Scott Chacon" <schacon@gmail.com>
Subject: Re: Mailing lists, was Re: [RFC] Git User's Survey 2008
Date: Sat, 26 Jul 2008 11:38:59 -0700
Message-ID: <d411cc4a0807261138k8cfde7eo411ddb8ef3ec4cfd@mail.gmail.com>
References: <200807230325.04184.jnareb@gmail.com>
	 <20080725172313.GE21117@spearce.org>
	 <7vr69hsss1.fsf@gitster.siamese.dyndns.org>
	 <200807252352.09751.jnareb@gmail.com>
	 <20080725215707.GC23202@spearce.org>
	 <20080726155138.GB20695@jabba.hq.digizenstudio.com>
	 <m38wvovbh2.fsf@localhost.localdomain>
	 <20080726175121.GA15015@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Jul 26 20:40:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMogU-00033D-7U
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 20:40:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751989AbYGZSjB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 14:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752071AbYGZSjB
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 14:39:01 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:40916 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967AbYGZSjA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 14:39:00 -0400
Received: by wa-out-1112.google.com with SMTP id j37so2451267waf.23
        for <git@vger.kernel.org>; Sat, 26 Jul 2008 11:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=sIAwP68IvhFucP1nO7Dqtzm/I5QzE5R7zqOenEJ0toQ=;
        b=mueceveWz7Tty/W5ESq9i5raI4QrTcGM9/VzoUs11cLgRvhPVI5wzq389YANTu7C41
         02n7uI50giZcHjcnsaOQICTWHPLvPvoGifgsfH2Sv0wYJdVU52oA6Xuki7GaS7GZxk4G
         Vm6bn8iM4aAk/1ScHr94DoofsUywCli1Qz5Yg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=aOlTgkbiXMtIBRmsB51Pd2n9Ziqk8bLyyUWmtMxTQDXpXZtUc8npM50GQpyGgq8QB7
         9qGccm5L/w8WebvFt9f6K9Zq0gaV6WYJKwCRnPscMqsFwzvZ/npg2z3FbMf2ZbZnnhjk
         KEQLPh0NXzfl4q8fLIibXjf5/S24MPVIFKYA4=
Received: by 10.114.181.1 with SMTP id d1mr3393920waf.3.1217097539987;
        Sat, 26 Jul 2008 11:38:59 -0700 (PDT)
Received: by 10.115.22.20 with HTTP; Sat, 26 Jul 2008 11:38:59 -0700 (PDT)
In-Reply-To: <20080726175121.GA15015@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90271>

On Sat, Jul 26, 2008 at 10:51 AM, Shawn O. Pearce <spearce@spearce.org> wrote:
> Jakub Narebski <jnareb@gmail.com> wrote:
>> Jing Xue <jingxue@digizenstudio.com> writes:
>> >
>> > Just a thought - how about a question polling whether people would be
>> > interested in build tool wrappers around jgit - ant tasks, maven
>> > plugins, etc.?
>>
>> True, there are a lot of tools written in Java, which have or could
>> have support for Git: Ant tasks, Maven plugins, Hudson rules
>> (continuous integration), JIRA (bug/issue tracker).  Some of them
>> perhaps could use jgit, although if I understand correctly jgit is not
>> yet full implementation of Git: it is enough for egit, for local clone
>> of repository.
>
>  What Java based build tools would you like to see Git support in?
>  (choose zero or more, multiple choice)
>  Ant, Maven, Hudson, JIRA, other
>
>> I wonder if similar tools like mentioned above, but for the Ruby camp,
>> like Capistrano, Merb, Gitosis, whatever use git directly, or do they
>> use Ruby interface (and which interface).  I don't think there is
>> implementation of Git in Ruby... hmmmm....
>
> There is an implementation in Ruby, but I'm not sure what its
> state is.
>

The most up-to-date project is 'Grit', a spinoff of the GitHub site.
It has a number of things implemented in pure-ruby and is under active
development.  It runs GitHub, Gitorious, GitNub (osx tool), etc.

http://github.com/mojombo/grit/tree/master

Scott
