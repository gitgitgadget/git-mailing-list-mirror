From: Pavel Roskin <proski@gnu.org>
Subject: Re: git 1.5.1-rc1 doesn't like empty files
Date: Tue, 20 Mar 2007 01:47:56 -0400
Message-ID: <1174369676.8210.5.camel@dv>
References: <1174361424.3143.42.camel@dv>
	 <7vslc0bhz7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 20 06:48:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTXCe-0007h5-P8
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 06:48:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbXCTFsJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Mar 2007 01:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbXCTFsJ
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Mar 2007 01:48:09 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:60810 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751208AbXCTFsI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2007 01:48:08 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1HTXAc-0001H4-OO
	for git@vger.kernel.org; Tue, 20 Mar 2007 01:46:07 -0400
Received: from proski by gnu.org with local (Exim 4.66)
	(envelope-from <proski@gnu.org>)
	id 1HTXCO-0006yZ-Cl; Tue, 20 Mar 2007 01:47:56 -0400
In-Reply-To: <7vslc0bhz7.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.10.0 (2.10.0-2.fc7) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42715>

On Mon, 2007-03-19 at 22:29 -0700, Junio C Hamano wrote:
>             if (status < 0)
>                     error("corrupt loose object '%s'",
> sha1_to_hex(sha1));
>             else if (stream->avail_in)
>                     error("garbage at end of loose object '%s'",
>                           sha1_to_hex(sha1));
>             free(buf);
>             return NULL;
>     }
> 
> Can you check what the value of the status is at that point?

status is 0 (Z_OK), stream->avail_in is 8.  I changed the code to print
them from the error() that prints "garbage at end of loose object".

-- 
Regards,
Pavel Roskin
