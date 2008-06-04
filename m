From: "Gerb Stralko" <gerb.stralko@gmail.com>
Subject: list all the untrack files in a git respo
Date: Wed, 4 Jun 2008 10:05:48 -0400
Message-ID: <75b57c110806040705mc324d9dx9ce099593ce967dd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 04 16:07:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3tdS-0004vS-KW
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 16:06:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752721AbYFDOFu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 10:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752636AbYFDOFu
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 10:05:50 -0400
Received: from rv-out-0506.google.com ([209.85.198.238]:2296 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752564AbYFDOFt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 10:05:49 -0400
Received: by rv-out-0506.google.com with SMTP id l9so128993rvb.1
        for <git@vger.kernel.org>; Wed, 04 Jun 2008 07:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=Ko2RYb+BaB+wZHh5DGg2TiO7GJKs6KI5spw6abvguv8=;
        b=rHsonzY8HaCiy7QH1IYf3gBv/uXj5K2+AC7cpMCrbMPwD6DoOublJr0jW8uoyVkKC1
         /5cV+fNck1YL4cSYa7WLUKJVNm2Gkzx6Fx9RijhC/yQlfeBDiNCRCX/GpCNphYc1F7vm
         MeGEmJqjxCI3m1oIQLnVoLQc+RDMAhxRcOTgc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=XkK3s5x737gHxOvxpliXPQQZ3SRPmXQkqQDTkpk2dNh++4dpZCg/WHPq0E/Miof+lk
         w/qcDiO+H55tq3ZRKND/lJtF51l5agrHXGlUn6edr25MWq0KXHwRrZqESB7RO4QYTtSF
         8grp/rVtN8VA8vFfi9l52EkwFmcvru0W4m7uo=
Received: by 10.140.133.9 with SMTP id g9mr6637794rvd.235.1212588348923;
        Wed, 04 Jun 2008 07:05:48 -0700 (PDT)
Received: by 10.141.50.6 with HTTP; Wed, 4 Jun 2008 07:05:48 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83781>

Is there a way to list only the untracked files in git? git status
works, but i need to do some parsing in order to get a list of
untracked files.  Something like git status --show-only-untracked?

thanks

Jerry
