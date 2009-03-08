From: Sam Hocevar <sam@zoy.org>
Subject: Re: [PATCH 2/2] fast-import: treat large blobs (> 100 MiB) specially, by deflating them on-the-fly from stdin instead of keeping an entire copy in memory.
Date: Sun, 8 Mar 2009 19:57:49 +0100
Message-ID: <20090308185749.GF12880@zoy.org>
References: <20090308184057.GA9606@zoy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 08 19:59:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgODZ-0008UY-EA
	for gcvg-git-2@gmane.org; Sun, 08 Mar 2009 19:59:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753675AbZCHS5x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2009 14:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753627AbZCHS5w
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Mar 2009 14:57:52 -0400
Received: from poulet.zoy.org ([80.65.228.129]:36927 "EHLO poulet.zoy.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753356AbZCHS5w (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2009 14:57:52 -0400
Received: by poulet.zoy.org (Postfix, from userid 1000)
	id DBEAE1203EB; Sun,  8 Mar 2009 19:57:49 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090308184057.GA9606@zoy.org>
Mail-Copies-To: never
X-No-CC: I read mailing-lists; do not CC me on replies.
X-Snort: uid=0(root) gid=0(root)
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112632>

On Sun, Mar 08, 2009, Sam Hocevar wrote:
> +	int orig_bytes)

   Self-comment: this variable should be size_t everywhere.

-- 
Sam.
