From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH v2] completion: add new git_complete helper
Date: Wed, 18 Apr 2012 00:14:44 +0200
Message-ID: <20120417221444.GD10081@goldbirke>
References: <1334524814-13581-1-git-send-email-felipe.contreras@gmail.com>
	<20120415213718.GB5813@burratino> <20120416221531.GA2299@goldbirke>
	<CAMP44s2N9wFg5kx7jw2w6G6BQ1riX-W9cKt8kBPaofugm0OV1g@mail.gmail.com>
	<7vty0inys6.fsf@alter.siamese.dyndns.org>
	<CAMP44s1sj27U_s3Y3nLL6pkMrPMVvTo982c85x-hH5szvprK0g@mail.gmail.com>
	<7v4nsins1j.fsf@alter.siamese.dyndns.org>
	<CAMP44s0w40ViecQsF8AeQLLxAEShC54TTyvcPVMabpOZ+DYDqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 18 00:15:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKGfo-0008VV-PV
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 00:14:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752896Ab2DQWOw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Apr 2012 18:14:52 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:51426 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752246Ab2DQWOv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2012 18:14:51 -0400
Received: from localhost6.localdomain6 (p5B1306D0.dip0.t-ipconnect.de [91.19.6.208])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0MELbk-1SVF2C3WBc-00FSbe; Wed, 18 Apr 2012 00:14:45 +0200
Content-Disposition: inline
In-Reply-To: <CAMP44s0w40ViecQsF8AeQLLxAEShC54TTyvcPVMabpOZ+DYDqQ@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:jCSCxyP1NMlIwk8lySTVodlYaR7cQs3tZBFO9IWdyHD
 xwgCN+LFwPuZDeO79fDYU2HVtYBoRLYYAf3JP1AV7FnJrREPLw
 AfYY+BcW2S5gxI9S7f2XF6p4h5wZdyoiywqOYyBp2qOWGQVO4w
 NEiFKiBirVNPIyLcnwxtNT0EizVtOU5rpIDKxyZvjGBL9qgGta
 pyYKgdO/1Zasy/exfaAkYYmByW6tIbHRpYtRzlnE7yTUjZMrTS
 Wz0DZUeZ+ohlOoJPRBWMWRcakssYiMB0J/R7M8GqTmUtycpoq7
 puw6wIwY2J1iJaqMz49WWZw6yIjCz+tsGB0jIm0ByHpL+u/dI3
 8SSTsADdpFpvmUyEMnwZHAso++mvUQ96XwdUSHdge
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195817>

On Tue, Apr 17, 2012 at 11:53:08PM +0300, Felipe Contreras wrote:
> Are you saying that even if there are no real clashes, only
> hypothetical ones, you would still prefer __git_complete?

Can you ascertain that there are no real clashes?

> How are people going to distinguish between public and private functi=
ons?

By reading the documentation, perhaps?  It was not a problem for
__git_ps1(), so I guess it won't be a problem for __git_complete()
either.  Assuming that it will be documented eventually, of course.


Best,
G=E1bor
