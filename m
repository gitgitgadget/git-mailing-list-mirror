From: Sylvain Rabot <sylvain@abstraction.fr>
Subject: [PATCH] git-mergetool--lib.sh: fix mergetool.<tool>.* configurations ignored for known tools
Date: Sat,  5 Jun 2010 04:31:51 +0200
Message-ID: <1275705112-8088-1-git-send-email-sylvain@abstraction.fr>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jun 05 04:32:34 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKjBY-000714-4A
	for gcvg-git-2@lo.gmane.org; Sat, 05 Jun 2010 04:32:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754701Ab0FECcF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jun 2010 22:32:05 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:48064 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752394Ab0FECcD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jun 2010 22:32:03 -0400
Received: by wwb28 with SMTP id 28so1315338wwb.19
        for <git@vger.kernel.org>; Fri, 04 Jun 2010 19:32:01 -0700 (PDT)
Received: by 10.227.69.204 with SMTP id a12mr5804691wbj.153.1275705120744;
        Fri, 04 Jun 2010 19:32:00 -0700 (PDT)
Received: from localhost.localdomain (smj33-1-82-233-66-33.fbx.proxad.net [82.233.66.33])
        by mx.google.com with ESMTPS id r35sm15067917wbv.17.2010.06.04.19.31.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 04 Jun 2010 19:31:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148450>

Hi,

Here a patch I made after Junio's remarks in this thread :
http://thread.gmane.org/gmane.comp.version-control.git/148267

I think git-mergetool--lib.sh needs some refactoring. I'm no sh expert,
far from it, but I know a bit about scripting (I have been developing in PHP
for more than 6 years now :P) and I had quite some difficulties to understand
the behavior of some functions. For example, get_merge_tool_path returns the
name of the tool if no mergetool.<tool>.path have been set, which, from my
point of view, makes no sense.

I know there is maybe no time or no need to rewrite something which works
rather well but the +5 hours I spent to write this poor patch make me 
wonder if I am overrating myself. So if someone could just agree with me   
that would be a huge step to help me to regain some self respect :)

Cheers.
