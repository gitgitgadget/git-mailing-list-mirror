From: Mike Ralphson <mike.ralphson@gmail.com>
Subject: Re: adding arbitary folders to the git index, from outside of the 
	repository
Date: Wed, 29 Apr 2009 08:44:50 +0100
Message-ID: <e2b179460904290044q2f55ff90x4a8f3b9cab18006b@mail.gmail.com>
References: <8ABE87D6-F70D-4A86-8307-88B95FAF350F@patchprint.co.nz>
	 <200904290206.31153.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andrew Bush <andrew@patchprint.co.nz>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 09:45:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lz4TV-0001iv-Qn
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 09:45:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752437AbZD2How (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 03:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752042AbZD2How
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 03:44:52 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:38855 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751288AbZD2Hov (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 03:44:51 -0400
Received: by fxm2 with SMTP id 2so1000530fxm.37
        for <git@vger.kernel.org>; Wed, 29 Apr 2009 00:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Ml12JOD6OV9GDVIjR6F0/a/9Vvxu+B9m51Bw+Z6Chow=;
        b=vprVR/nO46yzn76Y+CsUY0R5CQsL+jk6r1O9cdPz6aT2C9CIVQ8Fnd81+uteGYcikS
         TcCP55Bt4Ey9cfVDizfwASECAjIJ2LVSZWOvnYS9yOgbgiK9jlBXtOghcbh9bIDeUrpO
         lbeqkkQUHASFED9yV8vIy5V72qF/pUHk4sU2s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Iti5FG7raPRJWUiWkt5arSyL5c0EE2yAhC3mzo3TRL9SEk5W2QMeoQJ1McZA8pwfSO
         SaEFoC5YySXpEkOeZOrSgQ1LfocW+T/57IUlmSGIHNN0GSjzd2zyidXxI1Vb9MoymilY
         yHbQuqCKqnJ76ayPqQ8VIG6Q87TYiGxOxC9/o=
Received: by 10.223.123.129 with SMTP id p1mr11991far.29.1240991090542; Wed, 
	29 Apr 2009 00:44:50 -0700 (PDT)
In-Reply-To: <200904290206.31153.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117862>

2009/4/29 Robin Rosenberg <robin.rosenberg.lists@dewire.com>:
> onsdag 29 april 2009 00:54:54 skrev Andrew Bush:
>> I have a desire to have a single git repository that tracks the
>> content of an array of folders located in various places across my
>> file system.

> What I do sometimes is set GIT_DIR and then add paths relative to
> / and adding excludes for some paths. That way I can cover /etc and
> selected parts of /var and other interesting areas. You cannot
> however have different roots for your trees, unless you make
> the tree using e.g symbolic links to the different directories.

You can also support having different roots for your trees if you
commit them to distinct branches. You would need to remember which
root applies to each branch, but you could name the branches var, etc,
usr/local/etc, home/andrew etc.

Mike
