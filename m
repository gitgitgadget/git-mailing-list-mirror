From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 03/14] Write to a stack log when stack is modified
Date: Tue, 17 Jun 2008 14:55:50 +0200
Message-ID: <20080617125550.GB6932@diana.vm.bytemark.co.uk>
References: <20080612052913.23549.69687.stgit@yoghurt> <20080612053424.23549.64457.stgit@yoghurt> <b0943d9e0806170324j12605a55m41b582ad09925cce@mail.gmail.com> <20080617123138.GA6932@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 14:57:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8akV-00057a-1m
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 14:57:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757708AbYFQM4N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Jun 2008 08:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756667AbYFQM4N
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 08:56:13 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1612 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757852AbYFQM4N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 08:56:13 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1K8aj0-0002fU-00; Tue, 17 Jun 2008 13:55:50 +0100
Content-Disposition: inline
In-Reply-To: <20080617123138.GA6932@diana.vm.bytemark.co.uk>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85296>

On 2008-06-17 14:31:38 +0200, Karl Hasselstr=F6m wrote:

> Have you tried looking at a patch stack log (in gitk, say)? That is,
> "stg log -g" in this patch series. It shows you diffs between
> subsequent revisions of the simplified log. I'm sure it's far from
> perfect, but I think it's actually quite useful.

Oh -- just be sure to use a colorized diff (which you get by default
in gitk, but not in git log, which is what stg log without -g ends up
calling). Without colors, a diff of two diffs is too hard to read, at
least for me.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
