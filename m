From: "norbert.nemec" <norbert.nemec@native-instruments.de>
Subject: filter-branch ignoring gitattributes?
Date: Fri, 03 Feb 2012 13:55:13 +0100
Message-ID: <jgglh9$mrv$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 03 13:56:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtIgq-0007Cs-5c
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 13:56:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756104Ab2BCM42 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Feb 2012 07:56:28 -0500
Received: from plane.gmane.org ([80.91.229.3]:60340 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753848Ab2BCM41 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2012 07:56:27 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RtIgg-00076D-5C
	for git@vger.kernel.org; Fri, 03 Feb 2012 13:56:22 +0100
Received: from 46.231.181.199 ([46.231.181.199])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 03 Feb 2012 13:56:22 +0100
Received: from norbert.nemec by 46.231.181.199 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 03 Feb 2012 13:56:22 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 46.231.181.199
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:10.0) Gecko/20120129 Thunderbird/10.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189757>

Hi there,

it seems that 'git filter-branch' ignores the setting in
.git/info/attributes - is that correct?

Does .gitattributes work reliably?

Specifically, I tried

	git filter-branch \
		--tree-filter 'echo "* text=auto" > .gitattributes' \
             	--tag-name-filter cat
		--prune-empty -- --all

It seems to work, but I am not sure whether I missed anything.

Greetings,
Norbert
