From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add new @ shortcut for HEAD
Date: Tue, 30 Apr 2013 13:56:35 -0400
Message-ID: <20130430175635.GA1972@sigill.intra.peff.net>
References: <1367264106-2351-1-git-send-email-felipe.contreras@gmail.com>
 <CACsJy8D_gPpprETkAxf+eYp5DMt7uVt6nanCwthZO=vVfBT28Q@mail.gmail.com>
 <7vppxcdjd1.fsf@alter.siamese.dyndns.org>
 <CAMP44s0PcB7nu_67p=hfMy4Kb2iYTSp5ZT6y2Gn24OAtDzR_sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Seymour <jon.seymour@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 19:56:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXEnF-00027G-SC
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 19:56:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932617Ab3D3R4i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 13:56:38 -0400
Received: from cloud.peff.net ([50.56.180.127]:40041 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932396Ab3D3R4i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 13:56:38 -0400
Received: (qmail 14976 invoked by uid 102); 30 Apr 2013 17:56:53 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 30 Apr 2013 12:56:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Apr 2013 13:56:35 -0400
Content-Disposition: inline
In-Reply-To: <CAMP44s0PcB7nu_67p=hfMy4Kb2iYTSp5ZT6y2Gn24OAtDzR_sw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222975>

On Tue, Apr 30, 2013 at 12:47:57PM -0500, Felipe Contreras wrote:

> > We should make sure that the code rejects "git update-ref @ foo"
> > because that is "git update-ref @{0} ref", by the way.  I didn't
> > check with Felipe's patch.
> 
> Hmm, with or without my patch 'git update @ foo' does nothing, same
> with 'git update blah foo'. No error, no non-zero exit code, just
> doesn't do anything.

Are you sure?

  $ git version
  git version 1.8.2

  $ git update-ref @ foo
  fatal: foo: not a valid SHA1

  $ git update-ref @ origin/master
  $ echo $?
  0
  $ cat .git/@
  89740333e8d398f1da701e9023675321bbb9a85b

-Peff
