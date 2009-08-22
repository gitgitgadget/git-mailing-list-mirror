From: Ping Yin <pkufranky@gmail.com>
Subject: How to recover from "reset --hard"
Date: Sat, 22 Aug 2009 10:53:23 +0800
Message-ID: <46dff0320908211953u2f63cdb4m9cab863266a03df7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 22 04:53:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MegjV-0008HZ-VD
	for gcvg-git-2@lo.gmane.org; Sat, 22 Aug 2009 04:53:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933192AbZHVCxW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 22:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933184AbZHVCxW
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 22:53:22 -0400
Received: from mail-yw0-f173.google.com ([209.85.211.173]:56505 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933183AbZHVCxW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 22:53:22 -0400
Received: by ywh3 with SMTP id 3so1618475ywh.22
        for <git@vger.kernel.org>; Fri, 21 Aug 2009 19:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=hezjrowiRvknQjiJAEtQfpQdy+GE35d64is4pWHy3rQ=;
        b=yAGdMdl5kjVNfcF1Pb3zlSHQgL0BH7aTw/GGM8ZUoGOq259MTUXGX4cCxgmd65dq5U
         S0xae3vxYJPcttITTXGxFcrwZQIcvL0hJTcladWmVOCXd4qvNZAcYSOfiBXyU/rJACHB
         OX04SFCCGHENl4pwGCKoqhw5piqWg9+BMDxyg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=w/Q2qGe6bsbzUeNov5LHhQ+q8KwicOPtjMylyI9Puhy6FSYhFBLIbV6qt85EheQ3nt
         QcJJp5teQDHEa1VoHn3Nd1xgsxYdvk+L3F+hHI/U9z96tDwJVo1UfWqzG4+Sj6f0qGeR
         wdI2+U0HCL+IvkbCN5rMyF9SjRXP5K/VWJoGg=
Received: by 10.90.10.1 with SMTP id 1mr1511346agj.62.1250909603512; Fri, 21 
	Aug 2009 19:53:23 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126779>

After adding a file to index, i do a "reset --hard", then how do i
recovery the file?

I want write all lost files to a directory and find it according to
the file size.

Does "git fsck --lost-found" write this file to .git\lost-found\other ?

Ping Yin
