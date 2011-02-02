From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [1.8.0] git-stash invocation changes
Date: Wed, 2 Feb 2011 09:35:52 -0800
Message-ID: <AANLkTimu=drR+4v+B_aB+Y4jVqzaBghh1XYSZoACsBry@mail.gmail.com>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org> <7vwrll57ha.fsf@alter.siamese.dyndns.org>
 <201102021823.19559.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Feb 02 18:36:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkgdD-00057E-Kw
	for gcvg-git-2@lo.gmane.org; Wed, 02 Feb 2011 18:36:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754752Ab1BBRgW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Feb 2011 12:36:22 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:47285 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754744Ab1BBRgT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Feb 2011 12:36:19 -0500
Received: by ewy5 with SMTP id 5so177045ewy.19
        for <git@vger.kernel.org>; Wed, 02 Feb 2011 09:36:17 -0800 (PST)
Received: by 10.103.233.7 with SMTP id k7mr4827886mur.131.1296668177595; Wed,
 02 Feb 2011 09:36:17 -0800 (PST)
Received: by 10.103.1.2 with HTTP; Wed, 2 Feb 2011 09:35:52 -0800 (PST)
In-Reply-To: <201102021823.19559.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165919>

On Wed, Feb 2, 2011 at 09:23, Thomas Rast <trast@student.ethz.ch> wrote=
:
> Proposal:
>
> 1. Change 'git stash <not-a-stash-command>' to give a usage message
> =A0 instead of using <not-a-stash-command> as the stash message.

Oh please, yes, please do this.  We should have done this long, long
ago.  Its easy enough to train your fingers or fix your scripts to say
`git stash save list` rather than `git stash lsit` once stash errors
out and gives you a usage message once.

> Migration plan:
>
> In 1.7.5, give a loud warning for both syntaxes.
>
> In 1.8.0, switch them as described.

Just fix it.  I can't imagine anyone cares enough that `git stash
blah` stops working without first saying save.

--=20
Shawn.
