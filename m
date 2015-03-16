From: Mike Hommey <mh@glandium.org>
Subject: Re: Bug in git-verify-pack or in its documentation?
Date: Mon, 16 Mar 2015 22:18:08 +0900
Message-ID: <20150316131808.GA19353@glandium.org>
References: <20150316080558.GA30234@glandium.org>
 <CACsJy8AXvYCje0-smbNdfGtjsdYieKyxxiHCGf32Jpi3seDrvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 16 14:18:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXUuW-00062M-El
	for gcvg-git-2@plane.gmane.org; Mon, 16 Mar 2015 14:18:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751989AbbCPNSU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2015 09:18:20 -0400
Received: from ks3293202.kimsufi.com ([5.135.186.141]:34160 "EHLO glandium.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751327AbbCPNSS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2015 09:18:18 -0400
Received: from glandium by zenigata with local (Exim 4.84)
	(envelope-from <glandium@glandium.org>)
	id 1YXUuG-00052q-33; Mon, 16 Mar 2015 22:18:08 +0900
Content-Disposition: inline
In-Reply-To: <CACsJy8AXvYCje0-smbNdfGtjsdYieKyxxiHCGf32Jpi3seDrvA@mail.gmail.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265556>

On Mon, Mar 16, 2015 at 05:13:25PM +0700, Duy Nguyen wrote:
> On Mon, Mar 16, 2015 at 3:05 PM, Mike Hommey <mh@glandium.org> wrote:
> > Hi,
> >
> > git-verify-pack's man page says the following about --stat-only:
> >
> >    Do not verify the pack contents; only show the histogram of delta
> >    chain length. With --verbose, list of objects is also shown.
> >
> > However, there is no difference of output between --verbose and
> > --verbose --stat-only (and in fact, looking at the code, only one of
> > them has an effect, --stat-only having precedence).
> 
> There is. very-pack --verbose would show a lot of "<sha-1> <type>
> <"random" numbers>" lines before the histogram while --stat-only (with
> or without --verbose) would only show the histogram.

Err, I meant between --stat-only and --verbose --stat-only.

Mike
