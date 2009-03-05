From: David Shen <davidshen84@googlemail.com>
Subject: ignored files stilll listed in git ls-files
Date: Thu, 5 Mar 2009 09:31:55 +0800
Message-ID: <53e35fd50903041731v1a3c10c9sbb9295f322a819ce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 05 02:35:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lf2Ub-0007n9-9u
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 02:35:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491AbZCEBb6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2009 20:31:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750928AbZCEBb6
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Mar 2009 20:31:58 -0500
Received: from rv-out-0506.google.com ([209.85.198.236]:20073 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750752AbZCEBb5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2009 20:31:57 -0500
Received: by rv-out-0506.google.com with SMTP id g37so3593463rvb.1
        for <git@vger.kernel.org>; Wed, 04 Mar 2009 17:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=8XBoddhtapfS407I75PbsTz7DwtbuEspP52xwQeXLFM=;
        b=B/b1snUS4hUlwTwWZ+SZhQKbgpxkbGfN/FCCiMLtbywaSH8YE3O0qAiZOsZLzfWF/V
         G81qeGxa1RYceywUPs4sRWzddmgtb3GayLTizmwB+ojHReaYCSbp43VNyFP4WlXGQNPw
         5nKD1vFndjyCAwj1HXqA0hlGkXtwPIa6bcxSk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=sENA079FdssEsIXisSb7mX4Jhrk/Ahd+ZVC11Sb9rSoOd7NSME5Q4pYGl2blsfhCvL
         v/q9d0TKOv2jReJsmlfMS2STZyli1bAbghxrxTLR2L8hUBh/9x6jjgJIrxM0FzaFoIkB
         82cLcmBy6Pe3tKvpsokk1RA7Szvoi3zByYNIs=
Received: by 10.143.28.8 with SMTP id f8mr236660wfj.202.1236216715765; Wed, 04 
	Mar 2009 17:31:55 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112253>

Hi,

I add all the files to git before I learned the .gitignore file. Then
I remove those unwanted files from the index. But those files still
appear in git ls-files. This is really annoying. Is there any want to
prevent those ignored files from git ls-files?


--
Best Regards,
David Shen
