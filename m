From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit RFC] Make "stg branch -l" faster by getting all git config information in one call
Date: Thu, 13 Dec 2007 17:08:53 +0100
Message-ID: <20071213160853.GB30693@diana.vm.bytemark.co.uk>
References: <20071213133653.13925.89254.stgit@krank> <b0943d9e0712130604r6daf05d5n7afbadfe23831839@mail.gmail.com> <87lk7yr7ib.fsf@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Thu Dec 13 17:09:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2qck-0002zR-T0
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 17:09:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754706AbXLMQI6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Dec 2007 11:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755010AbXLMQI6
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 11:08:58 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4836 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753218AbXLMQI6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 11:08:58 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1J2qcH-00087N-00; Thu, 13 Dec 2007 16:08:53 +0000
Content-Disposition: inline
In-Reply-To: <87lk7yr7ib.fsf@lysator.liu.se>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68167>

On 2007-12-13 15:31:24 +0100, David K=E5gedal wrote:

> Hey, why not put the "protected" flag in the config? Then we can get
> it the same way as the other stuff.
>
> Protecting a branch is a configuration action, so it makes sense to
> put it in the config.

I agree; if we are to have such a flag, the config is the right place
for it.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
