From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFD PATCH 00/32] subtree clone v2
Date: Wed, 25 Aug 2010 10:20:57 +1000
Message-ID: <AANLkTimKEtkjM-sXrqa=LHTKzUb78TZBXA5siDPyfB_h@mail.gmail.com>
References: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
	<20100824223741.GB2376@burratino>
	<AANLkTikipryFVf_XvvbHopWSo5Ey_mvgTevY2NAvhygQ@mail.gmail.com>
	<20100824230907.GD2376@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 25 02:21:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo3jo-0003za-4Z
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 02:21:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755207Ab0HYAVA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Aug 2010 20:21:00 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:62645 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754350Ab0HYAU7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Aug 2010 20:20:59 -0400
Received: by wwb34 with SMTP id 34so22581wwb.1
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 17:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=AIw1UvEDtb3eh6M3ctO660AWcybSI67alUpX03LJFh8=;
        b=eOU4OpneLxD7S/0sJkifMp3MymxaG8KsvNtl2e7zDzoPvxnGQzcS/cWhmKvEIPg0NH
         oey0TapYyrH0AWd87/6wGu/3b2be0JJeK658OlkJ9AJpdWujj/8Md0GCXWJ/7bJVVSHl
         rCFYzSFPutdFuvzFCJF0WiT5HdatzkKkCD0U4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=q8j3LXglLzq/CNfOyk4BoT3Q54xoqLd/sHXwivuiFz7H5jG7yPNw67q0iV82WA3xWd
         fmeE4UpC0fdWXhmHa+0XeBezhu4v1radNAGJSiF62+Q/gU48Gs3njcZvgDOSAXaznPu6
         3NikdrS0pWSanFvL42FXx653unmagkPXJeQKY=
Received: by 10.216.1.12 with SMTP id 12mr1581769wec.1.1282695657844; Tue, 24
 Aug 2010 17:20:57 -0700 (PDT)
Received: by 10.216.184.17 with HTTP; Tue, 24 Aug 2010 17:20:57 -0700 (PDT)
In-Reply-To: <20100824230907.GD2376@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154385>

On Wed, Aug 25, 2010 at 9:09 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Nguyen Thai Ngoc Duy wrote:
>> On Wed, Aug 25, 2010 at 8:37 AM, Jonathan Nieder <jrnieder@gmail.com=
>
>> wrote:
>
>>> is it possible to
>>> merge without remote contact in the boring case, when no changes ha=
ve
>>> occured outside the narrow tree?
>>
>> That's possible (and is implemented in my series). But I guess as so=
on
>> as you do "git pull", the boring case is likely not applicable
>> anymore.
>
> Makes sense.
>
> One slightly less boring case. =C2=A0Is it possible to merge when the
> simplified history, looking only at changes outside the narrow tree,
> would have permitted a fast-forward?

Yes, as long as there is no changes outside narrow tree.

>
> If so, a git contributor who is only interested in Documentation/
> could work on "next" between releases and keep up with "maint" and
> "master" longer term, without the help of a full-tree-merging machine=
=2E
>
> More realistically, a linux-2.6 contributor only interested in one
> subsystem could always keep up with "master". =C2=A0Which would be ni=
ce.
>



--=20
Duy
