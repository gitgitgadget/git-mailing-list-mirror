From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: simplest git deamon?
Date: Tue, 13 Apr 2010 02:22:39 +0300
Message-ID: <20100412232239.GA890@LK-Perkele-V2.elisa-laajakaista.fi>
References: <20100412164740.740050cb@pbmiha.malagasy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Mihamina Rakotomandimby <mihamina@gulfsat.mg>
X-From: git-owner@vger.kernel.org Tue Apr 13 01:23:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1Sye-0006uY-2l
	for gcvg-git-2@lo.gmane.org; Tue, 13 Apr 2010 01:23:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752680Ab0DLXXa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Apr 2010 19:23:30 -0400
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:45693 "EHLO
	emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751686Ab0DLXX3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Apr 2010 19:23:29 -0400
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh07-2.mail.saunalahti.fi (Postfix) with SMTP id 4AEE518D800;
	Tue, 13 Apr 2010 02:23:28 +0300 (EEST)
Received: from emh05.mail.saunalahti.fi ([62.142.5.111])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A04983019C0; Tue, 13 Apr 2010 02:23:28 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh05.mail.saunalahti.fi (Postfix) with ESMTP id 8D4C527D84;
	Tue, 13 Apr 2010 02:23:24 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <20100412164740.740050cb@pbmiha.malagasy.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144772>

On Mon, Apr 12, 2010 at 04:47:40PM +0300, Mihamina Rakotomandimby wrote:
> Manao ahoana, Hello, Bonjour,
> 
> I would like to setup a git repository, on a Debian machine.
> I would like to access it only with git:// (no http://, no ssh://,...)
> 
> How to implement read/write restriction when just wanting to use
> "git://" without dealing with SSH?

You can't. git:// in its base form does not support authentication.

Yes, one could extend git:// to support authentication and encryption
(been there, done that), but that isn't usable as client end requires
extra software not included in standard git install (that server end
requires extra software is comparatively no problem).

-Ilari
