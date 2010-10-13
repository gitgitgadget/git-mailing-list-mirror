From: Marat Radchenko <marat@slonopotamus.org>
Subject: [FEATURE REQUEST] allow enabling patience diff algorithm by default
Date: Wed, 13 Oct 2010 00:56:53 -0700 (PDT)
Message-ID: <1286956613749-5629926.post@n2.nabble.com>
References: <loom.20100713T082913-327@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 13 09:57:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5wCp-00084d-Tu
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 09:57:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753157Ab0JMH4z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 03:56:55 -0400
Received: from kuber.nabble.com ([216.139.236.158]:55830 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753032Ab0JMH4y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 03:56:54 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <marat@slonopotamus.org>)
	id 1P5wCj-0000hB-OU
	for git@vger.kernel.org; Wed, 13 Oct 2010 00:56:53 -0700
In-Reply-To: <loom.20100713T082913-327@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158910>


I observe patience algorithm being several times faster than standard diff on
some big (1MB<size<10MB) text files (and, actually, it produces smaller
diffs). So using patience diff is likely to improve git-rev-list
performance.

Suggested way: add option to ~/.gitconfig to enable patience diff by
default. Additionally, smth like--no-patience may be added to commands that
accept --patience now so it is possible to override setting if needed.

-- 
View this message in context: http://git.661346.n2.nabble.com/VERY-slow-git-format-patch-tens-on-minutes-during-rebase-and-rev-list-during-rebase-i-tp5286226p5629926.html
Sent from the git mailing list archive at Nabble.com.
