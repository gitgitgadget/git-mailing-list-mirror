From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: git commit --cleanup and templates
Date: Wed, 20 Jan 2010 17:37:47 +0100
Message-ID: <hj7bh9$adp$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 20 17:38:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXdZu-0005UA-3k
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 17:38:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752673Ab0ATQib (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 11:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752670Ab0ATQib
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 11:38:31 -0500
Received: from lo.gmane.org ([80.91.229.12]:53083 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752642Ab0ATQia (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 11:38:30 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NXdZW-0005LB-Qn
	for git@vger.kernel.org; Wed, 20 Jan 2010 17:38:22 +0100
Received: from 91-67-62-42-dynip.superkabel.de ([91.67.62.42])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 20 Jan 2010 17:38:22 +0100
Received: from sschuberth by 91-67-62-42-dynip.superkabel.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 20 Jan 2010 17:38:22 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 91-67-62-42-dynip.superkabel.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137558>

Hi,

when I recently for the first time used commit templates, I was 
surprised to see that git by default strips leading empty lines that I 
deliberately added to the template file when opening the template in the 
editor. I understand that I could use a different cleanup mode, but in 
fact I *want* git to clean everything, but only *after* I finished 
editing the commit message, not already when opening the editor.

Before submitting a patch, I'd like to hear what other people think 
about this, or whether I'm overseeing something.

Thanks.

-- 
Sebastian Schuberth
