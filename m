From: Ed Avis <eda@waniasset.com>
Subject: Re: git log --raw abbreviates SHA1s, despite what manual says
Date: Fri, 15 May 2015 15:33:27 +0000 (UTC)
Message-ID: <loom.20150515T173020-388@post.gmane.org>
References: <loom.20150515T164345-901@post.gmane.org> <vpqfv6xc1zd.fsf@anie.imag.fr> <loom.20150515T171548-204@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 15 17:33:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YtHcN-0007PE-0T
	for gcvg-git-2@plane.gmane.org; Fri, 15 May 2015 17:33:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934694AbbEOPdi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2015 11:33:38 -0400
Received: from plane.gmane.org ([80.91.229.3]:39485 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934665AbbEOPdh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2015 11:33:37 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1YtHcF-0007MS-DD
	for git@vger.kernel.org; Fri, 15 May 2015 17:33:35 +0200
Received: from 80.169.169.174 ([80.169.169.174])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 15 May 2015 17:33:35 +0200
Received: from eda by 80.169.169.174 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 15 May 2015 17:33:35 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 80.169.169.174 (Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:38.0) Gecko/20100101 Firefox/38.0 Cyberfox/38.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269152>

Ah, I see that --raw not only specifies the raw format should be used for
diffs, but also enables printing diffs even if they wouldn't be otherwise.

Note that --format=raw still prints abbreviated SHA-1s in the diff:

    % git log --format=raw --raw
    ...
    :100644 100644 c30ec14... b87bb8b... M  myfilename

Possibly --format=raw should imply --no-abbrev?

-- 
Ed Avis <eda@waniasset.com>
