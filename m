From: perryh@pluto.rain.com
Subject: Re: [PATCH] git-jump: ignore (custom) prefix in diff mode
Date: Sun, 16 Sep 2012 23:03:23 -0700
Message-ID: <50571f9b.2XSlVe/YBL63thko%perryh@pluto.rain.com>
References: <1347844915-4130-1-git-send-email-git@shiar.nl>
 <20120917030143.GA19986@pearl.mediadesign.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: peff@peff.net, git@vger.kernel.org
To: git@shiar.nl
X-From: git-owner@vger.kernel.org Mon Sep 17 08:49:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDV8q-0006SG-VU
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 08:49:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752045Ab2IQGtE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 02:49:04 -0400
Received: from agora.rdrop.com ([199.26.172.34]:2106 "EHLO agora.rdrop.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751856Ab2IQGtD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 02:49:03 -0400
X-Greylist: delayed 2002 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Sep 2012 02:49:03 EDT
Received: from agora.rdrop.com (66@localhost [127.0.0.1])
	by agora.rdrop.com (8.13.1/8.12.7) with ESMTP id q8H6F88w002035
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 16 Sep 2012 23:15:08 -0700 (PDT)
	(envelope-from perryh@pluto.rain.com)
Received: (from uucp@localhost)
	by agora.rdrop.com (8.13.1/8.14.2/Submit) with UUCP id q8H6F83N002034;
	Sun, 16 Sep 2012 23:15:08 -0700 (PDT)
	(envelope-from perryh@pluto.rain.com)
Received: from fbsd81 ([192.168.200.81]) by pluto.rain.com (4.1/SMI-4.1-pluto-M2060407)
	id AA04328; Sun, 16 Sep 12 23:03:45 PDT
In-Reply-To: <20120917030143.GA19986@pearl.mediadesign.nl>
User-Agent: nail 11.25 7/29/05
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205657>

Mischa POSLAWSKY <git@shiar.nl> wrote:

> ... I would argue against diff options creating non-standard patches.

Seems to me it might depend on what one means by "non-standard".

I can envision cases in which increasing the number of context lines
would result in the patch being more robust WRT applying correctly
to a recipient's version that might be a bit different than the one
against which it was created.

OTOH one most likely does not want to create a patch with -b unless
the apply tool also supports such and there is a way to communicate
to the apply tool that -b was used in creating the patch.
