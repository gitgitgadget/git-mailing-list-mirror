From: Lynn Lin <lynn.xin.lin@gmail.com>
Subject: Re: how to squash two commits into only one
Date: Tue, 29 Mar 2011 14:04:06 +0800
Message-ID: <AANLkTi=uqCm6cZa1c0VDig8MXKxupZWHdtKW2N36RtoU@mail.gmail.com>
References: <AANLkTi=B37GABBc-YWfJN29Mh0kx4Tn8KenD5dJFo9j1@mail.gmail.com>
	<AANLkTi=PZY2d+NhNnnOyXMX70N31vRg3qS5er+hECy8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Henrik Hautakoski <henrik@fiktivkod.org>
X-From: git-owner@vger.kernel.org Tue Mar 29 08:04:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4S2H-0002re-Hx
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 08:04:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753311Ab1C2GEI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Mar 2011 02:04:08 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:59302 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753201Ab1C2GEH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Mar 2011 02:04:07 -0400
Received: by qwk3 with SMTP id 3so2409679qwk.19
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 23:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=QprilxYw8ze+gJgJ+U7xqMKW0Joc6tS/Gj896zPkh9g=;
        b=PRmt4EPgyNntE7K+WSVuqld1Z+wag6QIA8YpZE8FFW/kJKjQV/DwRDyXad0iZXZdCE
         /oYqkNywzMmIFKbhd+vYXquAQ8V4EEFTXxkHNePTUmoUUVi5gnmFUFvdiNTJwDq8mYDm
         KrPr/YLbjEXCsPFuKQSV73lvy6hxkEatXnx8Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ZzU8rZpN+WWDdcq95rH7beHUu9kd/S0QY3f1j/ZGmbvUBOXe5mx/WrSV/pDpC5qdxp
         YA1iEB4XTNSTgoZg0iRdDCZPiWR9zBUCZthoeYej04UIvJdLAQvZQfLDrXgqNnqYRHgS
         9dd/snj1Azopb4xTqk0SGHBJkPWzhWVJSOjrA=
Received: by 10.229.40.213 with SMTP id l21mr4097818qce.143.1301378646757;
 Mon, 28 Mar 2011 23:04:06 -0700 (PDT)
Received: by 10.229.185.2 with HTTP; Mon, 28 Mar 2011 23:04:06 -0700 (PDT)
In-Reply-To: <AANLkTi=PZY2d+NhNnnOyXMX70N31vRg3qS5er+hECy8A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170224>

On Tue, Mar 29, 2011 at 1:59 PM, Henrik Hautakoski <henrik@fiktivkod.or=
g> wrote:
> You can do a soft reset and amend the changes to the root commit.
> git reset HEAD^1
> (add the files)
> git commit --amend

really good!

Thanks
Lynn

> On Tue, Mar 29, 2011 at 07:42, Lynn Lin <lynn.xin.lin@gmail.com> wrot=
e:
>>
>> All,
>> =A0 I have only have two commits in repo,then I want to squash these
>> two commit into one through git rebase -i .However it fails
>>
>> $ git rebase -i HEAD^1
>> it only show up one commit so can't squash (can't squash without a
>> previous commit)
>>
>>
>> Any help on this?
>>
>> Thanks
>> Lynn
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Henrik Hautakoski
> henrik@fiktivkod.org
>
