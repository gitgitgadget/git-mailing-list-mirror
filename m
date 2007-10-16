From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 07/25] parse-options: make some arguments optional,
 add callbacks.
Date: Tue, 16 Oct 2007 12:44:53 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0710161244190.19446@xanadu.home>
References: <1192522616-16274-1-git-send-email-madcoder@debian.org>
 <1192523998-19474-1-git-send-email-madcoder@debian.org>
 <1192523998-19474-2-git-send-email-madcoder@debian.org>
 <1192523998-19474-3-git-send-email-madcoder@debian.org>
 <1192523998-19474-4-git-send-email-madcoder@debian.org>
 <1192523998-19474-5-git-send-email-madcoder@debian.org>
 <1192523998-19474-6-git-send-email-madcoder@debian.org>
 <1192523998-19474-7-git-send-email-madcoder@debian.org>
 <20071016084510.GI6919@artemis.corp> <4714E90C.80305@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_r4fGsy6MXf3wd/LEmYusbw)"
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Oct 16 18:45:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhpXz-0004AM-DB
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 18:45:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755897AbXJPQpZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 12:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756017AbXJPQpZ
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 12:45:25 -0400
Received: from relais.videotron.ca ([24.201.245.36]:30979 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754276AbXJPQpY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 12:45:24 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JQ000GVCJUTK7N0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 16 Oct 2007 12:44:53 -0400 (EDT)
In-reply-to: <4714E90C.80305@lsrfire.ath.cx>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61207>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_r4fGsy6MXf3wd/LEmYusbw)
Content-type: TEXT/PLAIN; charset=ISO-8859-15
Content-transfer-encoding: 8BIT

On Tue, 16 Oct 2007, René Scharfe wrote:

> Pierre Habouzit schrieb:
> > This bit is to allow to aggregate options with arguments together when
> > the argument is numeric.
> > 
> >     +#if 0
> >     +		/* can be used to understand -A1B1 like -A1 -B1 */
> >     +		if (flag & OPT_SHORT && opt->opt && isdigit(*opt->opt)) {
> >     +			*(int *)opt->value = strtol(opt->opt, (char **)&opt->opt, 10);
> >     +			return 0;
> >     +		}
> >     +#endif
> 
> I don't like it, it complicates number options with unit suffixes (e.g.
> --windows-memory of git-pack-objects).

This is my opinion too.


Nicolas

--Boundary_(ID_r4fGsy6MXf3wd/LEmYusbw)--
