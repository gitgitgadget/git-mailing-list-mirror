From: Ronan Keryell <Ronan.Keryell@hpc-project.com>
Subject: Re: Index format v5
Date: Thu, 03 May 2012 11:21:22 -0700
Message-ID: <87ehr15dnh.fsf@an-dro.info.enstb.org>
References: <CALgYhfMKdbv8TiT4ALDSvD3pSXHEPLWHM09DxYnRmRdBWRjh8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 03 20:32:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQ0op-0007Gc-3Q
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 20:31:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757942Ab2ECSbz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 May 2012 14:31:55 -0400
Received: from minou.info.enstb.org ([193.50.97.146]:49881 "EHLO
	minou.info.enstb.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753863Ab2ECSby (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2012 14:31:54 -0400
X-Greylist: delayed 626 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 May 2012 14:31:53 EDT
Received: from an-dro.info.enstb.org (localhost [127.0.0.1])
	by minou.info.enstb.org (8.14.4/8.14.4/Debian-2) with ESMTP id q43ILMRp023885;
	Thu, 3 May 2012 20:21:24 +0200
In-Reply-To: <CALgYhfMKdbv8TiT4ALDSvD3pSXHEPLWHM09DxYnRmRdBWRjh8Q@mail.gmail.com>
	(Thomas Gummerer's message of "Thu, 3 May 2012 19:25:12 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196931>

>>>>> On Thu, 3 May 2012 19:25:12 +0200, Thomas Gummerer <t.gummerer@gmail.com> said:

    Thomas> I have been drafting the Version 5 of the index format over
    Thomas> the past few days with the help of Thomas Rast, Michael
    Thomas> Haggerty, cmn and barrbrain on IRC. It will save with prefix
    Thomas> compression on the path, and using a crc32 over the stat
    Thomas> data, instead of the full data, since it is only used for
    Thomas> checking if the file is changed. (Thanks Michael Haggerty
    Thomas> for this hint. Unless we are missing something this will
    Thomas> save another ~4 MB on the Webkit index.

Great!

But I wonder whether it may not worth to investigate a 64-bit version for
the offsets and so on, just in case...
-- 
  Ronan KERYELL                            |\/  Phone:  +1 408 658 9453
  Wild Systems / HPC Project               |/)
  5201 Great America Parkway, Suite 320    K    Ronan.Keryell@wild-systems.com
  Santa Clara, CA 95054                    |\   skype:keryell
  USA                                      | \  http://wild-systems.com
