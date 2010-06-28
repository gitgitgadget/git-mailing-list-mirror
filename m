From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: notify alternative to auto gc?
Date: Mon, 28 Jun 2010 12:02:35 -0700
Message-ID: <AANLkTinGs3Nu-2hFcCSeEZBTT8OhfOG-iu4CNjdG62uS@mail.gmail.com>
References: <EA7717AE-DA72-48D7-A27E-C958896FD158@gmail.com> 
	<AANLkTikjbu_q6QToVUeNAAL0Fls9eQ5BZkzZ1-8L93zh@mail.gmail.com> 
	<loom.20100628T205729-213@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eric Raible <raible@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 28 21:03:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTJbh-0002Vo-Ev
	for gcvg-git-2@lo.gmane.org; Mon, 28 Jun 2010 21:03:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751758Ab0F1TC5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jun 2010 15:02:57 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:56081 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808Ab0F1TC4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Jun 2010 15:02:56 -0400
Received: by gyd12 with SMTP id 12so1046178gyd.19
        for <git@vger.kernel.org>; Mon, 28 Jun 2010 12:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=imNBB1SWPza2Wl/+MmnHIeA3RkM5ebjuH3KGlSxpu6A=;
        b=wid+ru+mnvlSUtGtX/JVgFA1l1wDK5dnGOqGwwBzZRVWVau4jsGBz1vHO0ikWXeTRo
         IYJwAy8L6TP3hht1MVG0OYZ7ummQu552aAWpigRj/G0qpRIv/gQlisBf8+E+e598M3yE
         hrxlXmI6WwR8pRiDOl9ASr8MVJoQGfIMvzu3Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=XqqrOmzmiUfpY8OGjOBw0KAodSph8oFnRamMjP4FiSEOM2RTmprJ8WGM0ux2C1feBj
         76SaxFIhglLAWzzD7PWNkrGqPQJ2TBQEKozXYOO1cHPICbWBSfTkOdLuWTCLY6N2H6Ny
         i9lMzpZc/uvrp2t3Bszgsg0XXilOuq4w2Mu00=
Received: by 10.229.185.141 with SMTP id co13mr2995401qcb.241.1277751775479; 
	Mon, 28 Jun 2010 12:02:55 -0700 (PDT)
Received: by 10.229.222.72 with HTTP; Mon, 28 Jun 2010 12:02:35 -0700 (PDT)
In-Reply-To: <loom.20100628T205729-213@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149852>

On Mon, Jun 28, 2010 at 11:58, Eric Raible <raible@gmail.com> wrote:
> Chris Packham <judge.packham <at> gmail.com> writes:
>
>> So a hook like
>>
>> =C2=A0 #! /bin/sh
>> =C2=A0 echo "repository needs git gc"
>> =C2=A0 exit 1
>>
>> Should cause the auto gc to be skipped.
>
> Except wouldn't you also need a mechanism
> to allow an explicit gc to actually proceed?
>

Only if you're explicitly calling "git gc --auto" instead of "git gc".
 That hook should only run for "git gc --auto".
