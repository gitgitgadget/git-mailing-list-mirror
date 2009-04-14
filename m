From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH RFC3 08/13] send-email: Remove superfluous `my $editor
	= ...'
Date: Tue, 14 Apr 2009 08:16:45 +0200
Message-ID: <20090414061645.GB3948@atjola.homenet>
References: <1239647037-15381-1-git-send-email-mfwitten@gmail.com> <1239647037-15381-2-git-send-email-mfwitten@gmail.com> <1239647037-15381-3-git-send-email-mfwitten@gmail.com> <1239647037-15381-4-git-send-email-mfwitten@gmail.com> <1239647037-15381-5-git-send-email-mfwitten@gmail.com> <1239647037-15381-6-git-send-email-mfwitten@gmail.com> <1239647037-15381-7-git-send-email-mfwitten@gmail.com> <1239647037-15381-8-git-send-email-mfwitten@gmail.com> <1239647037-15381-9-git-send-email-mfwitten@gmail.com> <49E3CD48.1010809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 14 08:18:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtbyZ-0006GZ-As
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 08:18:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751862AbZDNGQr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Apr 2009 02:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751635AbZDNGQr
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 02:16:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:46850 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751149AbZDNGQr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2009 02:16:47 -0400
Received: (qmail invoked by alias); 14 Apr 2009 06:16:45 -0000
Received: from i59F5BDC9.versanet.de (EHLO atjola.local) [89.245.189.201]
  by mail.gmx.net (mp040) with SMTP; 14 Apr 2009 08:16:45 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1//d3p5UJz/m/yteva6v/ceaLYMbt1xeGD0UbEWY+
	7jQVHBGdqW2PYA
Content-Disposition: inline
In-Reply-To: <49E3CD48.1010809@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116518>

On 2009.04.13 16:39:52 -0700, Stephen Boyd wrote:
> Michael Witten wrote:
>> -	my $editor =3D $ENV{GIT_EDITOR} || Git::config(@repo, "core.editor=
") || $ENV{VISUAL} || $ENV{EDITOR} || "vi";
>
> I don't want to start an editor war, but why is 'vi' here? It seems
> that one of the previous four should be set at all times, correct?

Probably because that's how the rest of git works, too. See core.editor
in git-config(1) or launch_editor() in editor.c if you don't trust the
docs.

Oh, and I seem to rely on that behaviour :-)

Bj=F6rn
