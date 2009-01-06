From: jidanni@jidanni.org
Subject: git rebase --interactive needn't call editor for noop
Date: Tue, 06 Jan 2009 11:17:49 +0800
Message-ID: <87bpulnmw2.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 06 04:19:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LK2TL-0001qK-US
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 04:19:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751903AbZAFDRw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jan 2009 22:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751567AbZAFDRw
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jan 2009 22:17:52 -0500
Received: from sd-green-bigip-74.dreamhost.com ([208.97.132.74]:37037 "EHLO
	homiemail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750836AbZAFDRv (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Jan 2009 22:17:51 -0500
Received: from jidanni.org (122-127-36-59.dynamic.hinet.net [122.127.36.59])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a1.g.dreamhost.com (Postfix) with ESMTP id 39DF5119E3A
	for <git@vger.kernel.org>; Mon,  5 Jan 2009 19:17:51 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104628>

On occasions when git rebase --interactive will invoke the editor with
the word "noop" in the buffer, it would be better if it just said that
on the command line instead of bothering to call the editor.
