From: "Jukka Zitting" <jukka.zitting@gmail.com>
Subject: Re: git-svn: Trouble after project has moved in svn
Date: Fri, 18 Jul 2008 21:27:48 +0300
Message-ID: <510143ac0807181127y62b16ef1jf62e00bfc6c854ea@mail.gmail.com>
References: <510143ac0807161512w44a612bcndc53713639b0b70a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 18 20:28:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJuhF-0000vX-Pn
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 20:28:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755222AbYGRS1u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 14:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755211AbYGRS1u
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 14:27:50 -0400
Received: from wr-out-0506.google.com ([64.233.184.234]:23307 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755206AbYGRS1t (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 14:27:49 -0400
Received: by wr-out-0506.google.com with SMTP id 69so297170wri.5
        for <git@vger.kernel.org>; Fri, 18 Jul 2008 11:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=EERbZkj3qaKnF7ux3NeV8jRF01MK7Qjk5zR95lFuVkA=;
        b=IVT2Iois3HoFUAc6QTjf9Y5gPFMcmGhgnZBStTwyqUN6TdfzsSe7sl73PCgtEzpf/7
         3Pap5DDVNmEohTWDo8k9Ji3QU4mAB97i0clAAEJk9/lvl079+fysCgD8S0Se5Wzf9w6O
         L8Xb86XjwQtiwFlZU74ZXC9L2Q1MYwZmTAAEc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=eRvLARscVXpMHtoFw4yFkCHfHBbnuhfVKaNUqJ52wqGw3d8G7E/bvYhngBEKpOZeIx
         66MWxHtDZQhTKp3bN6GLTLtKoN1jJB/FbIEkRiWyQuGA2o15kFQRsC62JdQlWHJJtIPK
         7wzD/7RqzIMyAfMx4stOttzYgKdhHrb/4iIFQ=
Received: by 10.90.29.13 with SMTP id c13mr481798agc.114.1216405668729;
        Fri, 18 Jul 2008 11:27:48 -0700 (PDT)
Received: by 10.90.115.13 with HTTP; Fri, 18 Jul 2008 11:27:48 -0700 (PDT)
In-Reply-To: <510143ac0807161512w44a612bcndc53713639b0b70a@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89069>

Hi,

On Thu, Jul 17, 2008 at 1:12 AM, Jukka Zitting <jukka.zitting@gmail.com> wrote:
> Somewhat related to the recent thread about Apache Synapse, I'm having
> trouble making a git-svn clone of a project that has been moved around
> in a Subversion repository.

Ah, silly me, my test script was broken. Thanks to Michael J. Gruber
for pointing out that I should have used created the tags using svn
URLs instead of working copy path or at least done an "svn update"
before tagging. After fixing my test script the git-svn result was
exactly as I was hoping to see.

I think that covers my last barrier for creating experimental git
mirrors of various Apache codebases. Check out
http://mail-archives.apache.org/mod_mbox/www-infrastructure-dev/ for
more on git experiments at Apache.

BR,

Jukka Zitting
