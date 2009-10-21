From: Jan =?UTF-8?B?S3LDvGdlcg==?= <jk@jk.gs>
Subject: Re: git gc and kernel.org
Date: Wed, 21 Oct 2009 12:21:02 +0200
Message-ID: <20091021122102.0793295e@perceptron>
References: <4ADD6026.8070203@zytor.com>
	<7veioyqzeo.fsf@alter.siamese.dyndns.org>
	<200910201054.48315.johan@herland.net>
	<alpine.LFD.2.00.0910201442480.21460@xanadu.home>
	<7v63a9n5i6.fsf@alter.siamese.dyndns.org>
	<4ADEA93E.7060907@viscovery.net>
	<7vzl7l8b1y.fsf@alter.siamese.dyndns.org>
	<7vaazl8acd.fsf@alter.siamese.dyndns.org>
	<4ADEC0DB.4000104@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, ftpadmin@kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Oct 21 12:27:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0YPX-0006ba-G4
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 12:27:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753299AbZJUK1I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 06:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753294AbZJUK1I
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 06:27:08 -0400
Received: from zoidberg.org ([88.198.6.61]:35479 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753264AbZJUK1H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 06:27:07 -0400
X-Greylist: delayed 364 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Oct 2009 06:27:07 EDT
Received: from perceptron (xdsl-78-35-162-227.netcologne.de [::ffff:78.35.162.227])
  (IDENT: unknown, AUTH: LOGIN jast, TLS: TLSv1/SSLv3,128bits,AES128-SHA)
  by cthulhu.zoidberg.org with esmtp; Wed, 21 Oct 2009 12:21:04 +0200
  id 004D013D.4ADEE091.00001C7C
In-Reply-To: <4ADEC0DB.4000104@viscovery.net>
X-Mailer: Claws Mail 3.7.3 (GTK+ 2.16.1; i486-pc-linux-gnu)
X-Obscure-Spam: http://music-jk.net/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130902>

Johannes Sixt <j.sixt@viscovery.net> wrote:
> $ git gc --auto --quiet
> Auto packing your repository for optimum performance. You may also
> run "git gc" manually. See "git help gc" for more information.
> [...]
> [*] Skipping the hint to "run git gc manually" would even be good in
> this case, because the hint pertains the remote repository, not the
> one from which "git push" was issued.

I agree with your suggestions. On the same note, while we're already
changing the message, it might make sense to change it to "Auto packing
the repository [...]".

Jan
