From: bd_ <bdonlan@gmail.com>
Subject: Re: commit type
Date: Sun, 2 Nov 2008 18:02:09 -0500
Message-ID: <3e8340490811021502p70ab40a1ocdc9fca012769a29@mail.gmail.com>
References: <loom.20081031T174821-603@post.gmane.org>
	 <ee77f5c20810311104m6044bf70r1d9d405fa04454e0@mail.gmail.com>
	 <loom.20081031T191102-81@post.gmane.org>
	 <alpine.DEB.1.00.0811010025570.22125@pacific.mpi-cbg.de.mpi-cbg.de>
	 <loom.20081101T034635-562@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: 7rans <transfire@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 03 00:03:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kwlyg-0004Nc-E5
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 00:03:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753260AbYKBXCM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 18:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753258AbYKBXCM
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 18:02:12 -0500
Received: from qw-out-2122.google.com ([74.125.92.26]:36957 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753136AbYKBXCL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 18:02:11 -0500
Received: by qw-out-2122.google.com with SMTP id 3so1000113qwe.37
        for <git@vger.kernel.org>; Sun, 02 Nov 2008 15:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=uaS67whHlcEAuzSBpPHTuNEc2h8HeGDzqagSi3mJ5m0=;
        b=erLXwDS0k+VQxIhFuYpYtWYQuFpPyOR5pTQN7HlsHvTQbmHb2l5fNRzHRgR7PWbLhd
         9YyTV+aXHaEO6ppR9HdF6Irls46W3VcnDQv0tzNrOdzoz2xft9o4xim8jpaqsJCkhjM7
         x/BfOsApXzJM44IaBQRG4BR/bvEYD8E6yl56Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ZBL6yrLk469TZuK3UrfRSPw5QAnEcw891bZbRJ+AhoDLf8mHb3/54A0i9KGGUO/Fov
         wim2LQo9E3kntY7iXUCroMULzpiJLS6C5bzM7eozOZNhB+LE3vP26Yg9YJY/2EcJA2E+
         C39Yrm5dsnm0YK7RFKToMW6Tl3JOzY0mpene4=
Received: by 10.214.182.12 with SMTP id e12mr2827645qaf.240.1225666930016;
        Sun, 02 Nov 2008 15:02:10 -0800 (PST)
Received: by 10.214.215.5 with HTTP; Sun, 2 Nov 2008 15:02:09 -0800 (PST)
In-Reply-To: <loom.20081101T034635-562@post.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99884>

On Fri, Oct 31, 2008 at 11:15 PM, 7rans <transfire@gmail.com> wrote:
> Johannes Schindelin <Johannes.Schindelin <at> gmx.de> writes:
>
>> So you want to force this onto all Git users?
>
> Not at all. It would be a purely optional. You would never even need to know the
> feature existed if you didn't want to use it. So I'm not sure how that is
> forcing it upon anyone.
>
> Moreover, I suggested it b/c I would find such a feature very useful, and, by
> extension, thought others might as well. Perhaps others have done something
> similar, in which case it would be interesting the hear their take, or on the
> other hand they've never considered it before, but now can consider the
> potential utility of just such a feature.
>
>> If yes: that murmur you hear in the background, it might well be the
>> collective "thanks, but no thanks" of people who do not want that type of
>> distinction between different commits
>
> There is no need to make one. It's purely annotative.

The problem with this approach is that it begins to dictate a set of
annotations which are considered 'more important' by the git core than
others. By allowing in your 'commit type', it sets a precedent that
git will add random, possibly not backwards compatible metadata
changes just to support the local policies of some subset of git
users. It's far better to provide a generic feature that will cover
all users; and using the commit description, with hooks to enforce
proper format according to local policy, is just that.

If using the commit description, with hooks to enforce whatever
formatting you prefer, is not sufficient for your needs, then it would
be useful to discuss exactly how this would be deficient, and then
possibly think about adding a /generic/ feature that meets your needs.
