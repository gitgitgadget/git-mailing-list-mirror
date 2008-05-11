From: "Steve French" <smfrench@gmail.com>
Subject: Re: CIFS fixes
Date: Sun, 11 May 2008 11:53:23 -0500
Message-ID: <524f69650805110953t6561ff84t1867681bea093d35@mail.gmail.com>
References: <524f69650805082054g43823f85i623cb2c11cd01039@mail.gmail.com>
	 <alpine.LFD.1.10.0805090810390.3142@woody.linux-foundation.org>
	 <524f69650805110942k7ccb065bm2c1e60f1a509af5a@mail.gmail.com>
	 <alpine.LFD.1.10.0805110948530.3330@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun May 11 18:54:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvEoT-0003sK-Cz
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 18:54:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753499AbYEKQx2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 12:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753437AbYEKQx2
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 12:53:28 -0400
Received: from fk-out-0910.google.com ([209.85.128.187]:28008 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753421AbYEKQx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 12:53:27 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1708149fkq.5
        for <git@vger.kernel.org>; Sun, 11 May 2008 09:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=u+/SoZQ4GvWHfL+QMzfmFtMVpnDg7PPYOKyfpDC6hqA=;
        b=MfqYPepx2LoDIl5pzpd1uQZQLPWUCUi7/6Z3GZY+8xeZEvyeBEM1kzKBgX4FhJX538LEtNkMXEd8YyzgHeSqKvxskOtjFnUBKgWJeRZI11qQuvPNvqzVqr8SmgqDsrpVu96qrl7TpMiaepUSwc4VRk5KBxf0oDTjA5t9hLSovNk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=q5N6A0HY3GGwfwWWTDfm+zesuiDfhdMyyFAJLiCARsQjTF4lSbMVuLAxlS6P0Vx9pqKrdGEmpgOyjw+2XP2gEUgJrdFHcplWd2t9OAO7IH0FdWA10J+GWfscRA+R1Kt2Ozp/tHZNGHXPnZPR62eMsCmAL1UtHVv22XHovHKiXWQ=
Received: by 10.78.187.17 with SMTP id k17mr1708255huf.7.1210524803581;
        Sun, 11 May 2008 09:53:23 -0700 (PDT)
Received: by 10.78.141.1 with HTTP; Sun, 11 May 2008 09:53:23 -0700 (PDT)
In-Reply-To: <alpine.LFD.1.10.0805110948530.3330@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81793>

That is not what I meant.   I meant that since May 6th I only did one
- and those messages still showed up.  So I just ran a git-rebase
origin which removed them

On Sun, May 11, 2008 at 11:52 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>
>  On Sun, 11 May 2008, Steve French wrote:
>  >
>  > I am puzzled why I see multiple messages like:
>  >
>  > Merge branch 'master' of /.../torvalds/linux-2.6
>  >
>  > when using:
>  >
>  > git-request-pull origin
>  > git://git.kernel.org/pub/scm/linux/kernel/git/sfrench/cifs-2.6.git
>  >
>  > I only pulled once (the initial pull after your previous merge of
>  > cifs-2.6.git tree, but before I added more patches).
>
>  You definitely pulled more than once. There's four merges by you. They
>  don't happen by themselves. There's one on April 25, one on the 27th, one
>  on the 28th, and then a final one on May 6th.
>
>  Maybe you'd just forgotten that you did the three previous ones, because
>  there's a delay of a week between those and the last one.
>
>                 Linus
>



-- 
Thanks,

Steve
