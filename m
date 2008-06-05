From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGIT PATCH 2/5] Rename Repository.head to Repository.head_ref
Date: Thu, 5 Jun 2008 13:58:20 +0200
Message-ID: <20080605115820.GA27430@diana.vm.bytemark.co.uk>
References: <20080604210655.32531.82580.stgit@localhost.localdomain> <20080604211325.32531.84968.stgit@localhost.localdomain> <20080605064633.GB23209@diana.vm.bytemark.co.uk> <b0943d9e0806050449s4b55d06cu1b7701a562c7a6ba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 05 13:59:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4E7r-0004hT-T3
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 13:59:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755936AbYFEL6e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Jun 2008 07:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755919AbYFEL6e
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 07:58:34 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4746 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755847AbYFEL6d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 07:58:33 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1K4E6n-0007Me-00; Thu, 05 Jun 2008 12:58:21 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0806050449s4b55d06cu1b7701a562c7a6ba@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83909>

On 2008-06-05 12:49:15 +0100, Catalin Marinas wrote:

> 2008/6/5 Karl Hasselstr=F6m <kha@treskal.com>:
>
> > A much better name. But you don't fix any callers -- aren't there a=
ny?
>
> There was actually another caller but missed it since I worked on a
> bigger initially. The stack.Repository.current_branch uses it but
> this was later moved to git.Repository.current_branch_name. I'll add
> in case we ever need to bisect.

Ah, good.

( Did you run the test suite on your patches? I always do something
  like this (untested -- I have this command in my bash history on
  another computer)

    $ stg pop -a
    $ while make test; do stg push || break; done

  before sending out patches. It takes a few minutes per patch, but
  it's fully automatic. )

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
