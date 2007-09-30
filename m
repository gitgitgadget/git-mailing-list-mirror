From: Bruno Haible <bruno@clisp.org>
Subject: Re: GIT_EXTERNAL_DIFF invoked with undocumented calling convention after unstashing conflicts
Date: Sun, 30 Sep 2007 23:25:56 +0200
Message-ID: <200709302325.56235.bruno@clisp.org>
References: <200709302117.37422.bruno@clisp.org> <7vk5q7hqld.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 30 23:26:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ic6Ib-000615-Ux
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 23:26:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752238AbXI3VZ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2007 17:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752322AbXI3VZz
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Sep 2007 17:25:55 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:58861 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752892AbXI3VZz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2007 17:25:55 -0400
Received: from linuix.haible.de ([81.210.217.73])
	by post.webmailer.de (fruni mo56) (RZmta 13.2)
	with ESMTP id 506dabj8UGU9yN ; Sun, 30 Sep 2007 23:25:52 +0200 (MEST)
	(envelope-from: <bruno@clisp.org>)
User-Agent: KMail/1.5.4
In-Reply-To: <7vk5q7hqld.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
X-RZG-AUTH: gMysVb8JT2gB+rFDu0PuvnPihAP8oFdePhw95HsN8T+WAEY7QaSDm1JE
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59568>

Junio C Hamano wrote:
> The script needs to decide how it wants to present an unmerged
> path; the information on each unmerged stages can be read from
> the output of "ls-files -u $thatpath".

Thanks for this info. This, and "git cat-file", did the trick.

Bruno
