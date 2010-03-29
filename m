From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v2 0/2] git-gui: git-gui: change to display the diff with the 
	HEAD in the case of conflicts.
Date: Tue, 30 Mar 2010 10:00:49 +1100
Message-ID: <2cfc40321003291600q70f0839bt8720dd025a3891f6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>, spearce@spearce.org
X-From: git-owner@vger.kernel.org Tue Mar 30 01:00:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwNx2-0005tV-He
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 01:00:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753630Ab0C2XAv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 19:00:51 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:34894 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312Ab0C2XAu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 19:00:50 -0400
Received: by pwi5 with SMTP id 5so7149816pwi.19
        for <git@vger.kernel.org>; Mon, 29 Mar 2010 16:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:received:message-id
         :subject:from:to:content-type;
        bh=QJOyjApZqe3IrVColKRVuqI+OQSdJsk0dRR35YQS390=;
        b=XBuz3I7HALfoJrp2G43Oa/RPNYLKhNfuVY7xNcWxX28MY5YmPPKxv11tejMG5H3Rlt
         SRyZuJ1SC6MlEKEOwhuAtU5B49iMgmXpaijauN7D6qOkWL5G470bgFpi/mfjCiW9Z1gW
         1iM8SiayunvdFys9GAWT2lW9fhqOEcU62FzJU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=opXsz9IsEJTjIW9WFZfvvduwcHN7j8MaA4Dewz7s1bOVxP5F3CEJIHeuxTDGHn4NLW
         fPQZZaD4IuzGcr1hAJSJSZfQfg/heTWog1mAbcRkKhCkBOQBwSxp0Wcy7jk22cCHgQla
         tcXmi2keSYWsqgQRgAwzlfC3UCqp2zEZRcAnM=
Received: by 10.114.13.5 with HTTP; Mon, 29 Mar 2010 16:00:49 -0700 (PDT)
Received: by 10.115.38.21 with SMTP id q21mr5148578waj.217.1269903649292; Mon, 
	29 Mar 2010 16:00:49 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143526>

Resending because my original patch series wasn't whitespace clean and
I have now removed the configuration to make the safe behaviour
optional - it is not safe by default.

If there is any other reason why this patch should not be considered,
please let me know.

[PATCH v2 1/2] git-gui: Introduce is_unmerged global variable to
encapsulate its derivation.
[PATCH v2 2/2] git-gui: change to display the diff with the HEAD in
the case of conflicts.

jon.
