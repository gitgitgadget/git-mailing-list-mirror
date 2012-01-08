From: Dave Abrahams <dave@boostpro.com>
Subject: [bug] submodule --update insufficiently verbose
Date: Sat, 07 Jan 2012 21:33:00 -0500
Message-ID: <m239bqnctf.fsf@pluto.luannocracy.com>
Mime-Version: 1.0
Content-Type: text/plain
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 08 03:33:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjiZP-0008R8-MZ
	for gcvg-git-2@lo.gmane.org; Sun, 08 Jan 2012 03:33:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752718Ab2AHCdG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jan 2012 21:33:06 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:47950 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751779Ab2AHCdF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jan 2012 21:33:05 -0500
Received: by qats34 with SMTP id s34so377503qat.19
        for <git@vger.kernel.org>; Sat, 07 Jan 2012 18:33:03 -0800 (PST)
Received: by 10.224.33.65 with SMTP id g1mr13573295qad.98.1325989983377;
        Sat, 07 Jan 2012 18:33:03 -0800 (PST)
Received: from pluto.local (207-172-223-249.c3-0.smr-ubr3.sbo-smr.ma.static.cable.rcn.com. [207.172.223.249])
        by mx.google.com with ESMTPS id df3sm133019219qab.6.2012.01.07.18.33.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 07 Jan 2012 18:33:01 -0800 (PST)
Received: by pluto.local (Postfix, from userid 501)
	id 9FEAE1E0B47F; Sat,  7 Jan 2012 21:33:00 -0500 (EST)
User-Agent: Gnus/5.110018 (No Gnus v0.18) Emacs/24.0.92 (darwin)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188089>


When a "git submodule --update" fails, e.g., due to a dirty working
directory in one of the submodules, nothing is printed out indicating
the submodule or directory in which the failure occurred.  This seems
like a usability bug to me.

Thanks,

-- 
Dave Abrahams
BoostPro Computing
http://www.boostpro.com
