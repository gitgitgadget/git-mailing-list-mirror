From: Pascal Obry <pascal@obry.net>
Subject: Finding the name of the parent branch?
Date: Fri, 30 Jan 2009 11:56:12 +0100
Message-ID: <a2633edd0901300256k2ad7530elcaca5cdc30c17534@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 30 11:57:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSr4A-0002tG-2u
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 11:57:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500AbZA3K4Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 05:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751025AbZA3K4Q
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 05:56:16 -0500
Received: from fk-out-0910.google.com ([209.85.128.187]:43949 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407AbZA3K4Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 05:56:16 -0500
Received: by fk-out-0910.google.com with SMTP id f33so398963fkf.5
        for <git@vger.kernel.org>; Fri, 30 Jan 2009 02:56:13 -0800 (PST)
Received: by 10.223.116.77 with SMTP id l13mr896328faq.106.1233312972676; Fri, 
	30 Jan 2009 02:56:12 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107790>

I want to find the name of the parent branch in a script. What is the best way?

                         o---o---o---C
                         /
                    o---o---o---B
                   /
           ---o---o---o---o---o---A

For B I want to get A and for C I want to get B.

All this can be found in gitk, but from a script I did not found a
good solution.

Any idea?

Thanks.
Pascal.

-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|              http://www.obry.net
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver wwwkeys.pgp.net --recv-key C1082595
