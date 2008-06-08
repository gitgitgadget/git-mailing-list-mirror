From: "Steven Walter" <stevenrwalter@gmail.com>
Subject: Re: git-svn: multiple branches directories
Date: Sun, 8 Jun 2008 12:00:58 -0400
Message-ID: <e06498070806080900x4ecd730byefedf88aa4feee5e@mail.gmail.com>
References: <20080608002349.GB23243@xorcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 08 18:01:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5NL8-0003DJ-2N
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 18:01:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755303AbYFHQBA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 12:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754903AbYFHQBA
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 12:01:00 -0400
Received: from an-out-0708.google.com ([209.85.132.240]:33721 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754810AbYFHQA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 12:00:59 -0400
Received: by an-out-0708.google.com with SMTP id d40so422084and.103
        for <git@vger.kernel.org>; Sun, 08 Jun 2008 09:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=3fp56JAhraRat27hq8854CYEe4e6/4llDL7ehTaDhY0=;
        b=A5AK6wSl8YbiMqvcGIRS3lQ6MxH6zqI3raS+Gf7rw/pBNlf/LMhonNbnY6dPvGa6BH
         bSmmKHgHKP1V6FHyT08a2Yi8y6CuwJZAB1fFvE84CQQxYupAmcYuybaIF/SHHXnmi8o1
         z8KFsvcXoItFr9aJkRFs0UKDibBTwYl/Ty82k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=tmio5fGu6N8if9kS4P/0E08J9Mz43QY2bqRNHHBgaJy//kAFj7/uYM9EpdF5fnGLSn
         mg6S0DtzRxwtycsuzF+5wshwnied8MzkayVoJL+yOZd/36S7czkeJ7lWXZptCE/5kppt
         bllfBhSkoGqHXoJBo0WZPsOmYeVR8Pd84cDgI=
Received: by 10.100.247.14 with SMTP id u14mr2462033anh.38.1212940858400;
        Sun, 08 Jun 2008 09:00:58 -0700 (PDT)
Received: by 10.100.92.6 with HTTP; Sun, 8 Jun 2008 09:00:58 -0700 (PDT)
In-Reply-To: <20080608002349.GB23243@xorcom.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84285>

On Sat, Jun 7, 2008 at 8:23 PM, Tzafrir Cohen <tzafrir.cohen@xorcom.com> wrote:
> Hi
>
> Does git-svn support a repository layout where branches may reside under
> more than one root?
>
> /trunk
> /branches
>  branch1
>  branch2
>  branch3
> /somedir
>  branch4
>  branch5
>  branch6
> /tags
>  ...

git-svn does support it.  The way that I interact with repositories
like this is to have the main git-svn remote track only the trunk
(fetch = /trunk:...), and then to add addititonal remotes for each
branch that I want to track.  There may be a nicer way to do it, but
git-svn certainly supports the method just described.
-- 
-Steven Walter <stevenrwalter@gmail.com>
"A human being should be able to change a diaper, plan an invasion,
butcher a hog, conn a ship, design a building, write a sonnet, balance
accounts, build a wall, set a bone, comfort the dying, take orders,
give orders, cooperate, act alone, solve equations, analyze a new
problem, pitch manure, program a computer, cook a tasty meal, fight
efficiently, die gallantly. Specialization is for insects."
 -Robert Heinlein
