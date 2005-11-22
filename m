From: Martin Atukunda <matlads@dsmagic.com>
Subject: Git Future Proofing
Date: Tue, 22 Nov 2005 03:28:12 +0300
Message-ID: <11326192921291-git-send-email-matlads@dsmagic.com>
Reply-To: Martin Atukunda <matlads@dsmagic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue Nov 22 01:29:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeM1W-0006BT-E1
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 01:28:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbVKVA2f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 19:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964796AbVKVA2f
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 19:28:35 -0500
Received: from metronet39.infocom.co.ug ([217.113.73.39]:1540 "EHLO
	entandikwa.ds.co.ug") by vger.kernel.org with ESMTP id S964797AbVKVA2d
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 19:28:33 -0500
Received: from igloo.ds.co.ug (igloo.ds.co.ug [192.168.129.66])
	by entandikwa.ds.co.ug (Postfix) with ESMTP id 853185272
	for <git@vger.kernel.org>; Tue, 22 Nov 2005 03:30:06 +0300 (EAT)
Received: from localhost ([127.0.0.1] helo=igloo)
	by igloo.ds.co.ug with smtp (Exim 4.54)
	id 1EeM16-0006FX-NQ
	for git@vger.kernel.org; Tue, 22 Nov 2005 03:28:12 +0300
In-Reply-To: 
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12504>

This patch series adds git repository future proofing to git.

It adds checks for core.repositoryformatversion at various points in the git
architecture, and this is an overview of the patch series

Patch 1 adds GIT_REPO_VERSION and repository_format_version
Patch 2 fixes init-db's template copy so that it handles copying a config file.
Patch 3 adds support for re-reading gits env variables in certain cases
Patch 4 adds the repo format version check for various major operation
Patch 5 adds support for explictly specifying which config file to use
Patch 6 fixes up init-db config copying so as to never copy anything newer.

comments and suggestions welcome.

- Martin -
