From: Eugene Sajine <euguess@gmail.com>
Subject: Re: origin/branchname and tracking branch pointing to different 
	commits?
Date: Mon, 28 Jun 2010 13:43:22 -0400
Message-ID: <AANLkTik7bleuzqnMWMJoWljQ5zD0YbwBsFjZT5IzkV0q@mail.gmail.com>
References: <76c5b8581001070903i3810f63crd764d451f7454584@mail.gmail.com>
	<201001071813.01187.trast@student.ethz.ch>
	<76c5b8581001070925g21ac3136x2928f12dc43437e5@mail.gmail.com>
	<76c5b8581001071550g31e9f5a3n15ebdb10a806ab2e@mail.gmail.com>
	<7v7hrtzbau.fsf@alter.siamese.dyndns.org>
	<AANLkTinLVd483-ki6tVb545PgpOFeOLYLR_GiKM5xAl7@mail.gmail.com>
	<20100608183007.GA31293@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 28 19:43:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTIMm-0007VG-7B
	for gcvg-git-2@lo.gmane.org; Mon, 28 Jun 2010 19:43:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752345Ab0F1Rn1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jun 2010 13:43:27 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:40290 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751491Ab0F1Rn0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Jun 2010 13:43:26 -0400
Received: by gxk23 with SMTP id 23so206359gxk.19
        for <git@vger.kernel.org>; Mon, 28 Jun 2010 10:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=jcvDAtTfgrEgRcJZ2zdFIdhECPbk56S5bRkFH6JawQ8=;
        b=fcCX+vFJAfLrk9d37/tWj084ZVVgH3JhY0heQARdLrpKP3DQUP8JpKVgaBah2vh7gY
         H25ZDuwE5iE2DNPGwNUHxWeZMunQ+E60Oj6BpywYksJhkl1zBjlgeI2oWNVmKPo9crq+
         yJlcG/Z09m8FtzyFlqaa841forUoOkUcI04sY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=TwY3MpC+u1vupiHnEVdF57s4GTeJC1+YT2Ofi4ig7FWwBGPHFXvpkXi2WLRgS2HLmP
         Cd3GfRBhbRRN93oL1XR8jOvLxwjSRnFJUcjWrvFcdydY5Arz91gPNYiBRsOmX8SCFE6g
         UZZcS0h8AXUBdLvWztRojKXlXRUAG06oy5SHU=
Received: by 10.229.250.146 with SMTP id mo18mr2860716qcb.239.1277747002710; 
	Mon, 28 Jun 2010 10:43:22 -0700 (PDT)
Received: by 10.229.190.21 with HTTP; Mon, 28 Jun 2010 10:43:22 -0700 (PDT)
In-Reply-To: <20100608183007.GA31293@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149843>

On Tue, Jun 8, 2010 at 2:30 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Jun 08, 2010 at 12:27:14PM -0400, Eugene Sajine wrote:
>
>> I'm coming back to this topic as i see some confusion growing about
>> such behavior. Every now and then users come across this problem and
>> they expect pull to *really* behave as fetch and merge so it will
>> cause the update of remote/branchname branch. And it is kind of
>> difficult to justify why they have to do git fetch after pull...
>>
>> Can somebody, please, take a look?
>
> This was discussed a while back:
>
> =C2=A0http://thread.gmane.org/gmane.comp.version-control.git/127163
>
> and I even posted a patch, but never followed up (I think mostly just
> due to being busy).. There is some concern about unexpected ref updat=
es,
> though.
>
> -Peff
>

Jeff, Junio

Could you, please, advise if there is any resolution on the patch?

Thanks a lot,
Eugene
