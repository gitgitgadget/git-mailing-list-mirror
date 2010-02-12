From: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
Subject: Re: [PATCH 2/4] git-mailsplit: add `mailsplit.keepcr`
	configuration variable.
Date: Fri, 12 Feb 2010 22:03:36 +0100
Organization: -no organization-
Message-ID: <20100212210336.GB32018@pille.home>
References: <1265923579-24900-1-git-send-email-stefan.hahn@s-hahn.de> <1265923579-24900-3-git-send-email-stefan.hahn@s-hahn.de> <7vhbpnqrxr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 12 22:04:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ng2gB-0007Wj-R7
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 22:04:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757827Ab0BLVDn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 16:03:43 -0500
Received: from moutng.kundenserver.de ([212.227.17.10]:55595 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757673Ab0BLVDl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 16:03:41 -0500
Received: from pille.home (port-92-203-117-198.dynamic.qsc.de [92.203.117.198])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0MACkL-1NZDAh1jlR-00BX7T; Fri, 12 Feb 2010 22:03:39 +0100
Received: from pille.home (localhost [127.0.0.1])
	by pille.home (8.14.3/8.14.3/Debian-5) with ESMTP id o1CL3biV013805;
	Fri, 12 Feb 2010 22:03:37 +0100
Received: (from hs@localhost)
	by pille.home (8.14.3/8.14.3/Submit) id o1CL3aNn013804;
	Fri, 12 Feb 2010 22:03:36 +0100
X-Authentication-Warning: pille.home: hs set sender to stefan.hahn@s-hahn.de using -f
Content-Disposition: inline
In-Reply-To: <7vhbpnqrxr.fsf@alter.siamese.dyndns.org>
X-Mailer: Mutt 1.5.18 http://www.mutt.org/
X-Editor: GNU Emacs 22.2.1 http://www.gnu.org/
X-Accept-Language: de en
X-Location: Europe, Germany, Wolfenbuettel
X-GPG-Public-Key: gpg --keyserver keys.gnupg.net --recv-keys E4FCD563
X-GPG-key-ID/Fingerprint: 0xE4FCD563 / EF09 97BB 3731 7DC7 25BA 5C39 185C
	F986 E4FC D563
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Provags-ID: V01U2FsdGVkX18Qec+yFJDpMlMIFykmvGttEFtYOtlYGoQcUGq
 7PhrIRNIxQt3gw4Bg94HLVg75DpnOADezn6wlwEUt+O7dYGg8L
 ufStNMdYpecs4gqK+kocQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139745>

Also sprach Junio C Hamano am Thu, 11 Feb 2010 at 15:21:52 -0800:

> > With this patch the behaviour of git-mailsplit can be set via
> > configuration file.
> 
> This probably is a bad change.  mailsplit is designed to be usable without
> being inside any git repository.  With this change, doesn't the command
> start failing to run when run outside a git repository?

Ouch, I didn't mind this.

But perhaps it will be a better aproach to make such a configuration
available for git-am. I will make a patch for this soon.

Stefan

-- 
Stefan-W. Hahn                          It is easy to make things.
/ mailto:stefan.hahn@s-hahn.de /        It is hard to make things simple.			

Please note that according to the German law on data retention,
information on every electronic information exchange with me is
retained for a period of six months.
Bundesgesetzblatt:
http://www.bgblportal.de/BGBL/bgbl1f/bgbl107s3198.pdf
