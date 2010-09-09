From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] userdiff.c: add builtin fortran regex patterns
Date: Thu, 9 Sep 2010 15:25:56 -0400
Message-ID: <20100909192556.GE32508@sigill.intra.peff.net>
References: <rRj7JpFIk_D_n7-wGkkucFJE0330IabsqMoSzalswHpjT-Z1HCuOFaIgMsaPgIuQSp0KUMW97Wo@cipher.nrlssc.navy.mil>
 <rRj7JpFIk_D_n7-wGkkucKFVckLzqXnIAA17N9A643YqyUkXvOqBHrthWFrRRIbouApw4_WLoBE@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Sep 09 21:25:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Otmkn-0007ot-AM
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 21:25:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755309Ab0IITZp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Sep 2010 15:25:45 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:53200 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753166Ab0IITZn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Sep 2010 15:25:43 -0400
Received: (qmail 21071 invoked by uid 111); 9 Sep 2010 19:25:43 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 09 Sep 2010 19:25:43 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Sep 2010 15:25:56 -0400
Content-Disposition: inline
In-Reply-To: <rRj7JpFIk_D_n7-wGkkucKFVckLzqXnIAA17N9A643YqyUkXvOqBHrthWFrRRIbouApw4_WLoBE@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155890>

On Thu, Sep 09, 2010 at 02:02:48PM -0500, Brandon Casey wrote:

> This adds fortran xfuncname and wordRegex patterns to the list of builtin
> patterns.  The intention is for the patterns to be appropriate for all
> versions of fortran including 77, 90, 95.  The patterns can be enabled by
> adding the diff=fortran attribute to the .gitattributes file for the
> desired file glob.

The rest of your series looks reasonable, modulo the comments I posted
to individual patches. But I won't torture my eyes by trying to actually
see how well this matches fortran code, and just assume this is a good
change. :)

> This also adds a new macro named iPATTERN which is just like the PATTERNS
> macro except it sets the REG_ICASE flag so that case will be ignored.

Style nit: please keep macros all uppercase.

-Peff
