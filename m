From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Exploiting SHA1's  "XOR weakness" allows for faster hash calculation
Date: Wed, 05 Dec 2012 10:19:43 +0100
Message-ID: <k9n3jd$akg$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 05 10:20:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TgB9R-0005nc-4W
	for gcvg-git-2@plane.gmane.org; Wed, 05 Dec 2012 10:20:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752216Ab2LEJUF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2012 04:20:05 -0500
Received: from plane.gmane.org ([80.91.229.3]:53111 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751737Ab2LEJUD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2012 04:20:03 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TgB9D-0005WS-2O
	for git@vger.kernel.org; Wed, 05 Dec 2012 10:20:09 +0100
Received: from 192.100.123.82 ([192.100.123.82])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 Dec 2012 10:20:07 +0100
Received: from sschuberth by 192.100.123.82 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 Dec 2012 10:20:07 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 192.100.123.82
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:17.0) Gecko/17.0 Thunderbird/17.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211116>

Hi,

to say it in advance: I do not want to trigger any bogus security 
discussion here. Instead, I believe the findings from [1] allow for an 
up to 20% faster SHA1 calculation, if my brief reading of the 
presentation is correct. Any opinions on integration this optimization 
into Git?

[1] https://hashcat.net/p12/js-sha1exp_169.pdf

-- 
Sebastian Schuberth
