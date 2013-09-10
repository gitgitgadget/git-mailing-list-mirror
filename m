From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 1/5] pull: rename pull.rename to pull.mode
Date: Mon, 9 Sep 2013 22:21:52 -0400
Message-ID: <20130910022152.GA17154@sigill.intra.peff.net>
References: <1378689796-19305-1-git-send-email-felipe.contreras@gmail.com>
 <1378689796-19305-2-git-send-email-felipe.contreras@gmail.com>
 <522E3C6A.3070409@bbn.com>
 <CAMP44s1OyST3S1HEdS38WPsjq6w9SekuwT4DRUgVvduATox9tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Richard Hansen <rhansen@bbn.com>, git@vger.kernel.org,
	Andreas Krey <a.krey@gmx.de>,
	John Keeping <john@keeping.me.uk>,
	Philip Oakley <philipoakley@iee.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 10 04:22:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJDam-0002fG-EG
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 04:22:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751716Ab3IJCV4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 22:21:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:60100 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751210Ab3IJCVz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 22:21:55 -0400
Received: (qmail 10007 invoked by uid 102); 10 Sep 2013 02:21:54 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 09 Sep 2013 21:21:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Sep 2013 22:21:52 -0400
Content-Disposition: inline
In-Reply-To: <CAMP44s1OyST3S1HEdS38WPsjq6w9SekuwT4DRUgVvduATox9tw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234416>

On Mon, Sep 09, 2013 at 05:49:36PM -0500, Felipe Contreras wrote:

> > These deprecation warning messages should be written to stderr, and
> > should probably be prefixed with "WARNING: ".
> 
> Is there any deprecation warning that works this way?

The ones in C code typically use warning(), which will prefix with
"warning:" and write to stderr. They do not use all-caps, though.

Try "git log --grep=deprecate -Swarning" for some examples.

-Peff
