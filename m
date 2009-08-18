From: tom fogal <tfogal@alumni.unh.edu>
Subject: Re: [PATCH 04/11] Add _MSC_VER predefine macro to make same behaviors with __MINGW32__ Enable MSVC build. MSVC have the save behaviors with msysgit.
Date: Mon, 17 Aug 2009 23:06:16 -0600
Message-ID: <auto-000020259481@sci.utah.edu>
References: <1250524872-5148-1-git-send-email-lznuaa@gmail.com> <1250524872-5148-2-git-send-email-lznuaa@gmail.com> <1250524872-5148-3-git-send-email-lznuaa@gmail.com> <1250524872-5148-4-git-send-email-lznuaa@gmail.com> <alpine.DEB.1.00.0908171835590.4991@intel-tinevez-2-302>  <1976ea660908171829se49abf0j5b7d45a74e4c67a7@mail.gmail.com>
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Frank Li <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 18 07:04:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdGrr-0002Gm-9m
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 07:04:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbZHRFEJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 01:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750908AbZHRFEJ
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 01:04:09 -0400
Received: from mail.sci.utah.edu ([155.98.58.79]:45618 "EHLO sci.utah.edu"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750751AbZHRFEI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 01:04:08 -0400
Received: from dummy.name; Mon, 17 Aug 2009 23:04:09 -0600
In-Reply-To: Your message of "Tue, 18 Aug 2009 09:29:39 +0800."
             <1976ea660908171829se49abf0j5b7d45a74e4c67a7@mail.gmail.com> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126345>

Frank Li <lznuaa@gmail.com> writes:
> >
> > 	Test whether WIN32 is defined rather than __MINGW32__
> 
> I think WIN32 is better, how about 64bit build case?
> In 64bit environment, VC define WIN64 not WIN32.

Actually, "_WIN32" is always defined using `cl', even in 64bit mode.
64bit compilation additionally defines "_WIN64", FWIW.

-tom
