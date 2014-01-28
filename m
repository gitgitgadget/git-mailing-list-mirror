From: Jeff King <peff@peff.net>
Subject: Re: [ANNOUNCE] Git v1.9-rc0
Date: Mon, 27 Jan 2014 19:04:42 -0500
Message-ID: <20140128000442.GA17227@sigill.intra.peff.net>
References: <CALZVapmqcFjjKeURHdP4chkB+T2--caJZYiJBzdwq7Ou=HzO5w@mail.gmail.com>
 <52DFE882.2040605@atlas-elektronik.com>
 <xmqq7g9syp1m.fsf@gitster.dls.corp.google.com>
 <CAFFjANTNLnc4GcVeSEvuWpfYVXJchJqkHwvUVdREdXmWx6e4=Q@mail.gmail.com>
 <xmqqlhy7yjjp.fsf@gitster.dls.corp.google.com>
 <20140122203030.GB14211@milliways>
 <20140123020913.GF17254@sigill.intra.peff.net>
 <xmqqha8uva2i.fsf@gitster.dls.corp.google.com>
 <20140124233635.GA31371@sigill.intra.peff.net>
 <xmqqy521m3tv.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ken Moffat <zarniwhoop@ntlworld.com>,
	Vicent =?utf-8?B?TWFydMOt?= <tanoku@gmail.com>,
	Stefan =?utf-8?B?TsOkd2U=?= <stefan.naewe@atlas-elektronik.com>,
	Javier Domingo Cansino <javierdo1@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: linux-kernel-owner@vger.kernel.org Tue Jan 28 01:05:24 2014
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1W7wB9-0006tj-Hz
	for glk-linux-kernel-3@plane.gmane.org; Tue, 28 Jan 2014 01:05:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753937AbaA1AEq (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 27 Jan 2014 19:04:46 -0500
Received: from cloud.peff.net ([50.56.180.127]:39958 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753459AbaA1AEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jan 2014 19:04:44 -0500
Received: (qmail 27575 invoked by uid 102); 28 Jan 2014 00:04:44 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 27 Jan 2014 18:04:44 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Jan 2014 19:04:42 -0500
Content-Disposition: inline
In-Reply-To: <xmqqy521m3tv.fsf@gitster.dls.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241172>

On Mon, Jan 27, 2014 at 02:56:28PM -0800, Junio C Hamano wrote:

> > # replace this with however you store your oauth token
> > # if you don't have one, make one here:
> > # https://github.com/settings/tokens/new
> > token() {
> >   pass -n github.web.oauth
> 
> Hmph, what is this "pass" thing?

It's a poor man's Keychain:

  https://github.com/peff/pass

Judging from your use of netrc in Meta/RelUpload, you probably just
want:

  token() {
    cat ~/.github-token
  }

-Peff
