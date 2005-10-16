From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: [kernel.org users] Re: auto-packing on kernel.org? please?
Date: Sun, 16 Oct 2005 14:33:41 -0700
Message-ID: <20051016213341.GF5509@reactrix.com>
References: <Pine.LNX.4.64.0510131113490.15297@g5.osdl.org> <434EABFD.5070604@zytor.com> <434EC07C.30505@pobox.com> <Pine.LNX.4.64.0510131422161.23590@g5.osdl.org> <435264B1.2010204@de.bosch.com> <Pine.LNX.4.63.0510161122570.23242@iabervon.org> <20051016161244.GE5509@reactrix.com> <43527E86.8000907@didntduck.org> <7vzmp9xuwe.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 16 23:35:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ERG93-0008Al-Rk
	for gcvg-git@gmane.org; Sun, 16 Oct 2005 23:34:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbVJPVdu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Oct 2005 17:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbVJPVdu
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Oct 2005 17:33:50 -0400
Received: from 194.37.26.69.virtela.com ([69.26.37.194]:58361 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1751228AbVJPVdt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Oct 2005 17:33:49 -0400
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id j9GLXfvZ013423;
	Sun, 16 Oct 2005 14:33:41 -0700
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id j9GLXfXQ013421;
	Sun, 16 Oct 2005 14:33:41 -0700
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vzmp9xuwe.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10171>

On Sun, Oct 16, 2005 at 09:56:49AM -0700, Junio C Hamano wrote:

> That's what the .idx file is for, except that after you fetch
> the range, you may find you would need something else that the
> object is delta against.

Would it make sense to load the pack indexes for each base up front,
and then fetch individual objects from a pack if they exist in one of
a base's pack indexes?  In such a case, it may not even make sense to
try fetching the object directly first.

What are the circumstances under which it makes more sense to fetch the
whole pack rather than fetching individual objects from it?

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
