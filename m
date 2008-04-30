From: "Sitaram Chamarty" <sitaramc@gmail.com>
Subject: difference between "git reset --hard" and "git checkout -f"
Date: Wed, 30 Apr 2008 17:07:40 +0530
Message-ID: <2e24e5b90804300437t39ac16a6ga3cbe0b91d7e5565@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 13:38:33 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrAds-00040f-Lg
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 13:38:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757759AbYD3Lhn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 07:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756690AbYD3Lhn
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 07:37:43 -0400
Received: from ti-out-0910.google.com ([209.85.142.187]:20290 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754621AbYD3Lhm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 07:37:42 -0400
Received: by ti-out-0910.google.com with SMTP id b6so48840tic.23
        for <git@vger.kernel.org>; Wed, 30 Apr 2008 04:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=77nviySRQQQzou3bnEDTlY7UWFHDuyiNInF8rUEhzFE=;
        b=pRmckNLg8xRMcFfkByCrxA747kv8SeVO5AAecsMc9zsPaIEvltbc6KtBjt/F+4fvTEWWbla+qHiFbEZgGNQY2wEQXqPGXqW/xSv9vtDJvoEByCtjjfPHRSo/VseXpK99Edq+jY458+KHvebJXMpRtDAGCgcf/YC5QSRHf3WTN2Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=BPNeeA2kr2Bli1AyJgeer+QUux56MChTi3n9MZYyDgzF6InyUl73SSLf8WjQklKkyFaySY6/aM0XWq1pjEhlJd2kqxpCusvME4xDWBN/V/+94mSynOlOxc5AlI3ywvtyF+Dc5w79hcukw7KMtGAgUOHvEd5UfLx6ijdezAgzdmY=
Received: by 10.110.5.14 with SMTP id 14mr73756tie.10.1209555460986;
        Wed, 30 Apr 2008 04:37:40 -0700 (PDT)
Received: by 10.110.52.10 with HTTP; Wed, 30 Apr 2008 04:37:40 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80827>

I have two questions:

(1) as in the subject line, what's the difference between these two
commands?  (I'm talking about those exact commands, not variations).
I am unable to see any.

(2) shouldn't one of these have an option to throw away untracked
files also, to get to a pristine HEAD-eqvt state?  Or is it better to
force user to use git clean separately for that?

Thanks,

Sitaram
