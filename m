From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Worktree vs. working copy
Date: Tue, 20 Sep 2011 20:48:58 +1000
Message-ID: <CACsJy8AtO3EhgscLVjmqzyRAo+Q=d7ABg0VaJ4N7oqCpmKVzuA@mail.gmail.com>
References: <1316505022.13996.12.camel@bee.lab.cmartin.tk> <4E786D7A.8020503@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Sep 20 12:49:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5xtR-0008DF-2w
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 12:49:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755578Ab1ITKtb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Sep 2011 06:49:31 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:50275 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409Ab1ITKt3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Sep 2011 06:49:29 -0400
Received: by bkbzt4 with SMTP id zt4so338503bkb.19
        for <git@vger.kernel.org>; Tue, 20 Sep 2011 03:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=rp5Zppca3umgKVQ/LDh38DvpJJeI2luymD5K849lsMw=;
        b=dE3oEpblwK2c+rTaaCyqcpFN5GvVw/jCe4cTybTnwI3j1/9f09WI2RaYAbJ8wGxa9C
         dpr9L5JNc5SAS47f+3Pq2xzH6R8hLSdthH5B/ZoF5JiFjMSVVq9UFqLSL346JrGO0UGZ
         pQM82xiQPqyV7N+Nty7vls3n6ZNZBDK0yVxrw=
Received: by 10.204.133.8 with SMTP id d8mr456922bkt.235.1316515768375; Tue,
 20 Sep 2011 03:49:28 -0700 (PDT)
Received: by 10.204.7.1 with HTTP; Tue, 20 Sep 2011 03:48:58 -0700 (PDT)
In-Reply-To: <4E786D7A.8020503@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181753>

On Tue, Sep 20, 2011 at 8:39 PM, Michael Haggerty <mhagger@alum.mit.edu=
> wrote:
> On 09/20/2011 09:50 AM, Carlos Mart=C3=ADn Nieto wrote:
>> I've noticed that in some places in git.git, the term 'working copy'=
 is
>> used. Mostly it's in git-cvsserver which I guess it's fine, but the
>> git-config man page talks about the 'working copy' in three places.
>>
>> =C2=A0 =C2=A0 $ git grep 'worktree' | wc -l
>> =C2=A0 =C2=A0 412
>> =C2=A0 =C2=A0 $ git grep 'working copy' | grep -v ^git-cvsserver | =C2=
=A0wc -l
>> =C2=A0 =C2=A0 32
>
> Please note that the string "worktree" mostly appears in code
> (presumably as variable names) and in the names of options. =C2=A0In =
text,
> "working tree" is far more common..

And probably the oldest. It was mentioned in the first version of git
glossary back in 2005, da13981, [PATCH] Add GIT glossary.
--=20
Duy
