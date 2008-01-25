From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: stg clean removes conflicting patch
Date: Fri, 25 Jan 2008 11:17:27 +0100
Message-ID: <20080125101727.GA7101@diana.vm.bytemark.co.uk>
References: <1201233317.2811.17.camel@dv> <20080125080434.GA5599@diana.vm.bytemark.co.uk> <b0943d9e0801250153t30c5b9b8w4c08af107cfdf202@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pavel Roskin <proski@gnu.org>, git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 11:18:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JILdd-0008GT-El
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 11:18:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760031AbYAYKRr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jan 2008 05:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760107AbYAYKRq
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jan 2008 05:17:46 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3267 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760031AbYAYKRp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2008 05:17:45 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JILcm-0001rH-00; Fri, 25 Jan 2008 10:17:28 +0000
Content-Disposition: inline
In-Reply-To: <b0943d9e0801250153t30c5b9b8w4c08af107cfdf202@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71697>

On 2008-01-25 09:53:46 +0000, Catalin Marinas wrote:

> On 25/01/2008, Karl Hasselstr=F6m <kha@treskal.com> wrote:
>
> > On 2008-01-24 22:55:17 -0500, Pavel Roskin wrote:
> >
> > > If "stg push" fails, the subsequent "stg clean" will remove the
> > > patch that could not been applied. I think it's wrong.
> >
> > I agree. It's consistent -- a conflicting patch is empty -- but
> > clearly the wrong thing to do from a usability perspective.
>
> Got broken by commit fe1cee2e49d9995852ba92d8fba1d064acf2fca9 which
> removes the check_conflicts() call.

Ah, thanks. I didn't realize it used to work.

> As I said in a different post, we should add these back (and to the
> 'goto' command as well) to make StGIT safer.

The right thing to do would be to check for conflicts before
attempting any kind of modification, I guess.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
