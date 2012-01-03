From: Kevin <ikke@ikke.info>
Subject: Re: rebase -i does not use a commit it should
Date: Tue, 3 Jan 2012 15:18:57 +0100
Message-ID: <CAO54GHALdd0_08vjkqbeLLcF3GTa4Jok+C-b0rwTD=akHujcGQ@mail.gmail.com>
References: <CAO54GHB1uwJdjj0=dCVp_M4sAFtqooM9hnBSNurje2n+-dGDEA@mail.gmail.com>
 <CAO54GHAwgbdpdqZw5Pc+jvEyq12DAq4Bio_MbTnmXHsvm-5p8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 03 15:19:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ri5D2-0002en-Va
	for gcvg-git-2@lo.gmane.org; Tue, 03 Jan 2012 15:19:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753508Ab2ACOTU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jan 2012 09:19:20 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:56962 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753158Ab2ACOTT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jan 2012 09:19:19 -0500
Received: by wibhm6 with SMTP id hm6so9116746wib.19
        for <git@vger.kernel.org>; Tue, 03 Jan 2012 06:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:content-type;
        bh=JmB1yYnUPiRywCkuRsXh9PLxKKlUkDCp8mM2UE7rqBk=;
        b=mXJA0a5PzO80s2f8URpALxQUqnC48UjYQinwJ6S1EX9QTUubmgTcBtJhs5BOLoqbai
         7l53h1kVAUyUKsBXVKBO4NEgkj5d4688OdmukWNakZ7zSf6ira2DNctbXAW03S1tdLRs
         MpW6yaWMNlVfzaoNXg5wK+NqHoZYW8BLIOQYg=
Received: by 10.180.81.72 with SMTP id y8mr114396764wix.14.1325600358369; Tue,
 03 Jan 2012 06:19:18 -0800 (PST)
Received: by 10.227.57.84 with HTTP; Tue, 3 Jan 2012 06:18:57 -0800 (PST)
In-Reply-To: <CAO54GHAwgbdpdqZw5Pc+jvEyq12DAq4Bio_MbTnmXHsvm-5p8Q@mail.gmail.com>
X-Google-Sender-Auth: 11dtOgslVUX4i4UMeOhc2gEvN-Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187865>

Ok, problem solved.

The issue was already present in the history of master, and thus it
would not be applied again.

On Tue, Jan 3, 2012 at 3:04 PM, Kevin <ikke@ikke.info> wrote:
> Using git version 1.7.8
