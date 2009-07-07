From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC/PATCH] git-gui: display summary when showing diff of a submodule
Date: Tue, 07 Jul 2009 18:45:38 +0200
Message-ID: <4A537BB2.90800@web.de>
References: <4A526D15.3090202@web.de> <4A534728.3050005@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Jul 07 18:46:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MODnj-0007Rh-1t
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 18:45:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757109AbZGGQpl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2009 12:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756198AbZGGQpk
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jul 2009 12:45:40 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:53126 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755041AbZGGQpk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2009 12:45:40 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id 708A41036A30F;
	Tue,  7 Jul 2009 18:45:39 +0200 (CEST)
Received: from [80.128.54.107] (helo=[192.168.178.26])
	by smtp05.web.de with asmtp (WEB.DE 4.110 #277)
	id 1MODnW-0001qC-00; Tue, 07 Jul 2009 18:45:38 +0200
User-Agent: Thunderbird 2.0.0.22 (X11/20090605)
In-Reply-To: <4A534728.3050005@drmicha.warpmail.net>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18cPdfv7Vz3kg0SO/NYkS8p9opV7zJ1uYrMnWII
	MNVOpmlSDTKTP9ahY9B1RFxe4Ldw9wMMAWbe5NYly/UDIv6RLW
	5DsAHXAiBgxmf60avkHQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122854>

Michael J Gruber schrieb:
> Me wonders whether the summary should be the default diff output, or at
> least a builtin merge driver which can be selected using attributes or such.

Yes, i was thinking about that too. But i have no idea if it would be
a good or bad idea to extend git diff that way.

And for git gui it doesn't really matter. The only difference to my patch
would be the line where the diff command is replaced with submodule summary
(assuming the output would stay compatible). The rest of the patch is about
handling that output, no matter how it is generated.


Jens
