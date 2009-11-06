From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: Git drawbacks?
Date: Fri, 6 Nov 2009 09:41:05 -0800
Message-ID: <8c9a060911060941w2eea5b04m1bd8dfe7a4d5ea70@mail.gmail.com>
References: <loom.20091106T160709-387@post.gmane.org> <32541b130911060849s2d8f13f5sb9b8390f075f8d15@mail.gmail.com> 
	<loom.20091106T180313-750@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Dmitry Smirnov <divis1969@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 06 18:41:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6SoV-0002w4-9j
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 18:41:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758650AbZKFRlU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Nov 2009 12:41:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758628AbZKFRlU
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 12:41:20 -0500
Received: from mail-px0-f179.google.com ([209.85.216.179]:55088 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757834AbZKFRlT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Nov 2009 12:41:19 -0500
Received: by pxi9 with SMTP id 9so829167pxi.4
        for <git@vger.kernel.org>; Fri, 06 Nov 2009 09:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=zkxTIbdDoQ1QU4bLw9fZOp8u6R6+phqODAKPrA69aug=;
        b=Il2Ty06dyVgCj5/PRvjWsbY5iaHKiz5F3e5R1teZz0OOZ9dIKYvNWxdr3vzdd+Rb96
         +lJkNi/K3SJ2MtSZEc/5ifNm2eRf19gLqgugLECWXWSHmOZnqV6Y/s22VcypZWu/C3FV
         pXuc61ATZ+PI413+Q0BuOR63oOHahFg78m/qk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=nHS+kw/L9wb3wao4vHAUcT3lMgXvXJC+cbJEw/2Unr5Hh8pqgKhAA5AKB8KW6ijXYQ
         vU1Y3JmIs09YnWa1z+dD3ic1OKx5cJf7LkZ1d2SGjmJ7ijBVbmAP8LfhJQFZb+0hDMJk
         w3uaAPgKf4j8BfjhTlDTHABZlipD+JK+inDx8=
Received: by 10.141.14.17 with SMTP id r17mr255459rvi.140.1257529285051; Fri, 
	06 Nov 2009 09:41:25 -0800 (PST)
In-Reply-To: <loom.20091106T180313-750@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132314>

On Fri, Nov 6, 2009 at 09:35, Dmitry Smirnov <divis1969@gmail.com> wrot=
e:
> No, #2 is about the repository slicing, branching, merging (SCM in ot=
her words).
> Let's suppose I have the product that have 2 directories: component1 =
and
> component2. They were developing together for =C2=A0previous product =
(on the same
> branch, for example). Now, I would like to have component1 and replac=
e
> component2 with some 3rd party component. What should I do with Git t=
o get this?
> Or maybe I wish to stick with some version of component2 and provide =
only bug
> fixes for this product...
> Or let's take a look at GDB. They are using binutils which are in sep=
arate
> repository (they use CVS, but let's imagine they use Git). How many e=
ffors they
> will need for SCM? For example, they would prefer to stick to some st=
able
> version/branch of the binutils but should be able to commit bug fixes=
=2E
>
> Once again, perhaps there is some way to do this with Git? I did not =
yet find
> it.
>

Sounds like you want submodules.  Check out the git-submodule(1) manpag=
e.
