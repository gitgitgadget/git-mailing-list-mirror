From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH v3 1/2] rev-parse: add option --is-well-formed-git-dir
	[path]
Date: Sat, 13 Aug 2011 08:13:43 +0200
Message-ID: <20110813061342.GA459@book.hvoigt.net>
References: <1313178913-25617-1-git-send-email-iveqy@iveqy.com> <1313178913-25617-2-git-send-email-iveqy@iveqy.com> <CACsJy8D7W54w3ji6foXySCuvNLLBu=FY70z8+kB5hmJT_-3yCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org,
	jens.lehmann@web.de, gitster@pobox.com
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 13 08:14:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qs7Tt-0007SD-Bu
	for gcvg-git-2@lo.gmane.org; Sat, 13 Aug 2011 08:14:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750907Ab1HMGNp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Aug 2011 02:13:45 -0400
Received: from darksea.de ([83.133.111.250]:43498 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750791Ab1HMGNp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Aug 2011 02:13:45 -0400
Received: (qmail 31242 invoked from network); 13 Aug 2011 08:13:43 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 13 Aug 2011 08:13:43 +0200
Content-Disposition: inline
In-Reply-To: <CACsJy8D7W54w3ji6foXySCuvNLLBu=FY70z8+kB5hmJT_-3yCg@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179270>

Hi,

On Sat, Aug 13, 2011 at 09:49:56AM +0700, Nguyen Thai Ngoc Duy wrote:
> On Sat, Aug 13, 2011 at 2:55 AM, Fredrik Gustafsson <iveqy@iveqy.com> wrote:
> \> +--is-well-formed-git-dir [path]::
> > + ?? ?? ?? Check if [path] is a valid git-dir or a git-file pointing to a valid
> > + ?? ?? ?? git-dir. If [path] is a valid git-dir the resolved path to git-dir will
> > + ?? ?? ?? be printed.
> 
> May I suggest --is-valid-git-dir?

While we are talking about names how about:

	--resolve-git-dir

? Since we had this information already the option prints out the found
resolved git directory and could be used for that.

Cheers Heiko
