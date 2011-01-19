From: Harry Johnson <hjohnson@viasic.com>
Subject: Re: Noob question regarding git push
Date: Wed, 19 Jan 2011 18:10:49 -0500
Message-ID: <AANLkTins5KrYmy6gBJXphEMhcgCEDYcbEGpb7nyU-P=m@mail.gmail.com>
References: <AANLkTi=X8PURGSX5ODHpXACUWuA0oioTkeNEmRVnkx1D@mail.gmail.com>
	<AANLkTik5QOoWNjUP8LvRE=AmiAtmchc8NND9aKDe2svR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 20 00:10:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfhB2-00074Y-PL
	for gcvg-git-2@lo.gmane.org; Thu, 20 Jan 2011 00:10:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753241Ab1ASXKv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jan 2011 18:10:51 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:38259 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753044Ab1ASXKu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jan 2011 18:10:50 -0500
Received: by gxk9 with SMTP id 9so619308gxk.19
        for <git@vger.kernel.org>; Wed, 19 Jan 2011 15:10:49 -0800 (PST)
Received: by 10.216.90.79 with SMTP id d57mr3027334wef.65.1295478649296; Wed,
 19 Jan 2011 15:10:49 -0800 (PST)
Received: by 10.216.243.129 with HTTP; Wed, 19 Jan 2011 15:10:49 -0800 (PST)
In-Reply-To: <AANLkTik5QOoWNjUP8LvRE=AmiAtmchc8NND9aKDe2svR@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165300>

Thanks! It was in that faq. So it sounds like I just need to do a git
reset --hard before doing the builds... This shouldn't be a problem
since that working tree should never have any local changes. It is
just a snapshot to be used for builds. However, it does sound like
maybe I should look into a bare repo and then the build repo could
just be a clone of that.

Thanks again!
-Harry

On Wed, Jan 19, 2011 at 5:50 PM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> Heya,
>
> On Wed, Jan 19, 2011 at 23:30, Harry Johnson <hjohnson@viasic.com> wrote:
>> What's the proper technique for making sure you see the actual changes
>> that were pushed to a repo?
>
> I think this is the FAQ you want:
>
> https://git.wiki.kernel.org/index.php/GitFaq#Why_won.27t_I_see_changes_in_the_remote_repo_after_.22git_push.22.3F
>
>
> --
> Cheers,
>
> Sverre Rabbelier
>
