From: Markus Trippelsdorf <markus@trippelsdorf.de>
Subject: Re: Globbing for ignored branches?
Date: Fri, 24 Jan 2014 21:52:07 +0100
Message-ID: <20140124205207.GG396@x4>
References: <20140124090104.GA396@x4>
 <0C723FEB5B4E5642B25B451BA57E273075148284@S1P5DAG3C.EXCHPROD.USA.NET>
 <20140124170739.GC396@x4>
 <20140124170909.GD396@x4>
 <20140124182341.GB8202@sigill.intra.peff.net>
 <20140124183222.GE396@x4>
 <20140124185538.GA9836@sigill.intra.peff.net>
 <xmqq4n4trvzj.fsf@gitster.dls.corp.google.com>
 <20140124203312.GF396@x4>
 <xmqqmwilqfcl.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Jim Garrison <jim.garrison@nwea.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 24 21:52:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6njb-0000Sl-Kq
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jan 2014 21:52:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752445AbaAXUwM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jan 2014 15:52:12 -0500
Received: from ud10.udmedia.de ([194.117.254.50]:49755 "EHLO
	mail.ud10.udmedia.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751890AbaAXUwK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jan 2014 15:52:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=mail.ud10.udmedia.de; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=beta; bh=0ngNNpgf9qdXa/O+eqBaTpNvbq
	5paAzYyCS3357awIo=; b=NmcBK6BoYhf+l3Uw4nERytb7QRLCoG0Z0bMVuCfVKQ
	o7DEP3L8KvuNgvJcpfGFytMoQAVVe+1kLCADsP3E512A/F/l/Hb4LN0yim++J6+a
	XVWhZisY59jZwP6djX4toJVAevPW/7chlHncxDpHGTqLXG6ht3sVz+rYNjfuHJZf
	0=
Received: (qmail 22778 invoked from network); 24 Jan 2014 21:52:07 +0100
Received: from unknown (HELO x4) (ud10?360p3@91.64.96.185)
  by mail.ud10.udmedia.de with ESMTPSA (DHE-RSA-AES256-SHA encrypted, authenticated); 24 Jan 2014 21:52:07 +0100
Content-Disposition: inline
In-Reply-To: <xmqqmwilqfcl.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241038>

On 2014.01.24 at 12:44 -0800, Junio C Hamano wrote:
> Markus Trippelsdorf <markus@trippelsdorf.de> writes:
> 
> > On 2014.01.24 at 12:00 -0800, Junio C Hamano wrote:
> >> Jeff King <peff@peff.net> writes:
> >> 
> >> > On Fri, Jan 24, 2014 at 07:32:22PM +0100, Markus Trippelsdorf wrote:
> >> >
> >> >> > However, you do have to specify each branch individually. You probably
> >> >> > want to say "all branches except X", and you cannot currently specify
> >> >> > a negative refspec like that.
> >> >> 
> >> >> Yes, that was the question I wanted to ask (, sorry for not formulating
> >> >> it more clearly). 
> >> >> Is this "negative refspec for branches" a feature that is planned for
> >> >> the future?
> >> >
> >> > It is something that has been talked about before, but I do not think
> >> > anybody is actively working on. It would probably not be too hard a
> >> > feature if you are interested in getting your feet wet in git
> >> > development. :)
> >> 
> >> The end result might be not so hard in the mechanical sense, but
> >> designing the interface would be hard.  I do not offhand think of a
> >> good way to do this.
> >
> > I don't know if the in-tree regex engine supports negative lookaheads.
> > If it does, then something like the following should work (to use my
> > "hjl" example):
> >
> > ^(.(?!hjl))*
> 
> refspec wildcards are *NOT* regular expressions.

Yes, but that's the point. If they were, the "negative refspec"
interface issue would be solved.

-- 
Markus
