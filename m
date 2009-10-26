From: Eugene Sajine <euguess@gmail.com>
Subject: git push interface inconsistency
Date: Mon, 26 Oct 2009 18:25:07 -0400
Message-ID: <76c5b8580910261525y5397b54eyf9c3d58c0fe19fce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eugene Sajine <euguess@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 26 23:25:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2Y04-0005Ku-Lw
	for gcvg-git-2@lo.gmane.org; Mon, 26 Oct 2009 23:25:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753946AbZJZWZE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2009 18:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753452AbZJZWZE
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Oct 2009 18:25:04 -0400
Received: from mail-yx0-f187.google.com ([209.85.210.187]:60802 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753356AbZJZWZC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2009 18:25:02 -0400
Received: by yxe17 with SMTP id 17so10235209yxe.33
        for <git@vger.kernel.org>; Mon, 26 Oct 2009 15:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type;
        bh=EmACw5AX7cnf2lJnQI+12T2DYSTWGluMlnvwRNmOHX8=;
        b=M20GD5SkCRVmRY8Y9lN+/AHAHdMt7Ifyrlk1ho/6cYvXTFcKSoAjNz7U2Y8a99nibF
         zkMpcR0bUB7v8hHHtQPPus8zpk4LH51PAZfoI/imoS9ZWRiiqvShN4xXKPpB+P8915+i
         eaIXYigMaF13yBRbGq/2LDuwtCJ4bifIQV2Jo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=kDuAcfLyiVSW7KGPljHukKayHYK5XvBqcnsTBe2X707uzb6H1aUDVsJki9ZPQRSvdC
         sz5hCl6H3QnuVZiHBV5hMskCuJeO4YsiPu2zopLfvchDFlvzJGpUW0yg9Ql/AmQe5b8i
         DMuVU89fHYLfPlYObPC9TpILr3JQEk8QwGHdg=
Received: by 10.91.192.14 with SMTP id u14mr860970agp.2.1256595907697; Mon, 26 
	Oct 2009 15:25:07 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131280>

Hi,

I have a question:

Why I can't do

$ git push my_tag

It will fail because the remote is not specified, even if there is
only one origin remote

but can do

$ git push --tags

and it will push tags to origin...

Thanks,
Eugene
