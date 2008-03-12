From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH 03/40] Add target architecture MinGW.
Date: Wed, 12 Mar 2008 23:59:30 +0100
Message-ID: <200803122359.30411.johannes.sixt@telecom.at>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at> <200803112230.57004.johannes.sixt@telecom.at> <alpine.LSU.1.00.0803120028130.3873@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 13 00:00:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZZvg-00068I-0D
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 00:00:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751714AbYCLW7d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 18:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751521AbYCLW7d
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 18:59:33 -0400
Received: from smtp2.srv.eunet.at ([193.154.160.116]:52668 "EHLO
	smtp2.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138AbYCLW7c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 18:59:32 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp2.srv.eunet.at (Postfix) with ESMTP id 4CAE0BEF54;
	Wed, 12 Mar 2008 23:59:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 1675C615D5;
	Wed, 12 Mar 2008 23:59:31 +0100 (CET)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LSU.1.00.0803120028130.3873@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77020>

On Wednesday 12 March 2008 00:28, Johannes Schindelin wrote:
> On Tue, 11 Mar 2008, Johannes Sixt wrote:
> > On the positive side, we can now reuse Michal's vsnprintf wrapper, which
> > fixes snprintf, too, (which was not the case previously). Note that on
> > Windows we have to adjust the size parameter.
>
> Actually, I have to admit that I like strbuf_vaddf() more and more.
> Anything you would wish me to implement there?

Only that you keep an eye on PRIuMAX; if it is ever used in a format string of 
strbuf_vaddf() then you ought to implement %I64u as well as %llu. ;)

-- Hannes
