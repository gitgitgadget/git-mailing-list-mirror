From: Elijah Newren <newren@gmail.com>
Subject: Re: EasyGit Integration
Date: Tue, 9 Jun 2009 15:48:43 -0600
Message-ID: <51419b2c0906091448r1d45705he06f34bf9da1f797@mail.gmail.com>
References: <d411cc4a0906091159r51e7d16t4d66c6225322fb60@mail.gmail.com>
	 <20090609212748.GD13781@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Scott Chacon <schacon@gmail.com>, git list <git@vger.kernel.org>
To: =?UTF-8?Q?Bj=C3=B6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 09 23:48:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ME9Bc-0002mF-GC
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 23:48:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754750AbZFIVsm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Jun 2009 17:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754693AbZFIVsm
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 17:48:42 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:43133 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754549AbZFIVsm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jun 2009 17:48:42 -0400
Received: by qw-out-2122.google.com with SMTP id 5so213391qwd.37
        for <git@vger.kernel.org>; Tue, 09 Jun 2009 14:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=aaV9wC6cs3GgNQUL3OIs1AjQ6dsmNoSgLfg+lYMnUaI=;
        b=ir0iY9aiGGP0PvjLCI5yUCcRps62uwcWkCC0MAFXH0KEd5UHzXDL/JuLO4TGP1YOcy
         aLzPYcnCYHg0cI5kdbZbX76XqoKEoH7B/ifxKsj8ALHjF8KMSFmDiVqCmJ3ttxBLt83P
         0yBtlW95X9Z8VyG79vwJBOCy1vK4oniqXakwg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Iamp63C1UbI7Mbv6VPtfDHrI9kNU/X7/fJjQzldIO+VFjQazNp7vZKQBCtDEEhlBJq
         eF8KmvcfQVxxbKXKheoifGT3xu3C5+n7nELPN2kI2rvEeTYvZNrgHDdtzjMdsuWv0HOX
         dpTcywDxErZhMoK+yqhlDeRJDrT0kgv7jRuHA=
Received: by 10.229.79.19 with SMTP id n19mr144721qck.74.1244584123630; Tue, 
	09 Jun 2009 14:48:43 -0700 (PDT)
In-Reply-To: <20090609212748.GD13781@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121228>

2009/6/9 Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de>:
> On 2009.06.09 11:59:08 -0700, Scott Chacon wrote:
>> * adds 'git resolved' for 'git add', which I hear all the time as
>> being confusing
>
> Is "resolve" a plain alias, like "stage", or smart in deciding which
> files it accepts? My gut feeling is that a plain alias might cause
> trouble again when users get lazy and start to do "git resolve ." and
> wonder why that adds new files.

In eg it's currently a plain alias, but I like your arguments for
making it only handle unmerged entries.

> Iff such a "resolve" command is added, it should IMHO only serve the
> purpose of changing the status of index entries marked as "unstaged",
> and do nothing else that "add" can do. When someone asks why "git add=
"
> is used for telling git that a conflict was resolved, I can say that
> "git add" means "add this to the things to be committed" and that tha=
t
> implies that conflicts have been resolved (I like to describe "git ad=
d"
> as "tell git that 'this is good to commit'"). So I can give some logi=
cal
> explanation. But if someone would ask me why "git resolve" can add ne=
w
> files, which never had a merge conflict, to the index, I'd be pretty
> stumped.
