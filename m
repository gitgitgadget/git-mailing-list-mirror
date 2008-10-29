From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] Implement git-staged, an alias for 'git diff --cached'.
Date: Wed, 29 Oct 2008 11:59:35 +0100
Message-ID: <C0BD1E4B-130F-4A16-8865-8EEABE1431FD@wincent.com>
References: <20081029003931.GA7291@sigill.intra.peff.net> <1225241048-99267-1-git-send-email-dsymonds@gmail.com>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, Jeff King <peff@peff.net>
To: David Symonds <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 29 12:01:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kv8nu-0006EZ-8S
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 12:01:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753515AbYJ2LAS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Oct 2008 07:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753331AbYJ2LAS
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 07:00:18 -0400
Received: from wincent1.inetu.net ([209.235.192.161]:44111 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753902AbYJ2LAN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Oct 2008 07:00:13 -0400
Received: from cuzco.lan (225.pool85-53-3.dynamic.orange.es [85.53.3.225])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id m9TAxaM8014927
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 29 Oct 2008 06:59:38 -0400
In-Reply-To: <1225241048-99267-1-git-send-email-dsymonds@gmail.com>
X-Mailer: Apple Mail (2.929.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99361>

El 29/10/2008, a las 1:44, David Symonds escribi=F3:

> +SCRIPT_SH +=3D git-staged.sh

Isn't this exactly what aliases are for?
   git config --global alias.staged "diff --cached"
(Rather than adding yet another command...)

Wincent
