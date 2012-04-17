From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH v2] completion: add new git_complete helper
Date: Tue, 17 Apr 2012 19:50:17 +0200
Message-ID: <20120417175017.GC10081@goldbirke>
References: <1334524814-13581-1-git-send-email-felipe.contreras@gmail.com>
	<20120415213718.GB5813@burratino> <20120416221531.GA2299@goldbirke>
	<CAMP44s2N9wFg5kx7jw2w6G6BQ1riX-W9cKt8kBPaofugm0OV1g@mail.gmail.com>
	<7vty0inys6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, <git@vger.kernel.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 19:50:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKCXs-0005OQ-U8
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 19:50:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752015Ab2DQRuY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Apr 2012 13:50:24 -0400
Received: from ex-e-2.perimeter.fzi.de ([141.21.8.251]:37997 "EHLO
	ex-e-2.perimeter.fzi.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751526Ab2DQRuX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2012 13:50:23 -0400
Received: from ex-ca-ht-1.fzi.de (141.21.32.98) by ex-e-2.perimeter.fzi.de
 (141.21.8.251) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 17 Apr
 2012 19:50:17 +0200
Received: from localhost6.localdomain6 (141.21.50.31) by ex-ca-ht-1.fzi.de
 (141.21.32.98) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 17 Apr
 2012 19:50:17 +0200
Content-Disposition: inline
In-Reply-To: <7vty0inys6.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195775>

On Tue, Apr 17, 2012 at 08:50:01AM -0700, Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>=20
> > 2012/4/17 SZEDER G=E1bor <szeder@ira.uka.de>:
> >> On Sun, Apr 15, 2012 at 04:37:18PM -0500, Jonathan Nieder wrote:
> >>> Felipe Contreras wrote:
> >
> >>> A name like __git_complete should work, presumably.
> >>
> >> And foo_wrap() should also fit into those namespaces.
> >
> > Yeah, I don't have a problem with that, just forgot about it.
> >
> > But git_complete I think is different.
>=20
> Is git_complete something the user types interactively, or is it mean=
t to
> be used in their .bashrc to help them complete arguments to their cus=
tom
> scripts that take arguments similar to Git Porcelains?

Primarily for .bashrc, however, not for their custom scripts but to be
able to use completion for their one-word git aliases, e.g. after an

  alias gf=3D'git fetch'

they want to do

  gf o<TAB>

and get 'origin' completed.

Here's a relevant thread:

  http://thread.gmane.org/gmane.comp.version-control.git/185184/


Best,
G=E1bor
