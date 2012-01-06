From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] Submodules always use a relative path to gitdir
Date: Fri, 6 Jan 2012 22:07:09 +0700
Message-ID: <CACsJy8Agw6aTu=odeJXEbYuWQnE228w24_baP8u2eiX2-BEpeA@mail.gmail.com>
References: <1325192426-10103-1-git-send-email-antony.male@gmail.com>
 <7vsjk3vw67.fsf@alter.siamese.dyndns.org> <4F007492.8010909@web.de>
 <7vsjjwvdyl.fsf@alter.siamese.dyndns.org> <4F037CBF.9010005@web.de>
 <7vhb0csa6w.fsf@alter.siamese.dyndns.org> <4F0629C6.9010908@web.de>
 <7vlipllmfh.fsf@alter.siamese.dyndns.org> <CABURp0rFOFfX7eu-v6ZK07iTfXwhOne60d70GkCdOvx0k8BZkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Antony Male <antony.male@gmail.com>, git@vger.kernel.org,
	iveqy@iveqy.com
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 06 16:07:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjBOW-0005GA-67
	for gcvg-git-2@lo.gmane.org; Fri, 06 Jan 2012 16:07:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030355Ab2AFPHm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jan 2012 10:07:42 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:39641 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030329Ab2AFPHl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jan 2012 10:07:41 -0500
Received: by eaad14 with SMTP id d14so1011826eaa.19
        for <git@vger.kernel.org>; Fri, 06 Jan 2012 07:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=lkgQ3Oq+9pyeppdsH5Z52j0rj8X5VA2jDuIXZayDbRs=;
        b=pWSiCU5A6cBDFDhFgcIpV/KRbAex8vkPQj6oOBujNIimx40dXJD/XrcAMaiNszoHxH
         AsjdAe9IElAVoBwkyngi2jXxHmXPF4zHLqNdkiaW1lA7uQFeR7TPc6Ka5k7FR1toXgp9
         CMT+pERLvLphR9jUbJ7YmdR17VGwNfaQHVQqw=
Received: by 10.204.9.218 with SMTP id m26mr2691299bkm.44.1325862460186; Fri,
 06 Jan 2012 07:07:40 -0800 (PST)
Received: by 10.204.32.197 with HTTP; Fri, 6 Jan 2012 07:07:09 -0800 (PST)
In-Reply-To: <CABURp0rFOFfX7eu-v6ZK07iTfXwhOne60d70GkCdOvx0k8BZkQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188032>

On Fri, Jan 6, 2012 at 9:26 PM, Phil Hord <phil.hord@gmail.com> wrote:
> Do you see any _problem_ with making core.worktree a relative
> directory in the specific case of git submodules?

Not a problem per se, but you should look at the comment at the top of
t1510 to see where it is relative to. Two interesting rules:

2. .git file is relative to parent directory. .git file is basically
   symlink in disguise. The directory where .git file points to will
   become new git_dir.

3. core.worktree is relative to git_dir.
-- 
Duy
