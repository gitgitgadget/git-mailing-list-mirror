From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: git pickaxe - more confusion
Date: Wed, 18 Apr 2007 11:31:14 +1200
Message-ID: <46a038f90704171631k3f8acb5aoc4337ab8a8639aaf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 18 01:31:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hdx8q-0001vT-R0
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 01:31:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752689AbXDQXbQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 19:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752784AbXDQXbQ
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 19:31:16 -0400
Received: from wx-out-0506.google.com ([66.249.82.233]:58236 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752689AbXDQXbO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 19:31:14 -0400
Received: by wx-out-0506.google.com with SMTP id h31so2227113wxd
        for <git@vger.kernel.org>; Tue, 17 Apr 2007 16:31:14 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=KUHH2D/hcaLCaOedNmZa4eZzVIVk9EuWCwVv0lrsDNo6d+3GFvuCRhlcKVIqOSyHR9p/vE5GSGhzRbkLFpV/v6AgqgiXVtmdy3+0MNJf2iF9/lZfoyBV/l20aW/1dZrtdBRkpf6jqWOX8HyxIUUZ24TBq1vJRRjMvFH2VyC8EPg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=nl9XnL360ag3wLIIpVwRko87uQFXQzbHySM7DNVy1mJmikBbCG4OjX1UI434dPoZF1zRcTeO3VqEgs4K4Vpk5pON/k6hWXzhY2173n8crQ75u7YXfdw8saQSAOBDNNGVFknOdwkVdgpHRjOgdICwQH4sW0byMMgQkEOt5B6U0Lk=
Received: by 10.90.65.11 with SMTP id n11mr1132748aga.1176852674155;
        Tue, 17 Apr 2007 16:31:14 -0700 (PDT)
Received: by 10.90.52.17 with HTTP; Tue, 17 Apr 2007 16:31:14 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44840>

Call me blunt, I cannot figure out how to use git pickaxe on a subdir.
As it's aliased to blame it really wants a file, but I have a couple
of top-level directories I want it to scan for a constant.

In short,

     git pickaxe -L '/CURLOPT_SSL/' origin/cvshead -- mnet lib/mnet

doesn't want to play with me. I initially tried with -S but the new
way of doing it is -L, it seems -- passing the regex where the line
numbers should be ;-)

cheers,



martin
