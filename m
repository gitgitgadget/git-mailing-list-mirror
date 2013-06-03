From: Eugene Sajine <euguess@gmail.com>
Subject: Re: git daemon --access-hook problem
Date: Mon, 3 Jun 2013 14:02:56 -0400
Message-ID: <CAPZPVFYdeuusW3=iBTBC+iPuOeAekvtMx6d_dozB9tsDCg3C8Q@mail.gmail.com>
References: <CAPZPVFZDHHGyHhzBVVK6jS=XhEd2+JpmBT8ofiGOww8vuLUWWw@mail.gmail.com>
	<CALWbr2ypPCoftVLfP9uKeKStg3TWwLDchkUaL1d9s9O3kcuPwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 20:03:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjZ5x-0007Co-8y
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 20:03:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757107Ab3FCSC6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 14:02:58 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:53948 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753430Ab3FCSC5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 14:02:57 -0400
Received: by mail-ie0-f176.google.com with SMTP id at20so11157740iec.35
        for <git@vger.kernel.org>; Mon, 03 Jun 2013 11:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=EF67g+kJbE6kr/raiNrSjCN6ENTguodwVNcHGC4Y8ug=;
        b=jSmvGYiQ9iC3NMbMm3xxK+/7F8JqLmPr+RZ1F2KRugdoXlTSCggiuk+F13z8cWX+M3
         AjFX4k/DQjOp+d6VEMWXInqprXVv6OTzmxomvTFT7BnovFXnargIpEDKZFuBDsM+rzNp
         QeNj6kxw5NwJcadvO/NfA2ZK2GcreF/9cuwxkfTrIv19UDN43H8OW3gF2LSDxByG3pT0
         qgw4Pxm/GjrOtudQ3wd88/oBilcTr8D9cnFiBEdYJekcuOeBAFbbzUTVzMXOMTJcxOLX
         5ZnWocXl8lq8k2LISJaVn33FXs4kyg/VWXLIBav6zMfaDWeXjiLVO2vvYIcNn1/yqj0H
         H3VQ==
X-Received: by 10.50.92.70 with SMTP id ck6mr8833443igb.76.1370282576603; Mon,
 03 Jun 2013 11:02:56 -0700 (PDT)
Received: by 10.43.85.7 with HTTP; Mon, 3 Jun 2013 11:02:56 -0700 (PDT)
In-Reply-To: <CALWbr2ypPCoftVLfP9uKeKStg3TWwLDchkUaL1d9s9O3kcuPwA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226254>

> - Your log file might not be located where you expect, you should use
> absolute path to dump text

You were right! The problem was with the script itself - the log file
not being specified with absolute path! Stupid me!

...
> - The documentation says you can print one line before a failure, also
> try this to show the cwd

Would you be able to advise how this should be done?
I don't get the error message (i mean the output of pwd) if i do this:

echo `pwd`
exit 1

What should it be?

Thanks!
Eugene



>
> Hope that helps,
> Antoine,
