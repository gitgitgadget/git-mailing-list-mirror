From: Bill Lear <rael@zopyra.com>
Subject: Re: [PATCH 1/2] Function stripspace now gets a buffer instead file descriptors.
Date: Wed, 11 Jul 2007 18:20:13 -0500
Message-ID: <18069.26029.224024.66576@lisa.zopyra.com>
References: <4695267A.7080202@gmail.com>
	<7vd4yy1svw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Carlos Rica <jasampler@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 12 01:20:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8lUL-0004IK-Iu
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 01:20:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934805AbXGKXUa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 19:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765740AbXGKXU3
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 19:20:29 -0400
Received: from mail.zopyra.com ([65.68.225.25]:61560 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934797AbXGKXU1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 19:20:27 -0400
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l6BNKDE13804;
	Wed, 11 Jul 2007 18:20:13 -0500
In-Reply-To: <7vd4yy1svw.fsf@assigned-by-dhcp.cox.net>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52222>

On Wednesday, July 11, 2007 at 15:24:03 (-0700) Junio C Hamano writes:
>Carlos Rica <jasampler@gmail.com> writes:
>...
>> + * Returns the length of a line removing trailing spaces.
>
>This did not parse well for me; perhaps a comma before
>"removing" would make it easier to read?

Or:

Returns the length of a line, after removing trailing spaces.


Bill
