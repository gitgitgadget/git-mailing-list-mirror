From: Peter Harris <git@peter.is-a-geek.org>
Subject: Re: git-svn and repository hierarchy?
Date: Fri, 6 Mar 2009 11:58:36 -0500
Message-ID: <eaa105840903060858g5b8f31bpb9a59d563835a9d5@mail.gmail.com>
References: <20090227220512.GC14187@raven.wolf.lan>
	 <20090303185108.GA11278@raven.wolf.lan>
	 <eaa105840903031135o4cf72ed0oe3fffed69cb7ce03@mail.gmail.com>
	 <20090303223600.GB11278@raven.wolf.lan>
	 <eaa105840903031618s5e0b6f24j64aade8d752fb11@mail.gmail.com>
	 <20090304192752.GC11278@raven.wolf.lan>
	 <eaa105840903041406k36088763w5a70fe1d7458dfb1@mail.gmail.com>
	 <20090305180529.GD11278@raven.wolf.lan>
	 <eaa105840903051148s3515e8b7x9d7b8f9be12da735@mail.gmail.com>
	 <20090306161026.GA14554@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 06 18:00:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfdP6-0001iP-DM
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 18:00:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752559AbZCFQ6l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 11:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752063AbZCFQ6k
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 11:58:40 -0500
Received: from yw-out-2324.google.com ([74.125.46.29]:46287 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964AbZCFQ6j (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 11:58:39 -0500
Received: by yw-out-2324.google.com with SMTP id 5so321858ywh.1
        for <git@vger.kernel.org>; Fri, 06 Mar 2009 08:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=hxWstSnsK8HiNqSrzPswKYa/YFMcv0Ci1uomQWHt2uM=;
        b=dqIyD1ZlNkSlCvv+YJcD3bX0xcQMwhNz4U65N445Xzn+XPzyUuj17fF0wOc2g+sDmG
         4P2lzUrLwBRApkG+ZGGuSD+TQCw3k3MS7ZQdA6CiTyblOM5wLNokc0n9qcVZXbOJzTr5
         aW/E06wDiL2b8fEgBrEfnTA6qIHbCvEbluW7Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=VUO6hf8Vrg8oMj8EnO/kPlIHpvaW41S6J9NSUoi8Ps+XQOED71SwWb6GN3thLw4Pa6
         LoiASIqztrb4CBbIsAJvJBweyhpfR3WozVN06n1uGYc9jxWUPKl8xE8LeOhiuKhpEN0W
         oeER+mo/SydXG5/zmM0fTETdwQ2ikU3gkHxXM=
Received: by 10.220.46.17 with SMTP id h17mr891770vcf.9.1236358716780; Fri, 06 
	Mar 2009 08:58:36 -0800 (PST)
In-Reply-To: <20090306161026.GA14554@raven.wolf.lan>
X-Google-Sender-Auth: 9e03285b750b190a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112467>

On Fri, Mar 6, 2009 at 11:10 AM, Josef Wolf wrote:
> On Thu, Mar 05, 2009 at 02:48:14PM -0500, Peter Harris wrote:
>>
>> True, but in my experience it happens considerably less often with
>> git. I find and fix most of my typos when reviewing my change-set
>> before doing a "git push" or "git svn dcommit".
>
> So you are rewriting yourself but not accept rewrites by svn ;-)

No, I am not rewriting myself *after I publish*. I see the smiley, but
I think you missed the point.

"git push" or "svn ci" is the end of the rewrites.

The critical difference is that I can easily manage an entire
unpublished patch series in git. I cannot in svn (without 3rd party
tools such as quilt or git-svn, anyway). So in svn if I notice a typo
near the beginning of a patch series as I am publishing the last of
the series, I'm screwed.

>> Indeed. Or even not-so-random names, such as cloneX/topic-name if you
>> prefer.
>
> That would have the risk of multiple clones pushing to the same branch.

Only if cloneX pushes to cloneY/topic-name. Does each clone not have a
unique name?

> Does that look sane?

No. But it doesn't look any more insane than any other workflow
involving Subversion that I can think of. :-)

Peter Harris
