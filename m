From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 0/5] Makefile: fix generation of assembler listings
Date: Wed, 6 Jan 2010 01:07:58 -0800 (PST)
Message-ID: <alpine.LFD.2.00.1001060100550.3630@localhost.localdomain>
References: <20091128112546.GA10059@progeny.tock> <20091128113709.GD10059@progeny.tock> <20100106080216.GA7298@progeny.tock>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 06 10:09:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSRtE-0004Ve-MZ
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 10:09:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755478Ab0AFJJJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2010 04:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755010Ab0AFJJJ
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 04:09:09 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54951 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753188Ab0AFJJH (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jan 2010 04:09:07 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0697w4Z018611
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 6 Jan 2010 01:07:59 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0697wWr018184;
	Wed, 6 Jan 2010 01:07:58 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <20100106080216.GA7298@progeny.tock>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.947 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136254>



On Wed, 6 Jan 2010, Jonathan Nieder wrote:
> 
> Patch 1 fixes a problem I noticed when tweaking the Makefile to
> automatically generate dependencies for the %.o targets.  The problem
> is that the dependencies for the corresponding %.s (code listing)
> targets are not included in the Makefile at all, automatically or not.

Patches 1-3 (which were the ones I was cc'd on) look sane to me. Having 
real dependencies might be prettier, but I agree that since a *.s file is 
only generated on demand (and useful mainly to see code generation), just 
forcing the build makes sense.

		Linus
