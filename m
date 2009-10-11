From: Dilip M <dilipm79@gmail.com>
Subject: Re: Installing full fledged git on solaris?
Date: Sun, 11 Oct 2009 19:04:58 +0530
Message-ID: <c94f8e120910110634q737f4886p95b79c4367f5959f@mail.gmail.com>
References: <c94f8e120910110526r68e4abe1l269dc4b3ab22bac3@mail.gmail.com> 
	<c94f8e120910110557q764dbf19s33c52e7f5120662@mail.gmail.com> 
	<f488382f0910110614r144fa14g5c1eba2cc0cb5b8a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Steven Noonan <steven@uplinklabs.net>
X-From: git-owner@vger.kernel.org Sun Oct 11 15:37:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mwybm-0003pm-NH
	for gcvg-git-2@lo.gmane.org; Sun, 11 Oct 2009 15:37:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757273AbZJKNfz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Oct 2009 09:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755161AbZJKNfz
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Oct 2009 09:35:55 -0400
Received: from mail-pz0-f188.google.com ([209.85.222.188]:64046 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770AbZJKNfy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Oct 2009 09:35:54 -0400
Received: by pzk26 with SMTP id 26so7420166pzk.4
        for <git@vger.kernel.org>; Sun, 11 Oct 2009 06:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=iF6OYbgUO19NLDDy47X/mq0cDD0xkTkFzEl7k3aWBwc=;
        b=OQ692AGYSLf9Pz0+EVcJyDtPcFfnEUstBiyglmgHITIxLxtI5gqnZYB2Lzv5gNDMwX
         k5KuCzCn/4LvuwdkiIZljUTj2NuiwQSyK2HPA2l/PT1eiaUhilDsBq/3k81EHGLVdGGg
         j5UEZO+XS8bUEapN4p1e6+xEKMFD8HKMdy5To=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=KMRoUNgkoh0wrxm2cJXpl8j1epKQQ8trgeFocIsgUG/aTCKOHYmQ0kcqYn2iM+531l
         u/1omlBjXGjXgcV7y+nrwORPEd/v0sdsAFvCJz95LjMbGAUl7cgnknJ48TA/V36CSIDJ
         bfD4H3IHrtUX+sAby7+iyz0rSD9GiLFORCL9E=
Received: by 10.140.136.9 with SMTP id j9mr353123rvd.136.1255268118098; Sun, 
	11 Oct 2009 06:35:18 -0700 (PDT)
In-Reply-To: <f488382f0910110614r144fa14g5c1eba2cc0cb5b8a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129923>

On Sun, Oct 11, 2009 at 6:44 PM, Steven Noonan <steven@uplinklabs.net> =
wrote:
> On Sun, Oct 11, 2009 at 5:57 AM, Dilip M <dilipm79@gmail.com> wrote:
>> On Sun, Oct 11, 2009 at 5:56 PM, Dilip M <dilipm79@gmail.com> wrote:
>>> Hello,
>>>
>>>
>>> Has anyone has the list of pkg's to be installed on solaris 10 spar=
c,
>>> to get the GIT compiled (with all features)..
>>>
>>> thanks in advance for sharing...
>>
>> Trying to compile the latest version exit with this error
>>
>> =A0 =A0CC xdiff/xpatience.o
>> =A0 =A0AR xdiff/lib.a
>> =A0 =A0LINK git-fast-import
>> Undefined =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 first referenc=
ed
>> =A0symbol =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 in=
 file
>> libiconv_close =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0libgit.a(u=
tf8.o)
>> libiconv_open =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 libgit.a(u=
tf8.o)
>> libiconv =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0libg=
it.a(utf8.o)
>> ld: fatal: Symbol referencing errors. No output written to git-fast-=
import
>> collect2: ld returned 1 exit status
>> gmake: *** [git-fast-import] Error 1
>>
>
> So try installing libiconv? (I think the package name on Solaris is
> SUNWgnu-libiconv)

I already have it.

[2108]dilim@blrmimsbuild4:~/dl/tig-0.14.1> pkginfo | grep libiconv
application SMCliconv                        libiconv





--=20
Dilip
