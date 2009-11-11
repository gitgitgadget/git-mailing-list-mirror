From: Yann Simon <yann.simon.fr@gmail.com>
Subject: Re: Locally manage user/branch setting files without pushing them 
	remotely
Date: Wed, 11 Nov 2009 14:06:47 +0100
Message-ID: <551f769b0911110506x165f6b5arcf45ec920176fcdc@mail.gmail.com>
References: <9accb4400911110401g5c44d011u50cafcfe736a2ec6@mail.gmail.com>
	 <551f769b0911110414j759bd4ayfedfa779307e1a63@mail.gmail.com>
	 <9accb4400911110500y37437dc5h16388b07a734dc6d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Daniele Segato <daniele.bilug@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 11 14:06:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8CuU-0008U6-EF
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 14:06:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752154AbZKKNGn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 08:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751940AbZKKNGn
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 08:06:43 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:55668 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371AbZKKNGm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 08:06:42 -0500
Received: by fxm21 with SMTP id 21so982917fxm.21
        for <git@vger.kernel.org>; Wed, 11 Nov 2009 05:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=1aUJgpWFXUwkNPBbiD8oJW0o9W0Gp8OfHkVXnyr6lWA=;
        b=FCMbXr5FvJQQsk68/6PJuPewX3wxOE6rAaR6yGIbjctQm/RcKaKUjUC/JBZ6lG1NTk
         cIF2x+7VPX60/GCr57NSOSNHa0aTuZ4L+HbXxE23rcKKsJKzYXNuN9/aQMRJHTtieCn+
         T9wQJGlmK44A/rmjoTQqztk+Y85Nz/Zl9/+84=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=H7lTTowaKWjbAWm/s8H2vPGiGjyJNBdO54wJZIrTfr90qg6hzyV1/lMX4DJWheqsUZ
         J18RYJEauv7tVuBj8h/2HYYFWtiHlDG80Ot0wY1fukAK/cx1KE0W4KPoUi0WyKCy7nUG
         kDqCSMrIhFQdQI3ahyt+vW/fL1F77mMeY0rfQ=
Received: by 10.216.90.77 with SMTP id d55mr410691wef.146.1257944807647; Wed, 
	11 Nov 2009 05:06:47 -0800 (PST)
In-Reply-To: <9accb4400911110500y37437dc5h16388b07a734dc6d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132650>

2009/11/11 Daniele Segato <daniele.bilug@gmail.com>:
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
> hum
> but I don't want to push those files

I explained myself not well.
In my "work" branch, there is
"local changes", with the local configuration files
and then "commit xyz to push"
That's why I make a git cherry-pick work to get the last commit, the
one to push.

Yann
