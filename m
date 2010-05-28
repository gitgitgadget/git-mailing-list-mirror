From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] git diff: rename test that had a conflicting name
Date: Fri, 28 May 2010 12:01:36 +0200
Message-ID: <4BFF9480.7010500@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 28 12:01:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHwNr-0006i3-Ne
	for gcvg-git-2@lo.gmane.org; Fri, 28 May 2010 12:01:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758244Ab0E1KBj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 May 2010 06:01:39 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:51850 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758229Ab0E1KBi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 May 2010 06:01:38 -0400
Received: from smtp03.web.de  ( [172.20.0.65])
	by fmmailgate01.web.de (Postfix) with ESMTP id BBF5A15C71AD5;
	Fri, 28 May 2010 12:01:36 +0200 (CEST)
Received: from [80.128.58.113] (helo=[192.168.178.26])
	by smtp03.web.de with asmtp (WEB.DE 4.110 #4)
	id 1OHwNk-00048P-00; Fri, 28 May 2010 12:01:36 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/gBHh8J1fBXDjXqWOyD5ssTTohW3CHX4hxlpif
	PImuOYV65ndSwVxZCNk4n8GSWRbPINfwVVfMWrToezZGM06n7O
	Wck48QLUwof2Wdq95DMw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147924>

In 86140d5 the new test t4041-diff-submodule.sh was introduced although
t4027-diff-submodule.sh already existed. Rename the newer test to
t4041-diff-submodule-option.sh to fix that.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 ...submodule.sh => t4041-diff-submodule-option.sh} |    0
 1 files changed, 0 insertions(+), 0 deletions(-)
 rename t/{t4041-diff-submodule.sh => t4041-diff-submodule-option.sh} (100%)

diff --git a/t/t4041-diff-submodule.sh b/t/t4041-diff-submodule-option.sh
similarity index 100%
rename from t/t4041-diff-submodule.sh
rename to t/t4041-diff-submodule-option.sh
-- 
1.7.1.269.g31fb8
