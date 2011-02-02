From: Maaartin <grajcar1@seznam.cz>
Subject: Marking file as non-binary
Date: Wed, 02 Feb 2011 15:57:21 +0100
Message-ID: <iibrce$a8g$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 02 15:57:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pke9S-0008VF-5X
	for gcvg-git-2@lo.gmane.org; Wed, 02 Feb 2011 15:57:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754065Ab1BBO5j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Feb 2011 09:57:39 -0500
Received: from lo.gmane.org ([80.91.229.12]:45662 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754026Ab1BBO5i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Feb 2011 09:57:38 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Pke9E-0008Ll-ME
	for git@vger.kernel.org; Wed, 02 Feb 2011 15:57:32 +0100
Received: from 188.120.198.24 ([188.120.198.24])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 02 Feb 2011 15:57:32 +0100
Received: from grajcar1 by 188.120.198.24 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 02 Feb 2011 15:57:32 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 188.120.198.24
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.2; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165913>

For whatever reason, git claims that my foo.cpp (c++ source) is binary,
which means I see no diff when doing git log -p. I already tried putting

*.cpp diff=true text=true

in .gitattributes in maybe 20 different variations, but it doesn't help
at all. I've checked the filename for typos, etc. Today is a day when
really nothing works here.
