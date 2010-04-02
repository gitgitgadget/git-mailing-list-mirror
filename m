From: Raymond Auge <raymond.auge@liferay.com>
Subject: are hashes calculated from data
Date: Thu, 1 Apr 2010 22:31:17 -0400
Message-ID: <g2veaacf13c1004011931w70695d1emdceeb977397aee0d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 02 04:31:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxWfM-0000HF-Uf
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 04:31:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755354Ab0DBCbU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Apr 2010 22:31:20 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:50704 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757748Ab0DBCbT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Apr 2010 22:31:19 -0400
Received: by wwb17 with SMTP id 17so1182437wwb.19
        for <git@vger.kernel.org>; Thu, 01 Apr 2010 19:31:17 -0700 (PDT)
Received: by 10.216.1.133 with HTTP; Thu, 1 Apr 2010 19:31:17 -0700 (PDT)
Received: by 10.216.88.20 with SMTP id z20mr887362wee.222.1270175477571; Thu, 
	01 Apr 2010 19:31:17 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143773>

Hello All,

I was wondering if the hashes are calculated solely from the data or
if there is a seed taken from outside.

I ask because I'm wondering the following.

Given two separate git repositories initialized from the same
subversion repository, if the hashes are calculated from the data
alone, then those two repositories could theoretically pull/push
branches from each other while retaining  the ability to commit back
to the "origin" subversion repository.

If this is in fact the case, it would make it quite simple for me to
convince the more ambitious developers on our team to use git locally,
and grow team usage in a passive, viral way.


~ Ray
