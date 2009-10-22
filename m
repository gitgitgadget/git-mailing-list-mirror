From: Eugene Sajine <euguess@gmail.com>
Subject: git describe is failing
Date: Thu, 22 Oct 2009 10:47:10 -0400
Message-ID: <76c5b8580910220747w709d2b41s4f7b121e421e843c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eugene Sajine <euguess@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 22 16:49:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0ywu-0007k6-T6
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 16:47:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755999AbZJVOrI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 10:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756177AbZJVOrH
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 10:47:07 -0400
Received: from mail-gx0-f216.google.com ([209.85.217.216]:49624 "EHLO
	mail-gx0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754258AbZJVOrG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 10:47:06 -0400
Received: by gxk8 with SMTP id 8so8887019gxk.1
        for <git@vger.kernel.org>; Thu, 22 Oct 2009 07:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type;
        bh=1xLbVLsFYx1iz4WkJPpPZlXCQzPriVx5P20s4XCDZlo=;
        b=laFoBL3HEN7fqW27oBT1RT8I6LCCU+18RMGFwnJToTc6fhT5MlHWClBeVS+9Ou8GIW
         pZBnGuNjFnWKWrVrIb5eHIl4+cIxqFXQGZXxfWaBToBeiWwJTOrIJpIzLnhd6/s45/VU
         Sw6319lM0ruGywegiTZeICjoTVIH8QY1NEfck=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=D0OdUBMP3ELLrh6no0rrmBk1M/S3P4Vtg8GTz+Ibg1TzO6n1e599C8V46lACdH5+KQ
         F9PcvvJjg3TozKaF5X/MExV91xC0/2s6DnoG8TEFeS1KrVm7rEGrnq1SdoWqLD9yBbLS
         XJl2nCS2snr9reNSHXgNFAi7S7T5saKnjmtd8=
Received: by 10.90.166.2 with SMTP id o2mr11294992age.93.1256222830698; Thu, 
	22 Oct 2009 07:47:10 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131022>

Hi,

I have a test repo which I'm playing with. It has about 15 commits and
one branch only (master) and couple of tags. Somehow it got to a state
when

$ git describe

gives:

fatal: cannot describe 'SHA-1'

The command is working ok with my other repo. It doesn't seem that the
test repo is corrupted. I can commit, push and pull, see the history
with gitk... How can I check or repair it?

Thanks,
Eugene
