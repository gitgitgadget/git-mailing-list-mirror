From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Stgit and refresh-temp
Date: Fri, 7 Nov 2008 06:44:19 +0100
Message-ID: <20081107054419.GA27146@diana.vm.bytemark.co.uk>
References: <9e4733910811040537p4e88c09an94370154eca12778@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 07 06:45:58 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyKAL-0006dG-6j
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 06:45:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755176AbYKGFoZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Nov 2008 00:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755160AbYKGFoZ
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 00:44:25 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3598 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755084AbYKGFoY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 00:44:24 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KyK8p-00075P-00; Fri, 07 Nov 2008 05:44:19 +0000
Content-Disposition: inline
In-Reply-To: <9e4733910811040537p4e88c09an94370154eca12778@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100288>

On 2008-11-04 08:37:24 -0500, Jon Smirl wrote:

> I hit a case when refreshing a buried patch that needed a merge
> conflict sorted out. I'm unable to recover out of the state.

Hmm, so what you're saying is basically that you did something with
"stg refresh -p" that caused a merge conflict, and that messed things
up so that you needed to run "stg repair". Is that right?

Have you been able to reproduce it? (I would like to add the failing
case to the test suite.)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
