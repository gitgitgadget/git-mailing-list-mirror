From: "Erez Zilber" <erezzi.list@gmail.com>
Subject: Re: git-describe doesn't show the most recent tag
Date: Sun, 28 Sep 2008 18:05:51 +0300
Message-ID: <ce513bcc0809280805wb0598b7r8d5e89c1187b080d@mail.gmail.com>
References: <ce513bcc0809280648s352cda3fj5eb35b6e9cd40af9@mail.gmail.com>
	 <20080928135526.GG5302@artemis.corp>
	 <ce513bcc0809280729p47cc3790nb77b3cae8b805221@mail.gmail.com>
	 <20080928143949.GH5302@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	open-iscsi@googlegroups.com
To: "Pierre Habouzit" <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sun Sep 28 17:07:02 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjxrR-0007CK-I1
	for gcvg-git-2@gmane.org; Sun, 28 Sep 2008 17:07:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751670AbYI1PFw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Sep 2008 11:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbYI1PFw
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Sep 2008 11:05:52 -0400
Received: from rv-out-0506.google.com ([209.85.198.226]:26197 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751453AbYI1PFw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Sep 2008 11:05:52 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1821860rvb.1
        for <git@vger.kernel.org>; Sun, 28 Sep 2008 08:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=KkqybRDuvZaqxcgMkkuD1MAfo4Hu8twhfUh/SeTi50U=;
        b=P4wkc1Hv+lMuRlzdFad3+63B1HuxQ6h4tEKsyO6l43azC5s0hzM4m2a71XcVwqtTiD
         9TSOSL9IwBF9iYCctjiqPClESNP9tMTwy8ZP3tiv5WHJ/PziTyxJMaN2KXD2Z6iYSU5k
         n927jTmMoPKKjb/WKb1cOHK6F9KaxLy4H6WAM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=jr2h7rlX8Zf4HxHLVoDEdhfQvQv9SIk6jygw0ygNC7gaTl53D6W3wrc04HSDEE5pZ8
         +3GA3peq8RPGk2/ZHOoj4M0kLuZ54UFdlC0U01GAAiCngONbfzvqqCRsmZw7xQ/EA5QH
         PqiGsi0ce+CotLliyGRRO1Zvgnb2iv1UmY2Mg=
Received: by 10.141.206.13 with SMTP id i13mr1870528rvq.211.1222614351482;
        Sun, 28 Sep 2008 08:05:51 -0700 (PDT)
Received: by 10.141.91.21 with HTTP; Sun, 28 Sep 2008 08:05:51 -0700 (PDT)
In-Reply-To: <20080928143949.GH5302@artemis.corp>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96972>

On Sun, Sep 28, 2008 at 5:39 PM, Pierre Habouzit <madcoder@debian.org> wrote:
> On Sun, Sep 28, 2008 at 02:29:21PM +0000, Erez Zilber wrote:
>> On Sun, Sep 28, 2008 at 4:55 PM, Pierre Habouzit <madcoder@debian.org> wrote:
>> > On Sun, Sep 28, 2008 at 01:48:42PM +0000, Erez Zilber wrote:
>> >> Why is this happening?
>> >
>> >       --tags
>> >           Instead of using only the annotated tags, use any tag found in
>> >           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> >           .git/refs/tags.
>> >
>>
>> I'm not sure that I understand the difference between tags and annotated tags.
>
>  a lightweight tag is just a reference. an annotated tag has a message
> associated. Usually tags are meant as local help, whereas annotated tags
> are the ones pushed to the repositories and that never change. That's
> why many tools ignore non annotated tags by default unless you pass
> --tags to them.

Thanks for the explanation.

>
>> Anyway, if I move to the master branch, I see the following tags:
>>
>> [erez.zilber@erez-lx:/tmp/open-iscsi.git]$ ls .git/refs/tags/
>> 2.0-868-rc1  2.0-869  2.0-869.1  2.0-869.2  2.0-869-rc2  2.0-869-rc3
>> 2.0-869-rc4  2.0-870-rc1
>> [erez.zilber@erez-lx:/tmp/open-iscsi.git]$ git-tag
>> 2.0-868-rc1
>> 2.0-869
>> 2.0-869-rc2
>> 2.0-869-rc3
>> 2.0-869-rc4
>> 2.0-869.1
>> 2.0-869.2
>> 2.0-870-rc1
>>
>> However:
>> [erez.zilber@erez-lx:/tmp/open-iscsi.git]$ git-describe --tags
>> 2.0-868-rc1-81-g31c9d42
>>
>> I was expecting to see 2.0-870-rc1 here.
>
>  That's because master is not at -rc1 exactly, but some commits
> afterwards. Please read the git-describe manpage fully, it's _really_
> well explained:
>
>       The command finds the most recent tag that is reachable from a commit.
>       If the tag points to the commit, then only the tag is shown. Otherwise,
>       it suffixes the tag name with the number of additional commits on top
>       of the tagged object and the abbreviated object name of the most recent
>       commit.
>
>
> Which means that your master is 81 commits ahead of the exact 2.0-860-rc1 tag,
> at sha1 31c9d42

I read that, but I still don't understand what happens in the open-iscsi tree:

[erez.zilber@erez-lx:/tmp/open-iscsi.git]$ cat .git/refs/tags/2.0-870-rc1
5e80c8167c112687ae7b30b1e40af6f03088c56c

The head is 12 commits from the 2.0-870-rc1 tag. Therefore, I expected
to see something like 2.0-870-rc1-12-some_hash (not
2.0-868-rc1-81-g31c9d42).

Erez
