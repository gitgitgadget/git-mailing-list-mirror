From: Jan =?UTF-8?B?S3LDvGdlcg==?= <jk@jk.gs>
Subject: Re: [PATCH] Documentation: mention environment variables
 GIT_CONFIG_NO(GLOBAL|SYSTEM)
Date: Mon, 4 Oct 2010 08:31:06 +0200
Message-ID: <20101004083106.74623cd5@jk.gs>
References: <20101003235329.6f4d2572@jk.gs>
	<7vvd5ieu29.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Git ML <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 08:31:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2eZv-0001km-N7
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 08:31:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752451Ab0JDGbK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 02:31:10 -0400
Received: from zoidberg.org ([88.198.6.61]:38087 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752408Ab0JDGbJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 02:31:09 -0400
Received: from jk.gs ([::ffff:137.120.115.117])
  (AUTH: LOGIN jast, SSL: TLSv1/SSLv3,128bits,AES128-SHA)
  by cthulhu.zoidberg.org with esmtp; Mon, 04 Oct 2010 08:31:09 +0200
  id 004001D2.4CA974AD.000070D3
In-Reply-To: <7vvd5ieu29.fsf@alter.siamese.dyndns.org>
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.20.1; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157982>

--- Junio C Hamano <gitster@pobox.com> wrote:

> Aren't they undocumented because the use case for them is pretty much
> limited to the test scripts and nowhere else?  I am not absolutely
> sure about GIT_CONFIG_NOGLOBAL, but NOSYSTEM surely was started that
> way.

I don't know. I found them when someone on IRC was looking for a way to
bypass an insteadOf setting in his ~/.gitconfig file, so I guess that
there is an actual use case for some.

-Jan
