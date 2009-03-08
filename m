From: Aneesh Bhasin <contact.aneesh@gmail.com>
Subject: Re: Gitk - Seeing just a specific remote ?
Date: Sun, 8 Mar 2009 18:31:36 +0530
Message-ID: <f662f0210903080601g4c637fcbqcf62435a3922349f@mail.gmail.com>
References: <f662f0210903052158q77aa0f2fo92c4f4a09c13780e@mail.gmail.com>
	 <49B0D8FD.6070807@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Sun Mar 08 14:06:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgIhM-0000xy-1Y
	for gcvg-git-2@gmane.org; Sun, 08 Mar 2009 14:05:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751845AbZCHNBj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Mar 2009 09:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751830AbZCHNBi
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Mar 2009 09:01:38 -0400
Received: from rv-out-0506.google.com ([209.85.198.235]:45431 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751790AbZCHNBi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Mar 2009 09:01:38 -0400
Received: by rv-out-0506.google.com with SMTP id g37so1226703rvb.1
        for <git@vger.kernel.org>; Sun, 08 Mar 2009 06:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8g8VxMxNMw4CWQaQ5s5aI1EhgB/Hx8119HLBZ6uvktQ=;
        b=Iv9p2OnVtcxUY15S3fBBNvTDVjzBkeP6T7aQD9E30HJBPGwhE8SJipq0QYijh46gqV
         q9HtF2/U+ayimPnnqgaocMS10TaJQfh+KurX6fY0SL8dgzH+uIFRbQ+256Ea6Ow4cB1i
         QPj46bU/hieWwQdD8Lb70p/A+rGE/WJ2ehFho=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=txdcL1/bw1BrsQivpBhYmLrFoghR/5Mq5I3PYm4e1CXaRvQooul3Tv6wws2uhJO5rD
         Ecyt0sN14v8VsbrtpwJuRoAXdUln0iyqjTEPQx31aiWGStgVEEG+vAqCf7vrgk8KkfEL
         BSyRHVKYbvh9PIcCaeSFfjS8bXN6QmC7J1QL4=
Received: by 10.140.173.17 with SMTP id v17mr2456039rve.98.1236517296570; Sun, 
	08 Mar 2009 06:01:36 -0700 (PDT)
In-Reply-To: <49B0D8FD.6070807@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112619>

On Fri, Mar 6, 2009 at 1:34 PM, Johannes Sixt <j.sixt@viscovery.net> wr=
ote:
> Aneesh Bhasin schrieb:
>> I have a git repository (say, new_develop) in which a remote
>> repository (say old_develop) is also there of some older work with t=
he
>> associated remote branches. Is there a way to see all =A0the branche=
s of
>> only this remote older_develop repository graphically in gitk -
>> something that shows me the same thing that doing a 'gitk --all' wou=
ld
>> have shown had I done it from the older_develop repository itself ? =
If
>> I say 'gitk --all' (in new_develop) it shows me all the branches
>> (local as well as remote). Specifying 'gitk --remotes' also shows al=
l
>> the remote branches (not just from the old_develop remote repo) ? Is
>> there some other way that I am missing ? I have seen the man page of
>> git-rev-list too but there doesn't sem to be a way to do it.
>
> gitk has an option, --argscmd, that you can use:
>
> =A0gitk --argscmd=3D"git for-each-ref --format=3D'%(refname)'
> refs/remotes/old_develop/*"
>

Thanks. That was exactly what I was looking for.
