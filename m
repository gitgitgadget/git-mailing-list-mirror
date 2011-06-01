From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: speed of git reset -- file
Date: Wed, 1 Jun 2011 08:14:19 +0700
Message-ID: <BANLkTi=9Z6DKmR=1WesrA1kg0a0TVTaAQQ@mail.gmail.com>
References: <20110531190015.GA12113@gnu.kitenet.net> <20110531212639.GA13234@sigill.intra.peff.net>
 <7vpqmyilj6.fsf@alter.siamese.dyndns.org> <vpqr57e1pt8.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Joey Hess <joey@kitenet.net>,
	GIT Mailing-list <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 01 03:14:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRa1Q-0001yv-48
	for gcvg-git-2@lo.gmane.org; Wed, 01 Jun 2011 03:14:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933077Ab1FABOv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2011 21:14:51 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:62317 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933018Ab1FABOu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2011 21:14:50 -0400
Received: by bwz15 with SMTP id 15so4127258bwz.19
        for <git@vger.kernel.org>; Tue, 31 May 2011 18:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=fNNxlUYYVuQAielbUkyo2eTfuYQMmmo/wB5kSuQnXNo=;
        b=PRZCEKjW6fs0fPeVKioh75UQbaIgTPh7a+QnIlq6Q6woetbf6a8dc2x7Gq4BzofAke
         O3QjhxUed3TMkCPajmKiXDnSGIE4v/9jrBXspnt+34xzPCS5r4yJrNYDt+525c8ngdjp
         nh6Kd2fcumQL+e2YaApzuwN2diga/TfhUapwY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=VcflSQJv7XdG3QnJ8WgF9IyKIPP7mI7k4gVR3n0H5/lSsT7GLGBcu7GroiKTWsyEgA
         CNRn+Nv9iT1zVvhnlKNSCRG2WauoPwjoVgVjX5x/Ms5CQfLCCp6jO8Uy4PF0Bf8HwK/Q
         mBL/8U57afo+eDQO3rBpDaN7I90nMhhQ19gro=
Received: by 10.204.178.8 with SMTP id bk8mr6214905bkb.35.1306890889183; Tue,
 31 May 2011 18:14:49 -0700 (PDT)
Received: by 10.204.50.150 with HTTP; Tue, 31 May 2011 18:14:19 -0700 (PDT)
In-Reply-To: <vpqr57e1pt8.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174845>

On Wed, Jun 1, 2011 at 5:13 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> This reminder is handy, but I can understand that people with really big
> trees whish to stat all the files only as needed (and would need to run
> "git status" by hand when needed). We can imagine a config variable like
> core.IHaveAReallyBigTree or so disabled by default for such cases.

git update-index --assume-unchanged and core.ignorestat?
-- 
Duy
