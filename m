From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: StGIT patch editing command
Date: Fri, 14 Sep 2007 18:57:43 +0100
Message-ID: <b0943d9e0709141057i7d03a2b6n408b820926cd95a5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "GIT list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 14 20:11:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWFQL-0006DO-6z
	for gcvg-git-2@gmane.org; Fri, 14 Sep 2007 19:57:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752958AbXINR5p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2007 13:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753328AbXINR5p
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Sep 2007 13:57:45 -0400
Received: from rv-out-0910.google.com ([209.85.198.186]:55364 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752958AbXINR5o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2007 13:57:44 -0400
Received: by rv-out-0910.google.com with SMTP id k20so744426rvb
        for <git@vger.kernel.org>; Fri, 14 Sep 2007 10:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=TtGSx4Gx8yZ3pN5ASXJUzHWPntT9IueQ38u+Ejj2frU=;
        b=A745f7SuaE7Gc87LJDXCFYvD+OkvIhlUH/oh7V2Lb0Hfo3hSgUqFEaQlL4Jt+ST5Zyq8Y33iDGhoB4fnJoUjxnPQ5n8acv0MvDRh+UX5K7BmjDIm6hgtcHowgKMf0dSVCxxGhHy21AOyGogDk1M40s3YWkz8sHFj5LCBpM4u13A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=UHQNhwT5N6ZSArX95z0ijriX0+LQKT04xpHucnK/Iu2VVskGMys30ljxHCU4fM8AwKb0XBYxNnkf3w2z92qdCxEt7T747h51Qc+fn2LkL8mWGhiwXhCJ4Uroq/N6Q/sBDdady+dtR79iX7cDqtcJuaClOYoN0qAiPVnqfD1b+FM=
Received: by 10.115.74.1 with SMTP id b1mr370412wal.1189792663856;
        Fri, 14 Sep 2007 10:57:43 -0700 (PDT)
Received: by 10.140.158.1 with HTTP; Fri, 14 Sep 2007 10:57:43 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58170>

Hi,

Since some people mentioned in the past that it would be nice to be
able to edit patches, including the diff, I added the 'edit' command
in today's snapshot (and StGIT repository).

The command moves the editing features from 'refresh' into a separate
(and improved) command. In addition, it allows one to modify the diff
directly with the '--diff' option. The command also parses the From:
and Date: fields in the patch description so that the author and date
information can be modified.

'stg help edit' displays more information.

Enjoy :-)

-- 
Catalin
