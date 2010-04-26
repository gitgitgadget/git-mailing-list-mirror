From: Eugene Sajine <euguess@gmail.com>
Subject: "git log -- SHA-1" - how to get/simulate this functionality?
Date: Mon, 26 Apr 2010 13:54:25 -0400
Message-ID: <i2o76c5b8581004261054h591c266fre1a0dd87cd8511e1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eugene Sajine <euguess@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 26 20:00:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6Sbo-0006Ss-3r
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 20:00:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753917Ab0DZSA1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Apr 2010 14:00:27 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:65009 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753664Ab0DZSAX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Apr 2010 14:00:23 -0400
Received: by qyk9 with SMTP id 9so17748910qyk.1
        for <git@vger.kernel.org>; Mon, 26 Apr 2010 11:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:cc:content-type;
        bh=fQkNRZEhthJIzVK0NZvNzAOrqqHdtb0Pgx4fPolVTnI=;
        b=QnQFp4R6YF0nm5OpLp/sewOe0rcJplyTUXIN7IWK1XpxvxlkLmskrvwBubskGDHz/g
         eYqX+kbbYVPXk/nvbnRCCEov5aCdet4dvykQk9Q/DODbbDxG5Sfi4zD6+mbu4fgc+O9J
         ZseqOwAU+/lVnRZIBm7ZQEoBmIHelkVXKDUnk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=Cb9Eq4vBuTXix5+Nd/uwUbq3g4xUnYEbpEGboJf1WA/RcHBBZbgbcdzFzDVVo5Ygo4
         IrR+Kpi+YIltaOAePfotT72cItaVejkv72I+9sp1erFvmHKFxZi39ZxkZwyXSxxycZJX
         c7tNDuRnw3LnUdoFrzOngy7Gx92kzVGlFAzQg=
Received: by 10.229.192.68 with SMTP id dp4mr5459760qcb.36.1272304465181; Mon, 
	26 Apr 2010 10:54:25 -0700 (PDT)
Received: by 10.229.190.202 with HTTP; Mon, 26 Apr 2010 10:54:25 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145835>

Hi,

I'm wondering if there is a way to get some repo information if the
only thing i know is SHA-1 (no full path to the file)
The current way seems to be a bit cumbersome

git log --no-abbrev --raw --all | grep SHA-1

parse for path(s) and then git log -- path...

I would want something like git log -- SHA-1

Any ideas?

Thanks,
Eugene
