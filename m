From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Checkout tag?
Date: Sun, 22 Jan 2012 11:08:00 -0600
Message-ID: <20120122170800.GA29215@burratino>
References: <1327226753653-7213023.post@n2.nabble.com>
 <20120122101116.GA31022@jpl.local>
 <1327227956026-7213061.post@n2.nabble.com>
 <20120122113115.GA31545@jpl.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Abscissa <bus_nabble_git@semitwist.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Magnus =?utf-8?B?QsOkY2s=?= <magnus.back@sonyericsson.com>
X-From: git-owner@vger.kernel.org Sun Jan 22 18:08:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rp0tr-00051o-C9
	for gcvg-git-2@lo.gmane.org; Sun, 22 Jan 2012 18:08:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752127Ab2AVRIJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Jan 2012 12:08:09 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:45298 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751961Ab2AVRII convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Jan 2012 12:08:08 -0500
Received: by iacb35 with SMTP id b35so2466083iac.19
        for <git@vger.kernel.org>; Sun, 22 Jan 2012 09:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=fq681jaE1zIAFR8uLCUI9EBaK/8KlaDwRbdWpoAjqVc=;
        b=FC2B7UXsAVFhp5EQvoYAS7PPOWqOOgBtQbYCnFr60boaGAmP4yQy4MhxHPPrQknIpO
         VXBY3/r4injuQQ3uIqvLztG+6oXqLW5HaaOkJX+oy/4iZVODw4a9rBpejjTE2OH7oVLX
         wTmabduG2UX14k04i1SnQeJ0iT85etm8uyTHc=
Received: by 10.50.157.131 with SMTP id wm3mr6504454igb.13.1327252087584;
        Sun, 22 Jan 2012 09:08:07 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id h9sm36603414ibh.11.2012.01.22.09.08.06
        (version=SSLv3 cipher=OTHER);
        Sun, 22 Jan 2012 09:08:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120122113115.GA31545@jpl.local>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188966>

Hi,

Magnus B=C3=A4ck wrote:

> Looking at an up to date Git 1.7.9-rc2 man page, it still seems
> slightly inconsistent with itself. The synopsis at the top says
>
>       git checkout [-p|--patch] [<tree-ish>] [--] [<paths>...]
>
> while the text in the DESCRIPTION section says
>
>       git checkout [-p|--patch] [<tree-ish>] [--] <pathspec>...

Hmm, my copy says:

	SYNOPSIS

	git checkout [-q] [-f] [-m] [<branch>]
	git checkout [-q] [-f] [-m] [--detach] [<commit>]
	git checkout [-q] [-f] [-m] [[-b|-B|--orphan] <new_branch>] [<start_po=
int>]
	git checkout [-f|--ours|--theirs|-m|--conflict=3D<style>] [<tree-ish>]=
 [--] <paths>...
	git checkout [-p|--patch] [<tree-ish>] [--] [<paths>...]

	DESCRIPTION

	... overview ...

	git checkout [<branch>], git checkout -b|-B <new_branch> [<start point=
>],
	git checkout [--detach] [<commit>]

		This form switches branches by updating the index, working
		tree, and HEAD...

	git checkout [-p|--patch] [<tree-ish>] [--] <pathspec>...

		When <paths> or --patch are given, git checkout does not
		switch branches. It updates the named paths...

So in the synopsis it lists five forms, and in the description section
it lists two forms, the first of which has three variants.

It's not immediately obvious to me which inconsistency you are
pointing to as a source of confusion.  Could you elaborate, preferably
with suggested wording for a fix?  If you can do so in the form of a
patch, all the better. ;-)

Thanks,
Jonathan
