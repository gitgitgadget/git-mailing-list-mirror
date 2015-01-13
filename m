From: Daniel Knittl-Frank <knittl89@googlemail.com>
Subject: Re: How to prevent empty git commit --amend
Date: Tue, 13 Jan 2015 09:59:28 +0100
Message-ID: <CACx-yZ12mn-EyR5Mx9rmACLtyeYWRdyef4jDqdFAPzeQDm03ug@mail.gmail.com>
References: <CA+iO_8mLsdsf1PepiB4M9jJh7pX8brqPdiwAvWGMdfYO0YKrCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Ivo Anjo <ivo.anjo@ist.utl.pt>
X-From: git-owner@vger.kernel.org Tue Jan 13 09:59:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YAxKN-00018V-Ju
	for gcvg-git-2@plane.gmane.org; Tue, 13 Jan 2015 09:59:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbbAMI7v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2015 03:59:51 -0500
Received: from mail-qc0-f171.google.com ([209.85.216.171]:43404 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751132AbbAMI7u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2015 03:59:50 -0500
Received: by mail-qc0-f171.google.com with SMTP id r5so1271996qcx.2
        for <git@vger.kernel.org>; Tue, 13 Jan 2015 00:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=bu/6DnPARIqNqSorSQb+gT4icXXyHxSVWJEXKuKxvXs=;
        b=oVG1vACwdruV6OsEnY2wF/ZbCs9t2E7WSQfjWV66Di2Ahx2+B5u4rhffMXsn202+tm
         drAOPr2jwtWRVs4r6Hy0424z8f5c1bU2M3i3Jwb0wQznRLnkAsS6C1kiC2ni+K03aNXl
         iOnMpXePAhpYztjdHH48xi45ShZsY5wdOooK+j7FYI0bMd8YhnwvrFL9Ihgq2HQ4lT7t
         B4xRi+b0uvcD/BKJ3Iczo3/X1x0RRgI5+zDHGVIiC6p9UHT6BulyrMHIMObQkY/qdJso
         CVw6YJAYhZZSmhTNmqGKMJ3og8wMrt9lAx6SVgOTIsnnRPdK0oT2c2vshgThow3F6GbJ
         Plkg==
X-Received: by 10.224.47.8 with SMTP id l8mr47193492qaf.20.1421139590110; Tue,
 13 Jan 2015 00:59:50 -0800 (PST)
Received: by 10.140.202.136 with HTTP; Tue, 13 Jan 2015 00:59:28 -0800 (PST)
In-Reply-To: <CA+iO_8mLsdsf1PepiB4M9jJh7pX8brqPdiwAvWGMdfYO0YKrCQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262330>

On Tue, Jan 13, 2015 at 9:56 AM, Ivo Anjo <ivo.anjo@ist.utl.pt> wrote:
> Hello,
>
> I sometimes get a bit distracted when making amends. Once or twice per
> week I do a commit, then realize I added something I shouldn't, or
> forgot to add a line here or there, and then I do a git commit --amend
> to fix it.
>
> The thing is, a lot of times I forget to stage the modifications I did.
> And here is my issue: *git commit* refuses to work when there's
> nothing to commit, but *git commit --amend* happily pops up the editor
> and says you have committed something when you did not add/change
> anything.
>
> Is there a way to prevent a *git commit --amend** with nothing to
> commit from working?
> If not, I would like to suggest that this feature would be very helpful :)

Hi Ivo,

simply delete all text from the commit editor and exit/save the empty
file. This will abort the commit.

The same logic applies to git rebase --interactive: deleting
everything will do nothing.

Regards,
Daniel

-- 
typed with http://neo-layout.org
