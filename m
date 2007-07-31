From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] Make builtin-commit-tree use a strbuf instead of hand-rolled realloc buffer.
Date: Mon, 30 Jul 2007 21:39:45 -0700
Message-ID: <7vd4y9gp9q.fsf@assigned-by-dhcp.cox.net>
References: <11858309261111-git-send-email-krh@redhat.com>
	<11858309311728-git-send-email-krh@redhat.com>
	<11858309322006-git-send-email-krh@redhat.com>
	<11858309322915-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Tue Jul 31 06:40:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFjWt-00086A-KV
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 06:40:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S941229AbXGaEju (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jul 2007 00:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S941218AbXGaEjt
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 00:39:49 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:42779 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S941212AbXGaEjs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2007 00:39:48 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070731043947.KICS14885.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Tue, 31 Jul 2007 00:39:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id W4fm1X00E1kojtg0000000; Tue, 31 Jul 2007 00:39:46 -0400
In-Reply-To: <11858309322915-git-send-email-krh@redhat.com> (Kristian
	=?utf-8?Q?H=C3=B8gsberg's?= message of "Mon, 30 Jul 2007 17:28:45 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54321>

Very nice.
