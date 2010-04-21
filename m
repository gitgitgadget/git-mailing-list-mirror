From: Bradley Wagner <bradley.wagner@hannonhill.com>
Subject: Re: SVN to Git: trunk moved during repository history
Date: Wed, 21 Apr 2010 10:03:16 -0400
Message-ID: <l2o2f0f6ced1004210703rf3ce8781kd209e99d2b577b76@mail.gmail.com>
References: <l2x2f0f6ced1004191416jd8db7d5eyf8fc7a55f5efa2cc@mail.gmail.com>
	 <o2i2f0f6ced1004191418i6a144652sd9ac38b07fb7b661@mail.gmail.com>
	 <hqir8c$sqh$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Stephen Kelly <steveire@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 21 16:03:24 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4aWQ-0002Dh-Mn
	for gcvg-git-2@lo.gmane.org; Wed, 21 Apr 2010 16:03:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752826Ab0DUODR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Apr 2010 10:03:17 -0400
Received: from mail-iw0-f197.google.com ([209.85.223.197]:50395 "EHLO
	mail-iw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752552Ab0DUODR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Apr 2010 10:03:17 -0400
Received: by iwn35 with SMTP id 35so3866067iwn.21
        for <git@vger.kernel.org>; Wed, 21 Apr 2010 07:03:16 -0700 (PDT)
Received: by 10.231.4.141 with HTTP; Wed, 21 Apr 2010 07:03:16 -0700 (PDT)
In-Reply-To: <hqir8c$sqh$1@dough.gmane.org>
Received: by 10.231.144.197 with SMTP id a5mr2904464ibv.5.1271858596178; Wed, 
	21 Apr 2010 07:03:16 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145431>

Hmm, I'm not seeing where in the documentation you would instruct it
to look in multiple locations in the SVN repository's history for the
trunk branch.

On Mon, Apr 19, 2010 at 8:07 PM, Stephen Kelly <steveire@gmail.com> wro=
te:
> Bradley Wagner wrote:
>
>> I'm trying to port an SVN project to Git. We have gone through
>> multiple layouts for our SVN repository. It started off with just a
>> mainline branch in the root folder. Then we went to the standard
>> layout (branches, trunk, tags).
>>
>> The problem is that when I do a "git svn clone --stdlayout" of the
>> repository, it's not picking up any of the revisions from when the
>> trunk previously resided in the root directory.
>> Is there any way to specify that the trunk had multiple paths the wa=
y
>> you can specify multiple branch folders with -b flag? What would be
>> the best course of action for reporting an SVN repo who's layout had
>> changed during its history?
>
> One option is svn2git
>
> http://gitorious.org/svn2git/svn2git
>
> http://techbase.kde.org/Projects/MoveToGit/UsingSvn2Git
>
> examples:
>
> http://gitorious.org/svn2git/kde-ruleset
>
>>
>> Thanks,
>> Bradley
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
