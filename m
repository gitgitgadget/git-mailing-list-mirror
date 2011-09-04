From: knittl <knittl89@googlemail.com>
Subject: Re: Lost association between TAGS and COMMITs when rebased a git(1) repository
Date: Sun, 4 Sep 2011 20:15:07 +0200
Message-ID: <CACx-yZ0MJq45yUBK5T1mLwXh-maVM0WDwAz7Q4Aswh=PWQYsHg@mail.gmail.com>
References: <FF0364F3D5244CA4987EDDCFE7244BF3@urbanjsPC> <3c10d6593152436c9dd3a5b5773e3c79-mfwitten@gmail.com>
 <1B5C619E91F7437EA844D1D3DD3E6798@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Witten <mfwitten@gmail.com>,
	"John S. Urban" <urbanjost@comcast.net>, git@vger.kernel.org
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sun Sep 04 20:15:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0HEE-0006SM-Gr
	for gcvg-git-2@lo.gmane.org; Sun, 04 Sep 2011 20:15:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752374Ab1IDSP3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Sep 2011 14:15:29 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:61707 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752303Ab1IDSP1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Sep 2011 14:15:27 -0400
Received: by vxi9 with SMTP id 9so3334632vxi.19
        for <git@vger.kernel.org>; Sun, 04 Sep 2011 11:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=FKux+/uFVNZMlLaA7C1Iug033V2fD0Oup2E809OsN+8=;
        b=xkdE3ecmXQ6zabKmh9syBC/50yU9ctMBPQdxs7sbbLFINY0IPZ7KfGKXeUdzXvDmd0
         GAbMzpAEo2JE89ubfL+gp5TWZYi0gvmg2YPSkCOaP2PyM9NYnHRbceS+F9YrRnlbiltD
         hnQUadvBeEnmuO7Kvtmc69S45x5a9GkHFq6xc=
Received: by 10.52.180.199 with SMTP id dq7mr1473912vdc.80.1315160127096; Sun,
 04 Sep 2011 11:15:27 -0700 (PDT)
Received: by 10.52.188.38 with HTTP; Sun, 4 Sep 2011 11:15:07 -0700 (PDT)
In-Reply-To: <1B5C619E91F7437EA844D1D3DD3E6798@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180690>

On Sun, Sep 4, 2011 at 7:20 PM, Philip Oakley <philipoakley@iee.org> wr=
ote:
> Overall, I'm not too unhappy with the terminology, and yes I would li=
ke
> filter-branch to be able to copy across tags when creating a publisha=
ble
> history - it probably just need me to understand the right --tag-name=
-filter
> <command>.

filter-branch --tag-name-filter 'cat' ;) =96 it's even mentioned in the
manpage of filter-branch:

> The original tags are not deleted, but can be overwritten; use
>  "--tag-name-filter cat" to simply update the tags. In this case, be
> very careful and make sure you have the old tags backed up in case
> the conversion has run afoul.

unless you meant rebase with filter-branch?

--=20
typed with http://neo-layout.org
myFtPhp -- visit http://myftphp.sf.net -- v. 0.4.7 released!
