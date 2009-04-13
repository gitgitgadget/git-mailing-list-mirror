From: E R <pc88mxer@gmail.com>
Subject: help with git query
Date: Mon, 13 Apr 2009 13:51:25 -0500
Message-ID: <3a69fa7c0904131151p35945ed3y58cba069bd801337@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 13 20:53:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtRHD-0002bt-6u
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 20:53:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbZDMSv1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 14:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbZDMSv1
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 14:51:27 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:43099 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713AbZDMSv0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 14:51:26 -0400
Received: by qyk16 with SMTP id 16so4460541qyk.33
        for <git@vger.kernel.org>; Mon, 13 Apr 2009 11:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=0r/sj/qq0LN8Sai7Z1o+8e03Jw+tXuH//8jFBo88Cfs=;
        b=Fa7UVXjmBk8qbO8WVtg0IlElfmvrozVuwdrPr4a4pwynSKb5t+NEE+KqPLwXy7Q9r9
         ZZQQ/F4nmJ+QSUslYbTQUThcOe1nWI5R0JAFLCCaa5PYgGvY0/q7dW/6uIjDEbJaOmkj
         UyQgdI20XSbFvxG+AtZXv3/5wEUlWKck2f2ks=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=BVAJ9i9qj7omzAmrT4dcgmikNlCzamS8SALcALLrOVY6532S8jLImBcy7odbtx6t1o
         RcN824YHtmkt1X5LG2Atbiyz1weE3JluEHu6ceIoYnO/orxypgqpz36GnKjpaUmIRBwz
         IAJ10XN7mm060hDJRWzBg6vphH4a0Om6bLKcY=
Received: by 10.220.77.1 with SMTP id e1mr6715006vck.91.1239648685114; Mon, 13 
	Apr 2009 11:51:25 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116476>

Hi,

I'd like to generate the following report from git:

for each branch:
  - info about the latest commit on that branch (date and time, message, etc.)
  - info about the last time it was merged into master

What commands can I run to figure this out? I think I can figure out
the first one - it's the second one I'm having trouble with.

And if it would easier to do it from the C API (or something like the
perl Git::PurePerl module) I'd be interested in knowing that, too.

Thanks,
ER
