From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH 3/3] Teach 'diff' about 'nodiff' attribute.
Date: Fri, 13 Apr 2007 13:45:56 +0200
Organization: eudaptics software gmbh
Message-ID: <461F6D74.63EF2769@eudaptics.com>
References: <7vodlsd4wc.fsf@assigned-by-dhcp.cox.net> <461F602C.E9803108@eudaptics.com> <200704131230.41594.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 13 13:45:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcKDw-0003sL-U6
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 13:45:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753476AbXDMLpl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Apr 2007 07:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753413AbXDMLpl
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Apr 2007 07:45:41 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:35680 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753276AbXDMLpk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2007 07:45:40 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtp (Exim 4.44)
	id 1HcKDe-0005FD-WD; Fri, 13 Apr 2007 13:45:38 +0200
Received: from eudaptics.com (unknown [192.168.1.88])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 90B2454D; Fri, 13 Apr 2007 13:45:34 +0200 (CEST)
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
X-Spam-Score: 0.0 (/)
X-Spam-Report: none
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44404>

Andy Parkins wrote:
> I, personally, wouldn't like to say which is correct in that case - or
> in the "nodiff"/"!diff" question.  However, I don't think it's correct
> to universally rule out all double negative use - they have their
> place.

Yet in Junio's introductory message, the example was

        *       crlf !nodiff

and it made me think: huh? And then again: huh?

I don't mind if you call me dumb now, but even an intelligent person
will have to think a second or two about the meaning. That's plainly not
necessary. In particular, where there can be no difference between
"diff" and "!nodiff".

-- Hannes
