From: "Adr3nal D0S" <adr3nald0s@gmail.com>
Subject: Multiple remote.<...>.fetch and .push patterns
Date: Mon, 30 Jun 2008 13:58:49 -0500
Message-ID: <308083c30806301158i1100c84dqe7f50daad417934c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 30 20:59:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDObM-00055V-3N
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 20:59:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757000AbYF3S6v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 14:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756918AbYF3S6v
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 14:58:51 -0400
Received: from ag-out-0708.google.com ([72.14.246.247]:27778 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754716AbYF3S6u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 14:58:50 -0400
Received: by ag-out-0708.google.com with SMTP id 31so7350485agc.10
        for <git@vger.kernel.org>; Mon, 30 Jun 2008 11:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=ngVj18Bu+p5fQkfkgfwGollOdhbgnbMBZALA0PyE0A8=;
        b=s8WF98xuEWW+G8CTJhIub5II8rAlhhpORPXTxDW+KEkYKUDQyXLFjCtkcG/Ob7Qz0V
         1WRBEALlgN2VJpzjtxhbR1NyHgFjOjpo37KiHdZGB3atdAI/gGkYlCWwuJTFLxgBXKIX
         /HdT+vCzR+a2HztToFlMBvgTGDJNgUvWrWuAs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=dNpFqPNObq6fr+U9Nki2AscsdCZKYBq07qBVyUsZGKYyZg2LCITlMaong+exCfdTx2
         loaobDiDj//GeV2yf1dVxaK6tHrKboR03qiMiI9op/pseKqMzolvs5qzlgwKcdYi+K8T
         Mwtf+GASzvgpPtfxle3BkqZSh/lzdRqs1thxA=
Received: by 10.150.12.3 with SMTP id 3mr8970037ybl.18.1214852329821;
        Mon, 30 Jun 2008 11:58:49 -0700 (PDT)
Received: by 10.151.15.1 with HTTP; Mon, 30 Jun 2008 11:58:49 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86930>

How can I do something like what is shown in Everyday git using git-config?

$ cat .git/remotes/ko
URL: kernel.org:/pub/scm/git/git.git
Pull: master:refs/tags/ko-master
Pull: next:refs/tags/ko-next
Pull: maint:refs/tags/ko-maint
Push: master
Push: next
Push: +pu
Push: maint

I know I can do:

git config remote.ko.fetch refs/heads/*:refs/tags/ko-*

but that will get all KO heads.  And I have no clue about the push version.
