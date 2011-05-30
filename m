From: David Glesser <glesserd@ensimag.fr>
Subject: Re: tag format and tests
Date: Mon, 30 May 2011 18:09:55 +0200
Message-ID: <daee28953084189497dd2f2c8988cd03@ensimag.fr>
References: <db6ec478a7cb9b963d90651f5315ffec@ensimag.fr> <20110530160203.GB24431@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>, <Matthieu.Moy@grenoble-inp.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 30 18:10:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QR52i-0001xM-Co
	for gcvg-git-2@lo.gmane.org; Mon, 30 May 2011 18:10:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757378Ab1E3QKG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2011 12:10:06 -0400
Received: from mx1.imag.fr ([129.88.30.5]:44765 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756662Ab1E3QKF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2011 12:10:05 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p4UG9rjW032320
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 30 May 2011 18:09:53 +0200
Received: from web-ensimag.imag.fr (web-ensimag [195.221.228.24])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id p4UG9tTN016587;
	Mon, 30 May 2011 18:09:55 +0200
Received: from webmail.ensimag.fr (localhost [127.0.0.1])
	by web-ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens) with ESMTP id p4UG9tFT030064;
	Mon, 30 May 2011 18:09:55 +0200
In-Reply-To: <20110530160203.GB24431@sigill.intra.peff.net>
X-Sender: glesserd@ensimag.fr
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 30 May 2011 18:09:53 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p4UG9rjW032320
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: glesserd@ensimag.fr
MailScanner-NULL-Check: 1307376596.8817@nwN6V9hlLeC7GWVnOgFjXg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174758>

On Mon, 30 May 2011 12:02:03 -0400, Jeff King <peff@peff.net> wrote:
> And I think the answer is "no", because we may be handing gpg-signed
> contents to mktag, and any change could invalidate that signature. So
> libgit2 is wrong to munge the data.

Ok, I will patch libgit2.

> I imagine your code parses the buffer into a tag object, checks that it
> parsed properly, then writes out that object.

Exactly !

Thanks for your answer.

David G.
