From: Matti Kaasinen <matti.kaasinen@kolumbus.fi>
Subject: Re: Is there any hope (format-patch)??
Date: Sat, 02 Aug 2008 14:04:17 +0300
Message-ID: <48943F31.8080707@kolumbus.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 02 13:15:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPF4r-0000TF-Qc
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 13:15:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752489AbYHBLOA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2008 07:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752488AbYHBLOA
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Aug 2008 07:14:00 -0400
Received: from gw01.mail.saunalahti.fi ([195.197.172.115]:39237 "EHLO
	gw01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752475AbYHBLOA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2008 07:14:00 -0400
X-Greylist: delayed 577 seconds by postgrey-1.27 at vger.kernel.org; Sat, 02 Aug 2008 07:14:00 EDT
Received: from [10.0.0.3] (a88-112-47-140.elisa-laajakaista.fi [88.112.47.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by gw01.mail.saunalahti.fi (Postfix) with ESMTP id 84B7E1517FE
	for <git@vger.kernel.org>; Sat,  2 Aug 2008 14:04:19 +0300 (EEST)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91140>

Thanks Daniel,
some comments
> ------------------------------------------------------------------------
> On Fri, 1 Aug 2008, Matti Kaasinen wrote:
>
> >/ Hi!/
> >/ /
> >/ Is there any hope with following procedure:/
> >/ I took reporitory from linux git:/
> >/ # git clone/
> >/ git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/
> >/ /
> >/ For getting patches to make recent version from v2.6.26-rc3 I executed:/
> >/ # git format-patch -o patchdir v2.6.26-rc3..origin/
>
> format-patch isn't going to work too well with non-linear history. When 
> two people make nearby or overlapping changes which get merged later, and 
> this gets turned into a linear sequence of changes, there's no 
> possible patch that will accurately reflect the change which got ordered 
> second.
>
> >/ Then I checked out v2.6.26-rc3 to a new branch and patched it with/
> >/ at91patch/maxim.org.za that was produced against v2.6.26-rc3. That worked out/
> >/ without complaints./
>
> It sounds like you really just want to do "merge origin" now, and skip the 
> whole patch series thing.
>   
Ok, I'll try how it works, when I get back to my desk. Well, I'm running 
out of time and possibly I need to stay in the current version.
> You'll probably get some conflicts (or applying the patch directly to 
> origin would have worked),
There came quite a lot of complaints from patching directly the origin. 
Strange that some were complaints of trying to re-create files. So, I 
just wonder if that patching really is needed. I suppose I should try to 
ask that from maxim.org.za
>  but they should be relatively easy to resolve.
>   
Well, hope so - direct patching to origin gave quite lot of complaints.
-Matti
