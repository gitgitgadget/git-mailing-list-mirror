From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PYRITE] Status update and call for information.
Date: Fri, 23 May 2008 15:12:28 +0200
Message-ID: <20080523131228.GA4292@diana.vm.bytemark.co.uk>
References: <5d46db230805222318j25657c10t2955fbdf1aa5c003@mail.gmail.com> <20080523064541.GA31315@diana.vm.bytemark.co.uk> <5d46db230805230536r18ac606j93a210d0b2864719@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Govind Salinas <blix@sophiasuchtig.com>
X-From: git-owner@vger.kernel.org Fri May 23 15:13:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzX5M-0000z9-W2
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 15:13:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753314AbYEWNMh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 May 2008 09:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753282AbYEWNMh
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 09:12:37 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1190 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752782AbYEWNMg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 09:12:36 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JzX4O-00019q-00; Fri, 23 May 2008 14:12:28 +0100
Content-Disposition: inline
In-Reply-To: <5d46db230805230536r18ac606j93a210d0b2864719@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82699>

On 2008-05-23 07:36:25 -0500, Govind Salinas wrote:

> On Fri, May 23, 2008 at 1:45 AM, Karl Hasselstr=F6m <kha@treskal.com>
> wrote:
>
> > You do realize that no matter how you define your sequential
> > numbers, they can't be both globally consistent and unique? (That
> > is, either different repositories will assign different numbers to
> > the same commit, or the same number could be assigned to more than
> > one commit.)
>
> Of course, no one makes the claim that rev numbers are unique or
> even that a commit has the same revision number between branches in
> the same repository. Hg states that flat out and I believe bzr says
> the same, although I am pretty sure they determine their numbers
> some other way. I make no such claim. What I do claim is that for a
> given branch, a commit should always have the same revision number.
> Sure, If you merge a commit from another branch, it's revnum might
> change, but that is ok. As long as, assuming you have not re-written
> master, 10:master will always point to the same commit I think I am
> providing something worth while. Also, AFAIK the order of parentage
> is part of the hash that makes a commit ID, so if my master is a
> clone of your master, it should share revision numbers.

Yes, with those restrictions it can be made to work. (What confused me
was that you brought up performance as the only reason to prefer
hashes to your rev numbers. But hashes also have the advantage that
they're immutable, whereas your rev numbers are not.)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
