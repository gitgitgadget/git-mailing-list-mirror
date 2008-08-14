From: Don Zickus <dzickus@redhat.com>
Subject: Re: [PATCH] Allow emails with boundaries to work again
Date: Wed, 13 Aug 2008 20:56:31 -0400
Message-ID: <20080814005631.GC24172@redhat.com>
References: <1218667559-26618-1-git-send-email-dzickus@redhat.com> <7vbpzwjx8d.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 14 02:58:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTRA9-0003iq-W3
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 02:58:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754810AbYHNA46 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 20:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754785AbYHNA46
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 20:56:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59143 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754759AbYHNA46 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 20:56:58 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m7E0uWLQ001963;
	Wed, 13 Aug 2008 20:56:32 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [10.16.255.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m7E0uVod008285;
	Wed, 13 Aug 2008 20:56:31 -0400
Received: from drseuss.usersys.redhat.com (dhcp-100-19-202.bos.redhat.com [10.16.19.202])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m7E0uVQx006499;
	Wed, 13 Aug 2008 20:56:31 -0400
Received: from drseuss.usersys.redhat.com (localhost.localdomain [127.0.0.1])
	by drseuss.usersys.redhat.com (8.14.2/8.14.1) with ESMTP id m7E0uVJ5028469;
	Wed, 13 Aug 2008 20:56:31 -0400
Received: (from dzickus@localhost)
	by drseuss.usersys.redhat.com (8.14.2/8.14.2/Submit) id m7E0uVeX028468;
	Wed, 13 Aug 2008 20:56:31 -0400
X-Authentication-Warning: drseuss.usersys.redhat.com: dzickus set sender to dzickus@redhat.com using -f
Content-Disposition: inline
In-Reply-To: <7vbpzwjx8d.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92301>

On Wed, Aug 13, 2008 at 04:45:06PM -0700, Junio C Hamano wrote:
> Don Zickus <dzickus@redhat.com> writes:
> 
> > Recent changes to is_multipart_boundary() caused git-mailinfo to segfault.
> > The reason was after handling the end of the boundary the code tried to look
> > for another boundary.  Because the boundary list was empty, dereferencing
> > the pointer to the top of the boundary caused the program to go boom.
> 
> We keep fixing and breaking this thing, don't we?  Can we have a testcase
> to protect this codepath?

Heh.  Ok I will try to work on one for tomorrow.

Cheers,
Don
