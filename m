From: Steven Noonan <steven@uplinklabs.net>
Subject: Re: Installing full fledged git on solaris?
Date: Sun, 11 Oct 2009 06:14:08 -0700
Message-ID: <f488382f0910110614r144fa14g5c1eba2cc0cb5b8a@mail.gmail.com>
References: <c94f8e120910110526r68e4abe1l269dc4b3ab22bac3@mail.gmail.com>
	 <c94f8e120910110557q764dbf19s33c52e7f5120662@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Dilip M <dilipm79@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 11 15:16:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwyHr-00045L-3Z
	for gcvg-git-2@lo.gmane.org; Sun, 11 Oct 2009 15:16:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754716AbZJKNOp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Oct 2009 09:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754656AbZJKNOp
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Oct 2009 09:14:45 -0400
Received: from mail-px0-f179.google.com ([209.85.216.179]:53581 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754503AbZJKNOo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Oct 2009 09:14:44 -0400
Received: by pxi9 with SMTP id 9so7949119pxi.4
        for <git@vger.kernel.org>; Sun, 11 Oct 2009 06:14:08 -0700 (PDT)
Received: by 10.142.74.8 with SMTP id w8mr366899wfa.192.1255266848291; Sun, 11 
	Oct 2009 06:14:08 -0700 (PDT)
In-Reply-To: <c94f8e120910110557q764dbf19s33c52e7f5120662@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129921>

On Sun, Oct 11, 2009 at 5:57 AM, Dilip M <dilipm79@gmail.com> wrote:
> On Sun, Oct 11, 2009 at 5:56 PM, Dilip M <dilipm79@gmail.com> wrote:
>> Hello,
>>
>>
>> Has anyone has the list of pkg's to be installed on solaris 10 sparc=
,
>> to get the GIT compiled (with all features)..
>>
>> thanks in advance for sharing...
>
> Trying to compile the latest version exit with this error
>
> =A0 =A0CC xdiff/xpatience.o
> =A0 =A0AR xdiff/lib.a
> =A0 =A0LINK git-fast-import
> Undefined =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 first reference=
d
> =A0symbol =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 in =
file
> libiconv_close =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0libgit.a(ut=
f8.o)
> libiconv_open =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 libgit.a(ut=
f8.o)
> libiconv =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0libgi=
t.a(utf8.o)
> ld: fatal: Symbol referencing errors. No output written to git-fast-i=
mport
> collect2: ld returned 1 exit status
> gmake: *** [git-fast-import] Error 1
>

So try installing libiconv? (I think the package name on Solaris is
SUNWgnu-libiconv)

- Steven
