From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: StGit and charsets
Date: Mon, 4 Aug 2008 10:21:20 -0400
Message-ID: <9e4733910808040721n6c47908o9d8fabd8f16293c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>,
	"=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Mon Aug 04 16:22:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQ0x8-0004pv-86
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 16:22:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753785AbYHDOVW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 10:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752998AbYHDOVW
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 10:21:22 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:13276 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750751AbYHDOVV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 10:21:21 -0400
Received: by yx-out-2324.google.com with SMTP id 8so144306yxm.1
        for <git@vger.kernel.org>; Mon, 04 Aug 2008 07:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=HTFARHT6uKARL1Z6jxY2hq1lPiKpbbI79uVBOQXDhXM=;
        b=kOJpVqsJDB7Lk45mgGllUtwZbkPAabjN9b3pc0sKVQHQXZP6j5f4sYPBbdsIvqXn/q
         dyipn04A27SXKVT80ukYEQRnDY16yO8DZtE0y0ZqVxzmIP7uccm8M5ya8WBIHudC+xEF
         C7zchYv6F02Oh2Z/KVOfIha8vezxckDY4Awtc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=KAmf3gd+jZwSdjSpdWAamjEb0hSk9zTwqbV6VWQ52i97y4V8/Oquz1g5B9HfDFrwAS
         /LKxyiMFZJWwMojJBaewHr/sh9jQfOMMrZiua+zbqE+KK6scy4dcoIw2eEQJ7lEMqTvQ
         M8StajjZtsnjkKYHxHDt2oafxyf/wZhnc/sAw=
Received: by 10.151.112.14 with SMTP id p14mr1401994ybm.227.1217859680389;
        Mon, 04 Aug 2008 07:21:20 -0700 (PDT)
Received: by 10.65.214.7 with HTTP; Mon, 4 Aug 2008 07:21:20 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91360>

Do you have tests in place to handle the names and comments in patches
being in different charsets? When I was working with the mailmap file
a large source of errors was from mangling names in alternate
charsets. I recall errors in Finnish, Japanese and Chinese names for
sure. I don't know which tools did the charset mangling.

I don't work much with international charsets. If someone is using
something like Russian or Finish locally, is the metadata in the patch
converted to UTF8 before exporting or sending it as mail? Comments
should be in English, but people's names may need UTF8. And what about
email addresses, does DNS allow Unicode names now?

-- 
Jon Smirl
jonsmirl@gmail.com
