From: Christian Halstrick <christian.halstrick@gmail.com>
Subject: documentation of git read-tree
Date: Sat, 13 Mar 2010 23:32:43 +0100
Message-ID: <8c627c4f1003131432g26598d22m9795177ab56a463e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 13 23:33:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqZtS-0001Db-12
	for gcvg-git-2@lo.gmane.org; Sat, 13 Mar 2010 23:33:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759373Ab0CMWdJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Mar 2010 17:33:09 -0500
Received: from mail-fx0-f227.google.com ([209.85.220.227]:49497 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759356Ab0CMWdE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Mar 2010 17:33:04 -0500
Received: by fxm27 with SMTP id 27so2542950fxm.28
        for <git@vger.kernel.org>; Sat, 13 Mar 2010 14:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type;
        bh=AbH/jOJSFjDV+PySjTsGygLlp0melj2MKyjZ1pxRp8k=;
        b=R7R7w+UZ3FgtR5X7EkFN7xw2VxBvK4dR4OaNRdvgIPVlY1WiQwCvEU2P0i5Ci+/Y//
         ELj6Dm8UaiayRbbeLOuepE796iUmdjeCMpqNbu8qVz26R4TPwv2pWt8hS9sWgGGDg99K
         CeNnslsueA7RXboN+JoUiG2nxrxfDEqD3SS5s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=MxS5fwTuUUlXfP0Ofjq/LZKaztOEk5YtTJJywNk562i9I4vieA59gat0iW1pP4QAMV
         RoNFL6Fk/rEJFd57RSTnK41IfUPdmDCeleqwkJQXuh5yP2tAV2Xu521pieITj6OBmLcv
         cH5nYzM2iUvZPKimBVyWHt4iVJ1eh/E4rDv8k=
Received: by 10.239.135.131 with SMTP id d3mr625829hbd.212.1268519583136; Sat, 
	13 Mar 2010 14:33:03 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142119>

Hi,

the docu for "git read-tree" [1] talk about 21 "carry forward" rules.
In the tables describing the rules 4-21 the first column is named
"clean". But the text doesn't explain exactly what "clean" means. I
can guess, but does anybody know?

Ciao
  Chris

[1] http://www.kernel.org/pub/software/scm/git/docs/git-read-tree.html
