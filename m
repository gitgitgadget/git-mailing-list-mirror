From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [ANNOUNCE] tig-1.0
Date: Sat, 15 Sep 2012 20:32:03 -0400
Message-ID: <CAFuPQ1+6EkeVDmkQg-r0_KegDDmC0QnO4mtn0ad=4UK8G=9iCA@mail.gmail.com>
References: <20120510134449.GA31836@diku.dk> <CAK6bCaz7yPR0QmcOwY0iUP0hyisTf-bz=c0G_1nZkjCLDWDR+A@mail.gmail.com>
 <CAFuPQ1+22erJZ11fm1381-RPs0rKZr=EZJgZWQ1Jp00r6Wc8HA@mail.gmail.com> <CAK6bCawaqEvKFf43wzv+Yz5eem5W-qi9p1i+-9+jiMFs=tZ8xA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jean-Baptiste Quenot <jbq@caraldi.com>
X-From: git-owner@vger.kernel.org Sun Sep 16 02:32:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TD2mo-0001mj-2d
	for gcvg-git-2@plane.gmane.org; Sun, 16 Sep 2012 02:32:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752960Ab2IPAcZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2012 20:32:25 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:47112 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752330Ab2IPAcY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2012 20:32:24 -0400
Received: by qaas11 with SMTP id s11so770523qaa.19
        for <git@vger.kernel.org>; Sat, 15 Sep 2012 17:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=eI1+PVovnwiSqORhsGxTFkX3Tr5OwfU/ERFFLTaQrRc=;
        b=a0lY0/QJkhSWPx8bhXnthHPsNDkOIleFwtvf2N4NXDZ7q+U3JVJJI9P1otbL4mZ4qp
         6RQX/u7MKCTQcB52npwYgd52/iTAUvQccZbf58xUdOYY9UXiTOp8IQWvaZ7RTQsR1oxu
         X7ZtQMy85OcvxmPLyo4UMOxPatQ8wop2hdKLtFl88+g6wj8InhzpbAZDQJTAjK1xDAzB
         Lnp84t71PwdMsTbW1uXKgmN1+sj1FrUACFyB6YXSVfrVnBSrF1RH3zvrhjdJy/Sr2Uhc
         GPp9XCpHZpyZB1YOujGAVpKWkTtFaxTXAKDdd8Q9ET3aH1EPUOBeTq+sVKe2D282Xxqg
         cWuQ==
Received: by 10.229.135.213 with SMTP id o21mr4548313qct.59.1347755543738;
 Sat, 15 Sep 2012 17:32:23 -0700 (PDT)
Received: by 10.49.119.73 with HTTP; Sat, 15 Sep 2012 17:32:03 -0700 (PDT)
In-Reply-To: <CAK6bCawaqEvKFf43wzv+Yz5eem5W-qi9p1i+-9+jiMFs=tZ8xA@mail.gmail.com>
X-Google-Sender-Auth: Pr40jRvkASHPLQOPIF10gQ1CgNM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205588>

On Tue, Sep 11, 2012 at 3:24 PM, Jean-Baptiste Quenot <jbq@caraldi.com> wrote:
> 2012/9/7 Jonas Fonseca <fonseca@diku.dk>:
>> [snip] I suggest to support something like the following:
>>
>>     tig --no-walk --stdin < tmp-file
>>
>> Would that cover your use case?
>
> That would be great!  I would then feed tig with all commits I want to
> see in the main view.

When you have time, please test the main-view-with-stdin branch in
git://github.com/jonas/tig.git

-- 
Jonas Fonseca
