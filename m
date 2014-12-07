From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH/RFC v2] Squashed changes for multiple worktrees vs.
 submodules
Date: Sun, 7 Dec 2014 11:15:03 +0200
Message-ID: <20141207091503.GC9128@wheezy.local>
References: <1417390076-2953-1-git-send-email-max@max630.net>
 <547E24E4.7050100@web.de>
 <20141202221611.GB9128@wheezy.local>
 <5480BEB9.8070109@web.de>
 <CAF7_NFQzPDF+7NS2VwopK8Oei=9NzWEAGM5fko-St5KvvmLa9A@mail.gmail.com>
 <5482FF40.3040204@web.de>
 <20141207064230.GA9782@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sun Dec 07 10:15:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XxXvu-0003Q5-Ms
	for gcvg-git-2@plane.gmane.org; Sun, 07 Dec 2014 10:15:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752845AbaLGJPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Dec 2014 04:15:08 -0500
Received: from p3plsmtpa09-06.prod.phx3.secureserver.net ([173.201.193.235]:52213
	"EHLO p3plsmtpa09-06.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751757AbaLGJPF (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Dec 2014 04:15:05 -0500
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa09-06.prod.phx3.secureserver.net with 
	id QZEz1p0085B68XE01ZF29z; Sun, 07 Dec 2014 02:15:03 -0700
Content-Disposition: inline
In-Reply-To: <20141207064230.GA9782@wheezy.local>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260976>

On Sun, Dec 07, 2014 at 08:42:30AM +0200, Max Kirillov wrote:
>> *) I'd love to see a solution for sharing the object database
>>    between otherwise unrelated clones of the same project (so
>>    that fetching in one clone updates the objects in the common
>>    dir and gc cannot throw anything away used by one of the
>>    clones). But I'd expect a bare repository as the common one
>>    where we put the worktrees refs into their own namespaces.

> There is a GIT_NAMESPACE already, maybe it should be just
> extended to work with all commands?

No, this will not work for submodules, has same issues with
the same config.
