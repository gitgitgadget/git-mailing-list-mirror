From: Jonathan del Strother <maillist@steelskies.com>
Subject: Re: Can't build git on Lion?
Date: Fri, 29 Jul 2011 19:51:05 +0100
Message-ID: <CAF5DW8+9ketSNULU67YwY7QDqMSLrOGQAXXodD9Dr2p-ivWo6w@mail.gmail.com>
References: <CAF5DW8+efO0jcynyhg3GCZc5JByHwQzudqtrJXF87YazYjF2mw@mail.gmail.com>
 <loom.20110728T141556-724@post.gmane.org> <20110729063812.GA64045@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jack Nagel <Jack.Nagel.1@ndsu.edu>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 29 20:51:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qms9p-0006mp-7v
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jul 2011 20:51:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752677Ab1G2Sv3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Jul 2011 14:51:29 -0400
Received: from juliet.asmallorange.com ([207.210.105.70]:56953 "EHLO
	juliet.asmallorange.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751305Ab1G2Sv2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jul 2011 14:51:28 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55698)
	by juliet.asmallorange.com with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.69)
	(envelope-from <maillist@steelskies.com>)
	id 1Qms9g-0007v3-W0
	for git@vger.kernel.org; Fri, 29 Jul 2011 14:51:29 -0400
Received: by iyb12 with SMTP id 12so4263608iyb.19
        for <git@vger.kernel.org>; Fri, 29 Jul 2011 11:51:25 -0700 (PDT)
Received: by 10.231.119.67 with SMTP id y3mr1050847ibq.155.1311965485092; Fri,
 29 Jul 2011 11:51:25 -0700 (PDT)
Received: by 10.231.16.66 with HTTP; Fri, 29 Jul 2011 11:51:05 -0700 (PDT)
In-Reply-To: <20110729063812.GA64045@gmail.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - juliet.asmallorange.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - steelskies.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178158>

On 29 July 2011 07:38, David Aguilar <davvid@gmail.com> wrote:
> On Thu, Jul 28, 2011 at 12:19:01PM +0000, Jack Nagel wrote:
>> > There's no /System/Library/Perl/5.10.0 directory, but there is a 5=
=2E10
>> > directory. =C2=A0Symlinking that to 5.10.0 gives me :
>>
>> I've seen this issue pop up serveral times in the last few days in v=
arious
>> places; the solution is to install (or re-install) XCode as the inst=
allation
>> does not persist correctly across upgrades. Versions prior to 4.1 ar=
e
>> incompatible with Lion; also, after you download it from the App Sto=
re, make
>> sure that you run the "XCode Installer" app that is placed in your
>> Applications folder.
>
> The last time I saw this error it was because the Perl version
> changed. =C2=A0"make clean" fixed it for me. =C2=A0YMMV.

Oh, good point.  Yes, 'make clean' fixed things, thanks for the tip.
