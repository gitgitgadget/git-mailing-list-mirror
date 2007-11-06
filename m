From: Matt McCutchen <matt@mattmccutchen.net>
Subject: Re: [PATCH] git-cvsimport: Add -N option to force a new import
Date: Mon, 05 Nov 2007 22:36:10 -0500
Message-ID: <1194320170.21645.72.camel@localhost>
References: <1193268519.8008.11.camel@mattlaptop2>
	 <7vfxzz51d7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 06 04:36:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpFEw-0001O6-4e
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 04:36:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754355AbXKFDgN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 22:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754808AbXKFDgN
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 22:36:13 -0500
Received: from sd-green-bigip-83.dreamhost.com ([208.97.132.83]:48237 "EHLO
	jankymail-a4.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753648AbXKFDgM (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Nov 2007 22:36:12 -0500
Received: from [129.2.207.218] (rmccutch.student.umd.edu [129.2.207.218])
	by jankymail-a4.dreamhost.com (Postfix) with ESMTP id 248C81810D9;
	Mon,  5 Nov 2007 19:36:11 -0800 (PST)
In-Reply-To: <7vfxzz51d7.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.12.1 (2.12.1-3.matt1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63620>

On Wed, 2007-10-24 at 20:17 -0700, Junio C Hamano wrote:
> Matt McCutchen <matt@mattmccutchen.net> writes:
> 
> > I had a git repository for development of rsync and wanted to start
> > importing the upstream CVS with git-cvsimport, but git-cvsimport saw
> > that the git repository existed and insisted on updating a previous
> > import.  This patch adds an -N option to git-cvsimport to force a new
> > import and updates the documentation appropriately.
> 
> Sounds like a useful addition.  Tests?

Good call!  As I was dismayed to discover, the existing files in the
working tree confused the import, so -N as I implemented it is useless.
I ended up doing the import a different way; I'll notify the list if I
get around to implementing -N properly.

Matt
