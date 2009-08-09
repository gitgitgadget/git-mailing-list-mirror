From: Jerome Baum <jerome@jeromebaum.com>
Subject: Hash algorithm choice
Date: Sun, 9 Aug 2009 18:17:01 +0200
Message-ID: <f448a46a0908090917s102b4c83pbad6f298a8e127cc@mail.gmail.com>
References: <f448a46a0908090907v68542e4dw1f1c4f610cb46ca2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 09 18:17:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaB5W-0004E7-Jf
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 18:17:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751744AbZHIQRV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Aug 2009 12:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751706AbZHIQRV
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 12:17:21 -0400
Received: from mail-gx0-f213.google.com ([209.85.217.213]:50422 "EHLO
	mail-gx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751552AbZHIQRV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Aug 2009 12:17:21 -0400
Received: by gxk9 with SMTP id 9so3524325gxk.13
        for <git@vger.kernel.org>; Sun, 09 Aug 2009 09:17:21 -0700 (PDT)
Received: by 10.150.225.14 with SMTP id x14mr6523845ybg.44.1249834641219; Sun, 
	09 Aug 2009 09:17:21 -0700 (PDT)
In-Reply-To: <f448a46a0908090907v68542e4dw1f1c4f610cb46ca2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125351>

Hi all,


I just had an idea regarding git and hashing. Couldn't find any
previous discussion on the subject so here's what I'm thinking of:

How difficult would it be to allow users to choose a hash function
during git-init which is then globally used in the repo? Are there
many changes needed or are changes in git-hash-object and git-init
sufficient?

I'm not trying to undermine the decision to use SHA-1 or anything, but
I would guess it builds for the future and adds flexibility to the
system. So when SHA-1 is no longer sufficient, it would be easy to
switch to RIPEMD-160 with a simple "git-init --hash=3Dripemd160"

Would be happy for any comments on this.


Regards,


Jerome Baum
Hugo-Junkers-Str. 2
D-37083 G=F6ttingen
Germany
Tel.: +49 551 2008782
Web: www.JeromeBaum.com
