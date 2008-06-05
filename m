From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGIT PATCH 2/5] Rename Repository.head to Repository.head_ref
Date: Thu, 5 Jun 2008 08:46:33 +0200
Message-ID: <20080605064633.GB23209@diana.vm.bytemark.co.uk>
References: <20080604210655.32531.82580.stgit@localhost.localdomain> <20080604211325.32531.84968.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 05 08:47:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K49GO-00084F-Rp
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 08:47:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752344AbYFEGqk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Jun 2008 02:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752119AbYFEGqj
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 02:46:39 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1389 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbYFEGqj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 02:46:39 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1K49F3-00065H-00; Thu, 05 Jun 2008 07:46:33 +0100
Content-Disposition: inline
In-Reply-To: <20080604211325.32531.84968.stgit@localhost.localdomain>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83865>

On 2008-06-04 22:13:25 +0100, Catalin Marinas wrote:

> This is to avoid confusion with the Stack.head function which
> returns a commit object rather than a file name.

A much better name. But you don't fix any callers -- aren't there any?

> The patch also changes the "new" function to use stack.head directly
> rather than via the Repository.refs... object.

Oh, here's a caller. But just one.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
