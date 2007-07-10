From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: [WIP] Get rid of msys in favor of busybox port for windows
Date: Tue, 10 Jul 2007 11:32:00 -0400
Message-ID: <fcaeb9bf0707100832j3c2ff076gab5c9bd4f9d3f4a0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 10 17:32:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8HhA-0003Sz-7g
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 17:32:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754655AbXGJPcE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 11:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754543AbXGJPcD
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 11:32:03 -0400
Received: from an-out-0708.google.com ([209.85.132.251]:6025 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753915AbXGJPcB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 11:32:01 -0400
Received: by an-out-0708.google.com with SMTP id d31so269149and
        for <git@vger.kernel.org>; Tue, 10 Jul 2007 08:32:01 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=QhgMYtokZHo0wy2tc7V6fNnmtojjwfuZgsuBGr3pXy9VSXx49CB9KjsapCOBc3czpM6x5uEk5rKnfbeAXlAU6K/cdFFxQFXXTo6b2/NQG7CgHMKv7WnWs9cRSSZbjTnN+tZWgQvByq3zPtwZuWrA4i3nHspMjWzvwP/YjNq4ZZA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=RSaaXkJxYsFz/Ju7AG4khyURLxpydggpmMlngT2aO7p8fsiI13hbV+K6ot+837uI88O/nEJR9cpmBYaTZC/sPcE3CvpBUpFTonhksyhwWBO/JgrX7L2jq1WhmCXdEFTh8UYqmkGvFuWBaxNgEcID11U6hT90NWAyY4Df8MCiPXI=
Received: by 10.100.10.20 with SMTP id 20mr2249490anj.1184081520914;
        Tue, 10 Jul 2007 08:32:00 -0700 (PDT)
Received: by 10.100.198.17 with HTTP; Tue, 10 Jul 2007 08:32:00 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52085>

Hi,

I'm integrating some code from busybox to mingw tree so that mingw
port can work without msys. Posix utilities such as sed, awk, head,
tail... seem to work well. The main obstacle is ash, which is no where
near usable state (fork issues as always). Busybox ash is about 13000
lines of code, not too big.

Anyone interested in?
-- 
Duy
