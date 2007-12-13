From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit RFC] Make "stg branch -l" faster by getting all git config information in one call
Date: Thu, 13 Dec 2007 17:04:32 +0100
Message-ID: <20071213160432.GA30693@diana.vm.bytemark.co.uk>
References: <20071213133653.13925.89254.stgit@krank> <b0943d9e0712130604r6daf05d5n7afbadfe23831839@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>,
	git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 13 17:06:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2qZs-0001ZV-Kv
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 17:06:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753088AbXLMQF4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Dec 2007 11:05:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753100AbXLMQF4
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 11:05:56 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4877 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753017AbXLMQF4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 11:05:56 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1J2qY5-00085h-00; Thu, 13 Dec 2007 16:04:33 +0000
Content-Disposition: inline
In-Reply-To: <b0943d9e0712130604r6daf05d5n7afbadfe23831839@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68165>

On 2007-12-13 14:04:26 +0000, Catalin Marinas wrote:

> On 13/12/2007, David K=E5gedal <davidk@lysator.liu.se> wrote:
>
> > Maybe someone can help me find a quicker replacement for the
> > get_protected call?
>
> We can have the standard --list command which ignores the protected
> flag

Exactly what is the p flag useful for anyway?

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
