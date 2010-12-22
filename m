From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: "git pull" doesn't respect --work-tree parameter
Date: Wed, 22 Dec 2010 18:44:05 +0700
Message-ID: <AANLkTimM9Ah+D6uYnOuZDjYzKfN2-YVArOAwegO9dbSD@mail.gmail.com>
References: <AANLkTi=UtZuPQcTNnwS_fXgzRn4MHAUGS8zyTMqX9E2J@mail.gmail.com>
 <AANLkTik9s0cLc_P=NWvpO=DhytOkLNASEM7sjzoscHo3@mail.gmail.com> <AANLkTinGPJRQCOVz5JeqL4xnUG9V=5fkJhz6C5Mi1A3o@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Alexey Zakhlestin <indeyets@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 22 12:44:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVN7a-0006FT-7T
	for gcvg-git-2@lo.gmane.org; Wed, 22 Dec 2010 12:44:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752401Ab0LVLoh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Dec 2010 06:44:37 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:36084 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751882Ab0LVLog (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Dec 2010 06:44:36 -0500
Received: by wwa36 with SMTP id 36so5179356wwa.1
        for <git@vger.kernel.org>; Wed, 22 Dec 2010 03:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=sL501o3Abz9ZHcs+fjqjcVGVq2jqwfHeS7Q0Duk4s+0=;
        b=Pmdt1qcur0mWIzSd9ZQF3OCI2D7t6gKe+GZ8fM8KCyB3diOZyKiznuZoPyVdqUYKSb
         mbHKs8HA3U1YqMSya0NoN6fN/K1I7XqVHUMP+bxfG0Lz7HwA7j6tq07i4xNOEz8dhzt8
         +cTN63aIdhqo1t9HMtg86otn8M80ytQ+9tYBE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=bCYvTUnpachNJLGabXvgR7RqXzKqQJXDEu724ZmDdK9dmNKaey45sy5wyM/Xn9Dow4
         vH3AtImISdIVipo2HjNFvzQ5Xl9avf2Ok+7fq4qCI6P6PBwLch/PklmxyawTLv6tmzaQ
         g1Ihh1A2dXtyhvF5pnmnqi1nFuR2HA4RhK4r8=
Received: by 10.216.59.143 with SMTP id s15mr2653245wec.49.1293018275641; Wed,
 22 Dec 2010 03:44:35 -0800 (PST)
Received: by 10.216.158.83 with HTTP; Wed, 22 Dec 2010 03:44:05 -0800 (PST)
In-Reply-To: <AANLkTinGPJRQCOVz5JeqL4xnUG9V=5fkJhz6C5Mi1A3o@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164081>

On Wed, Dec 22, 2010 at 6:40 PM, Alexey Zakhlestin <indeyets@gmail.com> wrote:
> On Wed, Dec 22, 2010 at 2:20 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
>> On Tue, Dec 21, 2010 at 11:04 PM, Alexey Zakhlestin <indeyets@gmail.com> wrote:
>>> I am trying to use the following command:
>>>
>>> git '--git-dir=/path/to/repository/.git' '--work-tree=/path/to/repository' pull
>>>
>>> and get this error:
>>> "git-pull cannot be used without a working tree"
>>
>> It works fine for me. What's the result of
>>
>> git '--git-dir=/path/to/repository/.git'
>> '--work-tree=/path/to/repository' --git-dir
>
> No directory given for --git-dir.
>
>> git '--git-dir=/path/to/repository/.git'
>> '--work-tree=/path/to/repository' --is-inside-work-tree
>
> Unknown option: --is-inside-work-tree
>
>> git '--git-dir=/path/to/repository/.git'
>> '--work-tree=/path/to/repository' --show-toplevel
>
> Unknown option: --show-toplevel

Sorry I forgot the command name (rev-parse). The full command should
be "git --git-dir=... --work-tree=... rev-parse <option>" where option
is --git-dir, --is-inside-work-tree, --show-toplevel. Can you please
try again?
-- 
Duy
