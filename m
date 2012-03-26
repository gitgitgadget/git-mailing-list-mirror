From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Please pull gitk update
Date: Mon, 26 Mar 2012 16:16:30 -0700
Message-ID: <7vsjgvkl69.fsf@alter.siamese.dyndns.org>
References: <20120324055540.GA20898@bloggs.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Mar 27 01:16:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCJ9X-0006bo-7L
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 01:16:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753215Ab2CZXQe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 19:16:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51846 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751956Ab2CZXQd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 19:16:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A81B8722B;
	Mon, 26 Mar 2012 19:16:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=ROyZ9J3m6DlX7mRQNrsyGgFdnTQ=; b=JXmLUGYxfKYnI65WR8Yw
	s8is4Ol6agJNXUKR1QAVRrwwueJV7bgPw1ydlBXzTByctpaxWEzyJbmENYPsLNWv
	DGucMGmgaGVnXhux9hr1WsRCvjvJ6blcRHW1obDPQlqWbqyO6WdrKOJL6KaADsHC
	nXOyDCw+WdF5XHuGzG4nJNk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=X6kGHDSq8fK1utVsrjfKjEHBaHJ4K4R+asktLEZ+vc61FT
	7U9KhWchIgJPDFik9H7xaVHXcJu6cagO4UqTUg1/KUYW+eD3/KrDD2lObO4pdoyB
	7243o7i7rnST4meuJMftXsc55o2ebyLyvCJ17gB55YaJphpAGo+uZByhX1mA8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F7B1722A;
	Mon, 26 Mar 2012 19:16:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3706F7229; Mon, 26 Mar 2012
 19:16:32 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B96B8EE4-7799-11E1-886E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193986>

Here is what I came up with after looking at the result of this pull.
Could you eyeball it?

Thanks.

diff --git a/Documentation/RelNotes/1.7.10.txt b/Documentation/RelNotes/1.7.10.txt
index 11b0b10..e1f493c 100644
--- a/Documentation/RelNotes/1.7.10.txt
+++ b/Documentation/RelNotes/1.7.10.txt
@@ -46,6 +46,14 @@ Updates since v1.7.9
 UI, Workflows & Features
 
  * various "gitk" updates.
+   - show the path to the top level directory in the window title
+   - update preference edit dialog
+   - pathspecs like "gitk -- .", "gitk -- ..\t" did not work well
+   - make "git-describe" output in the log message into a clickable link
+   - avoid matching the UNIX timestamp part when searching all fields
+   - give preference to symboic font names like sans & monospace
+   - allow comparing two commits using a mark
+   - "gitk" honors log.showroot configuration.
 
  * Teams for localizing the messages from the Porcelain layer of
    commands are starting to form, thanks to Jiang Xin who volunteered
