From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: git gc logs to standard error
Date: Mon, 14 Dec 2009 08:28:27 -0800
Message-ID: <8c9a060912140828p3b05972lf9abc82c7b0f9bc1@mail.gmail.com>
References: <4B264F7B.8070504@inf.utfsm.cl> <200912141655.01268.johan@herland.net> 
	<8c9a060912140804t409030b4g168014bd80a0b88c@mail.gmail.com> 
	<4B26669A.8020806@inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Richard Rossel <rrossel@inf.utfsm.cl>
X-From: git-owner@vger.kernel.org Mon Dec 14 17:28:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKDn3-0000bO-MD
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 17:28:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757818AbZLNQ2t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Dec 2009 11:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757794AbZLNQ2s
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 11:28:48 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:61077 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755907AbZLNQ2s convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Dec 2009 11:28:48 -0500
Received: by pwj9 with SMTP id 9so2014498pwj.21
        for <git@vger.kernel.org>; Mon, 14 Dec 2009 08:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=/c8fi4BSpq/Rwj5FdaHNNhWTW6XhsLIMYOqigkp/awM=;
        b=ol7FJugA/i5nyHQMlplSrV/YWQ1SSCAQURL2yqqbQ0vzBCrmgrsLBsHiETUJAd1A5D
         kpt2ZzQxLMiyOIgSzhEr6AQHtXkmHTYwa/qivtHaUGzT3qVOgutu4XKWdSqTRpGJ8iJH
         p3ysoVV7lV7i2uZ0bghss8ZJRAn+xGbubijyY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=DHiCbkyOfjBPaMSlxObtEF/HprSVkE2pWOKlCOFkpF2dZUcEVN+V/+7cfvCrVx+Raz
         kXp5ixcF38tYqKg3lqeXC7067P4Q7Z9k1MQQDhsXDOUx4GHjh2AFq/7zpxrMCSjB3ZY/
         c2X1LlxJj++8Om1UXKY7803yDWRBrTeckFc6k=
Received: by 10.140.82.42 with SMTP id f42mr3429171rvb.40.1260808127048; Mon, 
	14 Dec 2009 08:28:47 -0800 (PST)
In-Reply-To: <4B26669A.8020806@inf.utfsm.cl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135225>

On Mon, Dec 14, 2009 at 08:23, Richard Rossel <rrossel@inf.utfsm.cl> wr=
ote:
>
> $ git --version
> git version 1.5.4.3
>
> And when there is no change in the repo
>
> $ git fetch --q; echo $?
> 0
>
> no messages and no error , but when there is a change to syncronize
>
> $ git fetch --q; echo $?
> remote: Counting objects: 7, done.
> remote: Compressing objects: 100% (5/5), done.
> remote: Total 5 (delta remote: 2), reused 0 (delta 0)
> Unpacking objects: 100% (5/5), done.
> From git@boss:sandbox
> =C2=A0 3e4df7f..b92d27c =C2=A0master =C2=A0 =C2=A0 -> origin/master
> 0
>

Don't use a double dash, if you're using the short option.

git fetch -q
OR
git fetch --quiet

git fetch --q <--- This is not what you think it is.

-Jacob
