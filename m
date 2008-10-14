From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <santi@agolina.net>
Subject: Re: Rerunning merge on a single file
Date: Tue, 14 Oct 2008 14:28:54 +0200
Message-ID: <adf1fd3d0810140528p8bf8958t528b226d01a55a45@mail.gmail.com>
References: <48F48CDB.1010309@trolltech.com>
	 <adf1fd3d0810140521g7f43ee3bs5d4e60772bcc1d8c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Kristian Amlie" <kristian.amlie@trolltech.com>
X-From: git-owner@vger.kernel.org Tue Oct 14 14:30:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kpj2j-0006lD-W6
	for gcvg-git-2@gmane.org; Tue, 14 Oct 2008 14:30:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756397AbYJNM25 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Oct 2008 08:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756304AbYJNM25
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Oct 2008 08:28:57 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:40506 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756397AbYJNM24 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Oct 2008 08:28:56 -0400
Received: by gxk9 with SMTP id 9so5003384gxk.13
        for <git@vger.kernel.org>; Tue, 14 Oct 2008 05:28:55 -0700 (PDT)
Received: by 10.100.95.19 with SMTP id s19mr7247877anb.43.1223987334945;
        Tue, 14 Oct 2008 05:28:54 -0700 (PDT)
Received: by 10.100.112.16 with HTTP; Tue, 14 Oct 2008 05:28:54 -0700 (PDT)
In-Reply-To: <adf1fd3d0810140521g7f43ee3bs5d4e60772bcc1d8c@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98185>

On Tue, Oct 14, 2008 at 2:21 PM, Santi B=E9jar <santi@agolina.net> wrot=
e:
> On Tue, Oct 14, 2008 at 2:13 PM, Kristian Amlie
> <kristian.amlie@trolltech.com> wrote:
>> Hey, I have question about advanced merging.
>>
>> Suppose I have a huge merge with conflicts all over the place. There=
 is no
>> way to avoid them, so I start working from the top. At some point, h=
owever,
>> I make a mistake and lose the merge information for one file (for ex=
ample by
>> checking out the file from HEAD).
>>
>> In that case I would like to get the conflict markers back, and do t=
hat file
>> over again, but I don't want to throw away the rest of the index sta=
te.
>> Currently the only way I can see to do this is by checking out sever=
al file
>> versions under different names and then using git merge-file on them=
=2E
>>
>> Is there a better way to achieve this?
>
> If the different versions are still in the index you could use:
>
> $ git checkout --merge $file

Note that this is very new, as it was introduced in
v1.6.0.1-26-geac5a40, so you'll need at least 1.6.0.2.

Santi
