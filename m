From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] git-submodule: allow submodule name and path to differ
Date: Sat, 09 Jun 2007 17:27:20 -0700
Message-ID: <7vbqfod57b.fsf@assigned-by-dhcp.cox.net>
References: <1181425132239-git-send-email-hjemli@gmail.com>
	<1181425132294-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sven Verdoolaege <skimo@kotnet.org>, git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 10 02:27:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxBH9-0005ce-PH
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 02:27:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759173AbXFJA1W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 20:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759158AbXFJA1W
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 20:27:22 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:59423 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759133AbXFJA1V (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 20:27:21 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070610002721.UQXJ12207.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Sat, 9 Jun 2007 20:27:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 9cTL1X0071kojtg0000000; Sat, 09 Jun 2007 20:27:21 -0400
In-Reply-To: <1181425132294-git-send-email-hjemli@gmail.com> (Lars Hjemli's
	message of "Sat, 9 Jun 2007 23:38:50 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49643>

Lars Hjemli <hjemli@gmail.com> writes:

> This teaches git-submodule to check module.*.path when looking for the
> config for a submodule path. If no match is found it falls back to the
> current behaviour (module.$path).

I have a feeling that it might be much less troublesome in the
longer term to admit that module.$path was a mistake and support
only one format; wouldn't trying to support both leave ambiguity
and confusion?
