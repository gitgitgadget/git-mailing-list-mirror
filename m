From: Kevin Ballard <kevin@sb.org>
Subject: __git_ps1 not showing submodule dirty state
Date: Wed, 30 Dec 2009 13:46:30 -0800
Message-ID: <A98B75F4-B9BD-4CB4-9335-754C59ECB64F@sb.org>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Dec 30 22:47:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQ6OA-0005Me-QL
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 22:47:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751660AbZL3VrZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2009 16:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751551AbZL3VrY
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Dec 2009 16:47:24 -0500
Received: from hapkido.dreamhost.com ([66.33.216.122]:56211 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751086AbZL3VrY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Dec 2009 16:47:24 -0500
Received: from randymail-a3.g.dreamhost.com (caiajhbdcbbj.dreamhost.com [208.97.132.119])
	by hapkido.dreamhost.com (Postfix) with ESMTP id D1CD717A5BA
	for <git@vger.kernel.org>; Wed, 30 Dec 2009 13:47:23 -0800 (PST)
Received: from [192.168.1.12] (173-13-153-133-sfba.hfc.comcastbusiness.net [173.13.153.133])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by randymail-a3.g.dreamhost.com (Postfix) with ESMTP id DD42018577A;
	Wed, 30 Dec 2009 13:46:31 -0800 (PST)
X-Mailer: Apple Mail (2.1077)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135925>

Why does the __git_ps1 function in git-completion.bash explicitly ignore submodules when showing the GIT_PS1_SHOWDIRTYSTATE status? The most common issue with my current repository is not realizing when submodules need to be updated because I blindly trust my prompt to tell me when I have dirty state.

-Kevin Ballard