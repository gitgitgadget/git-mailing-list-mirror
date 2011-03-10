From: Julius Plenz <plenz@cis.fu-berlin.de>
Subject: Re: [PATCH] clean cached refs when calling set_git_dir()
Date: Thu, 10 Mar 2011 17:09:48 +0100
Message-ID: <20110310160948.GL15960@plenz.com>
References: <1299770345-32055-1-git-send-email-plenz@cis.fu-berlin.de>
 <AANLkTik1HMQqKc98AF-6DTGJgrk8HOjZTimGnK-XBv-q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 17:29:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pxije-0005K1-IK
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 17:29:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753488Ab1CJQ3A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2011 11:29:00 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:60944 "EHLO
	outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753475Ab1CJQ27 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Mar 2011 11:28:59 -0500
X-Greylist: delayed 1150 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Mar 2011 11:28:59 EST
Received: from relay1.zedat.fu-berlin.de ([130.133.4.67])
          by outpost1.zedat.fu-berlin.de (Exim 4.69)
          with esmtp
          (envelope-from <plenz@cis.fu-berlin.de>)
          id <1PxiQu-00065f-Vw>; Thu, 10 Mar 2011 17:09:49 +0100
Received: from oesterreich.zedat.fu-berlin.de ([130.133.10.19])
          by relay1.zedat.fu-berlin.de (Exim 4.69)
          with esmtp
          (envelope-from <plenz@cis.fu-berlin.de>)
          id <1PxiQu-0003dV-Tm>; Thu, 10 Mar 2011 17:09:48 +0100
Received: from plenz by oesterreich.zedat.fu-berlin.de with local (Exim 4.69)
	(envelope-from <plenz@cis.fu-berlin.de>)
	id 1PxiQu-0004sz-Qn; Thu, 10 Mar 2011 17:09:48 +0100
Content-Disposition: inline
In-Reply-To: <AANLkTik1HMQqKc98AF-6DTGJgrk8HOjZTimGnK-XBv-q@mail.gmail.com>
X-Editor: vim 7.1
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: 130.133.10.19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168829>

Hi!

* Nguyen Thai Ngoc Duy <pclouds@gmail.com> [2011-03-10 17:00]:
> On Thu, Mar 10, 2011 at 10:19 PM, Julius Plenz <plenz@cis.fu-berlin.de> wrote:
> > If you use libgit.a to perform reference resolutions on two or more
> > repositories that contain packed refs, cached_refs will store the packed
> > refs for the first repository to contain a packed-refs file only.
> 
> If you use libgit.a to do anything on more than one repository, you
> get a lot more messed up that just that. Spawning a new process or
> accessing with libgit2 may be safer. Why do you want to do that in the
> first place?

I was working on the cgit repository browser, where you have to peek
into several repositories to create the overview page. Since cgit
links to libgit.a I fixed the bug there. Not sure if that's the proper
way to do it, though...

Julius
