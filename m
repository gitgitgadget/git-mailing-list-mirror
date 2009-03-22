From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH 0/8] user-manual: style improvements
Date: Sun, 22 Mar 2009 20:05:13 +0200
Message-ID: <1237745121-6325-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 22 19:07:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlS4g-0000c8-LN
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 19:07:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755206AbZCVSFe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 14:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755205AbZCVSFe
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 14:05:34 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:40481 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755059AbZCVSFe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 14:05:34 -0400
Received: by bwz17 with SMTP id 17so1470067bwz.37
        for <git@vger.kernel.org>; Sun, 22 Mar 2009 11:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=swrtRcTZmuKuv3f7k+piNNy96O8U3Kw8+CvQ4gXgOHM=;
        b=Swp7QszdkgGE+9zHnw1q1ACPQ23xqAZ2uKIJrYMqWaIsFyvhKKA6hEvEhvniiCtDoj
         vKC8MIc4jT6pBPszXCCrm7h0kc42shC/1N8613AQLwEl6L+WHofDZ5zOnjzZ7jmEzWch
         zNjO0Fwof5Q8OBLcnnYkGRik2KhHck2TcC7E8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=vAj0H/rb0Vv+B438VYJUMvsjv8Xr+ySA0DdbD50EzfvmEIOCZPH6zkVzZkkT/RCpOt
         zX45T3habzpPeurRpWBmCgFqodeipKNcfOcjdGrkCsvbeA8YfUhRdPH6AGqCUaLEoUgd
         /sJLUf9REmkcFPEROlf9zROLjRhN8u8LhCPHs=
Received: by 10.223.109.198 with SMTP id k6mr5257768fap.46.1237745130829;
        Sun, 22 Mar 2009 11:05:30 -0700 (PDT)
Received: from localhost (a91-153-251-222.elisa-laajakaista.fi [91.153.251.222])
        by mx.google.com with ESMTPS id c28sm7441800fka.6.2009.03.22.11.05.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 22 Mar 2009 11:05:30 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.352.gae594
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114156>

This patch series tries to improve the style of the user-manual.

For a quick preview check:
http://people.freedesktop.org/~felipec/git/user-manual.html

Some changes are non-controversial, like s/git-foo/git foo/ while the font
style changes might be.

There's one huge patch for quoting improvements, which requires the css style
patch in order to look good. It probably needs to be split, but for now this is RFC.

Felipe Contreras (8):
  user-manual: remove some git-foo usage
  docbook: improve css style
  docbook: radical style change
  user-manual: general quoting improvements
  user-manual: use 'fast-forward' instead of 'fast forward'
  user-manual: use SHA-1 instead of SHA1 or sha1
  user-manual: add global config section
  user-manual: simplify the user configuration

 Documentation/docbook-xsl.css |   17 +-
 Documentation/user-manual.txt | 1038 +++++++++++++++++++++--------------------
 2 files changed, 549 insertions(+), 506 deletions(-)
