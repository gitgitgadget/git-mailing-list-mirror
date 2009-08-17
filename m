From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 05/11] Remove va_copy at MSVC because there are
 va_copy.
Date: Mon, 17 Aug 2009 21:46:14 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908172144460.8306@pacific.mpi-cbg.de>
References: <1250525040-5868-1-git-send-email-lznuaa@gmail.com>  <4A898B27.3040507@gnu.org> <40aa078e0908171002j4b610fe4j34a4e7d3081a9efa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1836697137-1250538375=:8306"
Cc: Paolo Bonzini <bonzini@gnu.org>, Frank Li <lznuaa@gmail.com>,
	git@vger.kernel.org, msysgit@googlegroups.com
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 21:45:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md89A-00014m-Al
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 21:45:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751738AbZHQTp0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 15:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750932AbZHQTp0
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 15:45:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:47851 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750872AbZHQTpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 15:45:25 -0400
Received: (qmail invoked by alias); 17 Aug 2009 19:45:26 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp031) with SMTP; 17 Aug 2009 21:45:26 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Rk5I8rRsRC/5Ci+FP89vmHLMec0HXpRzG3ZsVaY
	kvJoFJlXJpMlaI
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <40aa078e0908171002j4b610fe4j34a4e7d3081a9efa@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126261>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1836697137-1250538375=:8306
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 17 Aug 2009, Erik Faye-Lund wrote:

> On Mon, Aug 17, 2009 at 6:53 PM, Paolo Bonzini<bonzini@gnu.org> wrote:
> > #ifndef va_copy
> > #define va_copy(dst, src)       ((dst) = (src))
> > #endif
> 
> Are you sure va_copy is always a preprocessor symbol? How about
> 
> #ifdef _MSC_VER
> #define va_copy(dst, src)       ((dst) = (src))
> #endif

Why not #define it in compat/msvc.h?  Or introduce a 
DEFINE_VA_COPY_TRIVIALLY symbol or some such?

Ciao,
Dscho
--8323328-1836697137-1250538375=:8306--
