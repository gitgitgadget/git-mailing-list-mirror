From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Subject: Re: Locally manage user/branch setting files without pushing them 
	remotely
Date: Wed, 11 Nov 2009 14:46:43 +0100
Message-ID: <4d8e3fd30911110546m1a5012f2g99f2d0c7ca829876@mail.gmail.com>
References: <9accb4400911110401g5c44d011u50cafcfe736a2ec6@mail.gmail.com> 
	<551f769b0911110414j759bd4ayfedfa779307e1a63@mail.gmail.com> 
	<9accb4400911110500y37437dc5h16388b07a734dc6d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Yann Simon <yann.simon.fr@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Daniele Segato <daniele.bilug@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 11 14:47:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8DXT-0002By-Ul
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 14:47:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755745AbZKKNq7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 08:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755099AbZKKNq7
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 08:46:59 -0500
Received: from gv-out-0910.google.com ([216.239.58.189]:8088 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752718AbZKKNq6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 08:46:58 -0500
Received: by gv-out-0910.google.com with SMTP id r4so52032gve.37
        for <git@vger.kernel.org>; Wed, 11 Nov 2009 05:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=DH89AwEfQ8e14MEfRLNn/+DLjxb/ElmaUB3VzaJf8YM=;
        b=DCLSlPX5VRXwdAwNirizl17iqOkfwZAFanXA6Cq4Q4AREgtWSDEO8R4cbmjTG6Vhj7
         w5LvHFOjUUfSxrYikE3pcGB3vGAQp8+yzOOphtDShIdWdHU3XupMSSzUqZaPOK0nbuDk
         2efA7S9jXHjfQW53OIHwBCHmDY5dhFv9ig4Xc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=UtV6yxv7V2/AdBsLGfI2d90NHYKOgMkFPIVNEb0Le82WPPJI3LPJRJ0wXDakiwIrsx
         85WaqxpnuQsjBmqMvPT3Q0wUQ0r46xOaYUfEvL2d/x7jKn2eIAZBXSWmAg9ffupv6Vx9
         ppCiPfwvzfHphwNvuJB0oX7tCAE8o1n8MCWKE=
Received: by 10.239.163.199 with SMTP id q7mr149877hbd.29.1257947223073; Wed, 
	11 Nov 2009 05:47:03 -0800 (PST)
In-Reply-To: <9accb4400911110500y37437dc5h16388b07a734dc6d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132651>

On Wed, Nov 11, 2009 at 2:00 PM, Daniele Segato <daniele.bilug@gmail.com> wrote:
> On Wed, Nov 11, 2009 at 1:14 PM, Yann Simon <yann.simon.fr@gmail.com> wrote:
>> I am in the same situation.
>> What I did is not to add these files to .gitignore.
>> On my "work" branch, I commited these files in a separate commit
>> "local changes".
>> When I want to push to svn, I switch to the branch "master", and
>> cherry-pick the commit I want to push.
>> $ git checkout master
>> $ git svn rebase
>> $ git cherry-pick work
>> $ git svn dcommit
>> $ git checkout work
>> $ git rebase master
>>
>> This workflow could maybe be better. Suggestions welcome.
>
> hum
> but I don't want to push those files

If you follow Yann's advise you won't push to the svn repo the "private" files,
they will be /only/ stored in you local repo.

The cons of that approach is that you will have to cherrypick all the
commits you want to push to the svn repo from the "working branch" to
the master branch.

Ciao,
-- 
Paolo
