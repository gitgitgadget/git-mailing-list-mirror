From: jidanni@jidanni.org
Subject: Re: [PATCH/RFC] Documentation/git-mailsplit.txt: Emphasize -o more
Date: Tue, 13 Jan 2009 06:55:30 +0800
Message-ID: <87prisi17h.fsf@jidanni.org>
References: <7vhc44gowr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jan 12 23:56:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMViM-00009W-FJ
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 23:56:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757675AbZALWzh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 17:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762505AbZALWzf
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 17:55:35 -0500
Received: from sd-green-bigip-81.dreamhost.com ([208.97.132.81]:46882 "EHLO
	homiemail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1760349AbZALWze (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Jan 2009 17:55:34 -0500
Received: from jidanni.org (122-127-34-152.dynamic.hinet.net [122.127.34.152])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a1.g.dreamhost.com (Postfix) with ESMTP id 374E0119DD4;
	Mon, 12 Jan 2009 14:55:33 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105410>

All I know is the user had better not forget -o<directory> or else his
precious mailbox will be interpreted as something else... Actually the
problem is with builtin-mailsplit.c,
$ git mailsplit -o
fatal: unknown option: -o
One big tangle. So I would just say
+	certain backward compatibility mode (that we won't detail here).
