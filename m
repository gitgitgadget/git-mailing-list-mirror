From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [RFH] How to get git-gui.sh history
Date: Sat, 21 Apr 2007 11:04:40 +0200
Message-ID: <e5bfff550704210204p1f231076p6a68cb9d6038f4e3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamamo" <junkio@cox.net>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 21 11:04:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfBWa-0004Nk-Ep
	for gcvg-git@gmane.org; Sat, 21 Apr 2007 11:04:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbXDUJEo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Apr 2007 05:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbXDUJEo
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Apr 2007 05:04:44 -0400
Received: from nz-out-0506.google.com ([64.233.162.232]:3235 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932318AbXDUJEm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2007 05:04:42 -0400
Received: by nz-out-0506.google.com with SMTP id s1so928981nze
        for <git@vger.kernel.org>; Sat, 21 Apr 2007 02:04:41 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=FxqyAH8SeU3i7jSnl2+LNWDQDSjU4lBMC79VoZsKzy/RLnbzl6Hq7N299G7/ToGr9J1Je0jxC30fBdYbO2iDIhUHl0WUnBNIkdvnDgG309M8g0PKIaJdsUrNkUd6f+JUI+hI12soSoBNwbyoLHSYKzxHB5CMcvsxgYhLZX134q0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=p0LAsROLwnnaF6VggxkCmA2oEqmgTY9pJh9DU3o7CJ3O5Ojct+gTc9Avtl2FZ7WiJq4p8TSTSVP3rV9DhBg/xyRQ+7369f0yUcBGnEAw9wt7h4tsuts06cRC4UUg4BoSNUiaEeQkY1QVdeBBVUtVEInDm8WUeKHeOpa0NbdDHFg=
Received: by 10.114.152.17 with SMTP id z17mr57688wad.1177146280687;
        Sat, 21 Apr 2007 02:04:40 -0700 (PDT)
Received: by 10.114.61.6 with HTTP; Sat, 21 Apr 2007 02:04:40 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45154>

>From today git:

$ git rev-list --all -- git-gui/git-gui.sh | wc
      7       7     287
$ git rev-list --all --full-history -- git-gui/git-gui.sh | wc
      9       9     369


So only the merges from git://repo.or.cz/git-gui are shown.


Am I missing something? How can I get full history?


Thanks
Marco
