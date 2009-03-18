From: Allan Caffee <allan.caffee@gmail.com>
Subject: [RFC] Colorization of log --graph
Date: Wed, 18 Mar 2009 06:05:12 -0400
Message-ID: <20090318100512.GA7932@linux.vnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 18 11:15:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ljsno-0001d9-TG
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 11:15:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754624AbZCRKNg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 06:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754332AbZCRKNg
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 06:13:36 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:24191 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753587AbZCRKNf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 06:13:35 -0400
Received: by yw-out-2324.google.com with SMTP id 3so459895ywj.1
        for <git@vger.kernel.org>; Wed, 18 Mar 2009 03:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mail-followup-to:mime-version:content-type
         :content-disposition:user-agent;
        bh=u7KHhviNuBC7Yw1/n6r0AsQjyJhReE2l22cj3WojGb0=;
        b=ei1F3m5Qfu5ocNNM5Uk9fzTAsECBQOra0R2I+GCO/rNz7oxtd1DZ5faodsdt27voYH
         ysq6V6htcsY/YWsamAHOF8nZHqhGoSYm6dBmhaNAbeyRSsv+2egdqT68/MtdciorN6rK
         42gMYtabLngSTOlEyHGwZN+x11aNY/4aOjYkg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-type:content-disposition:user-agent;
        b=xf/GSeF+A2XHXkBXRePDWxGNPR9YWe1zgCfPq7z44+pDW5Ru10SzbL/92cp7UWE/yf
         crwpxqZIdN2RlvrIquHiFc5PdzZBzDyFed3arerPhCkYl8om/3e/UgvZlIn8wy/OPdc9
         hBTjvTIFYBfp1vB3xI2xJQ5fX6VWHLhSfOfk0=
Received: by 10.142.69.20 with SMTP id r20mr452971wfa.188.1237370717020;
        Wed, 18 Mar 2009 03:05:17 -0700 (PDT)
Received: from linux.vnet (pool-71-185-49-127.phlapa.fios.verizon.net [71.185.49.127])
        by mx.google.com with ESMTPS id 22sm2414545wfi.1.2009.03.18.03.05.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 18 Mar 2009 03:05:16 -0700 (PDT)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113606>

I know that _some_ people arn't particularly fond of colors, but I was
wondering how difficult it would be to colorize the edges on the
--graph drawn by the log command?  It can be a little tricky trying to
follow them with a relatively complex history.  I was thinking something
like gitk already does.  Is anybody else interested in seeing this?

~Allan
