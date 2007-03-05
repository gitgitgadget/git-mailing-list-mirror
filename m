From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Git checkout preserve timestamp?
Date: Mon, 05 Mar 2007 23:39:53 +0100
Message-ID: <vpqirdf5n7q.fsf@olympe.imag.fr>
References: <17895.18265.710811.536526@lisa.zopyra.com>
	<20070302091426.GA2605@diana.vm.bytemark.co.uk>
	<17896.9631.316001.869157@lisa.zopyra.com>
	<Pine.LNX.4.63.0703021618000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<20070302162136.GA9593@diana.vm.bytemark.co.uk>
	<Pine.LNX.4.63.0703022018190.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<20070305072323.GA31169@diana.vm.bytemark.co.uk>
	<Pine.LNX.4.63.0703051230390.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<17900.27067.247950.419438@lisa.zopyra.com>
	<Pine.LNX.4.63.0703052014020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<17900.30394.172067.743310@lisa.zopyra.com>
	<Pine.LNX.4.63.0703052143120.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<17900.36569.805689.922989@lisa.zopyra.com>
	<Pine.LNX.4.64.0703051347490.3998@woody.linux-foundation.org>
	<17900.39124.763603.695942@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 05 23:41:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOLrl-000112-0T
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 23:41:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446AbXCEWkI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 17:40:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932486AbXCEWkI
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 17:40:08 -0500
Received: from imag.imag.fr ([129.88.30.1]:56150 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932469AbXCEWkF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 17:40:05 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l25MdrIv013536
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Mon, 5 Mar 2007 23:39:53 +0100 (CET)
Received: from olympe.imag.fr ([129.88.43.60])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HOLqT-0004lO-Im
	for git@vger.kernel.org; Mon, 05 Mar 2007 23:39:53 +0100
Received: from moy by olympe.imag.fr with local (Exim 4.50)
	id 1HOLqT-0001yw-GL
	for git@vger.kernel.org; Mon, 05 Mar 2007 23:39:53 +0100
Mail-Followup-To: git@vger.kernel.org
In-Reply-To: <17900.39124.763603.695942@lisa.zopyra.com> (Bill Lear's message of "Mon\, 5 Mar 2007 16\:25\:24 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 05 Mar 2007 23:39:53 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41498>

Bill Lear <rael@zopyra.com> writes:

> I move back to master branch. Git stores M as branchX:sourcefile.c
> Git checks out the file, and stamps it with N. I do a make. No
> recompilation happens.

Are you not describing a situation where git would modify a file
("move back to branchX"), and no recompilation happens (whereas it
should)?

-- 
Matthieu
