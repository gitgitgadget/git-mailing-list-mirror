From: "Sean Kelley" <svk.sweng@gmail.com>
Subject: git-apply versus git-am
Date: Mon, 23 Jul 2007 02:54:31 -0500
Message-ID: <a2e879e50707230054m60d45293ua1d57887367914c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 23 09:54:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICskY-0001Xd-FU
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 09:54:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754398AbXGWHye (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 03:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754277AbXGWHye
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 03:54:34 -0400
Received: from wx-out-0506.google.com ([66.249.82.227]:49713 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753556AbXGWHyd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 03:54:33 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1414952wxd
        for <git@vger.kernel.org>; Mon, 23 Jul 2007 00:54:31 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=GWyUH3OT/4XcR7q6KAGKTFmK0V+ehBj5gDwDDsNlQQ0fD2B2RIkIEql/4vX/wvOvEj2J/jWAvzXCXuw6pH5SUuyDFNEMgU6u9Xp6XfcHfFKY8q0ujorTkRhyAug+TjSggkAv8pna6eZMW36i2qB/vAS9sOSeZOcgJnHDI0Gl/m8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=CUSItCSUiuK8QnL55kMmJs/3OfehpkozBO7pRyTnJgvt+7CJYEt/WkXf/z63ZQS9PaKpSfMFkE3IVP3AVZ5nLfcp+VmuOZBtuPzlUXZ6oRJgRx/IclV5SDF6KiEI1KrsWkyzidFSwRwqYqLZS5a1ThyNvwEeGnbnsn62EoD8B+Q=
Received: by 10.90.118.8 with SMTP id q8mr1539058agc.1185177271673;
        Mon, 23 Jul 2007 00:54:31 -0700 (PDT)
Received: by 10.90.113.3 with HTTP; Mon, 23 Jul 2007 00:54:31 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53407>

Why doesn't git-apply include an option for a signoff line like git-am?

git-applymbox /tmp/mbox ~/.signoff

Or am I missing something?  (most likely the case!)

Sean
