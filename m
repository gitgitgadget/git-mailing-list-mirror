From: Jon Loeliger <jdl@freescale.com>
Subject: Superproject branch tracking?
Date: Wed, 21 Jan 2009 15:22:40 -0600
Message-ID: <49779220.5000900@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 21 22:24:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPkYl-000352-Sq
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 22:24:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752767AbZAUVWv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 16:22:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752739AbZAUVWu
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 16:22:50 -0500
Received: from az33egw02.freescale.net ([192.88.158.103]:60037 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752628AbZAUVWt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 16:22:49 -0500
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id n0LLMlpm023177
	for <git@vger.kernel.org>; Wed, 21 Jan 2009 14:22:47 -0700 (MST)
Received: from [127.0.0.1] (mvp-10-214-72-156.am.freescale.net [10.214.72.156])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n0LLMhu7003464
	for <git@vger.kernel.org>; Wed, 21 Jan 2009 15:22:47 -0600 (CST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106677>

Guys,

Can someone tell me what the current best practice
to have a Git supermodule maintain a branch that is
actively tracking a similarly named branch in all of
the submodules?

That is, I want have a scenario where I would like
the master branch of a super-project to always (or on
demand) reflect the current HEAD of the master branch
in each of the submodules.

Does anyone have a script up their sleeve that I can
use as a hook in the super to notice updates to a submodule
and cause it to scurry around the sub-modules and create
a new (updated) commit in the super?

Thanks,
jdl
