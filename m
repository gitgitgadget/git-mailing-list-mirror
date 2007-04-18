From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [PATCH 2/2] Add keyword unexpansion support to convert.c
Date: Wed, 18 Apr 2007 12:06:48 +0200
Message-ID: <87tzve9etj.fsf@morpheus.local>
References: <200704171041.46176.andyparkins@gmail.com> <Pine.LNX.4.64.0704170829500.5473@woody.linux-foundation.org> <46250175.4020300@dawes.za.net> <Pine.LNX.4.64.0704171121090.5473@woody.linux-foundation.org> <20070417235649.GE31488@curie-int.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 18 12:08:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1He756-0005qz-T2
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 12:08:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422769AbXDRKHY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 18 Apr 2007 06:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422786AbXDRKHY
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 06:07:24 -0400
Received: from main.gmane.org ([80.91.229.2]:57436 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422769AbXDRKHV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 06:07:21 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1He741-0004Z3-Me
	for git@vger.kernel.org; Wed, 18 Apr 2007 12:07:01 +0200
Received: from vtab.com ([62.20.90.195])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 18 Apr 2007 12:07:01 +0200
Received: from davidk by vtab.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 18 Apr 2007 12:07:01 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: vtab.com
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:MlPYYT0kx1lf8J+C971KVfxl7Jc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44880>

"Robin H. Johnson" <robbat2@gentoo.org> writes:

> This is perhaps a reasonable wording of my requirement.
> "Files from from the VCS should contain a stable machine-usable
> identifier that is unique for that revision of the file, without
> post-processing to insert the identifier."

But what is the "revision of the file"?  The blob ID is just a hash of
the contents, and doesn't say anything about where in the history of
the project it appears.  It will usually appear in many "project
revisions", i.e. commits.

If you want to mark the "revision" of a file, the only sensible thing
is to use the commit ID, which will give you all the problems
described in this thread.

--=20
David K=C3=A5gedal
