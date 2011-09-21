From: Scott Chacon <schacon@gmail.com>
Subject: Re: mac osx
Date: Wed, 21 Sep 2011 11:01:08 -0700
Message-ID: <CAP2yMaLCu6epGkFOEOsfPgmUodCiBYRePLtewEmny1Z3W5D=QA@mail.gmail.com>
References: <loom.20110921T002437-246@post.gmane.org>
	<CAFcyEtiexmE0WMif-eGHe5xMoYv7-8mdXos1qbQBH3g04z0sAg@mail.gmail.com>
	<CAGdFq_h0VqbZ5W3QVwoQWT63znhpePDFCRE+-n1TqPNztREwkA@mail.gmail.com>
	<F4C226A7-768D-4913-A6C1-12411FBA212C@gmail.com>
	<CAP2yMaJz3-iX11vhbrTVasFD1zdwsdiDFKU7z7=an8pBoORk8w@mail.gmail.com>
	<3509B3CD-8E7E-4097-B7F1-F092E5CF08F5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Kyle Neath <kneath@gmail.com>,
	tom smitts <tomsmitts@ymail.com>, git@vger.kernel.org
To: Timothy Harper <timcharper@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 21 20:01:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6R6l-0007T0-T6
	for gcvg-git-2@lo.gmane.org; Wed, 21 Sep 2011 20:01:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753719Ab1IUSBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Sep 2011 14:01:12 -0400
Received: from mail-gw0-f42.google.com ([74.125.83.42]:61015 "EHLO
	mail-gw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753675Ab1IUSBJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Sep 2011 14:01:09 -0400
Received: by gwj16 with SMTP id 16so728700gwj.1
        for <git@vger.kernel.org>; Wed, 21 Sep 2011 11:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=0sAe70Z7i8i7Qjr/yLT8VAr71E6OiRmfovNSHkfsjXw=;
        b=YdKFv6x9h3fEe4zXsC+e/mRbaYQ61Xa9VH7pRA50zJGxU7D2CDF7NEo8MZq53IoM6C
         FTIvaw24/iv8bvbmdWbK6X1pD4+th1XHnheAqsbShkm6HBMt4QCRvSc4YPHTH3OVASM7
         jEIe5d5F7SZLXeVVVvkpM9MrjBwRe6y1HTDAg=
Received: by 10.150.63.19 with SMTP id l19mr1409923yba.25.1316628068324; Wed,
 21 Sep 2011 11:01:08 -0700 (PDT)
Received: by 10.150.212.13 with HTTP; Wed, 21 Sep 2011 11:01:08 -0700 (PDT)
In-Reply-To: <3509B3CD-8E7E-4097-B7F1-F092E5CF08F5@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181854>

Hey,

On Wed, Sep 21, 2011 at 10:49 AM, Timothy Harper <timcharper@gmail.com> wrote:
> Ever since installing OS X Lion and Xcode 4.1 it seems I have lost the ability to build targeting Leopard (see /Developer/SDKs/), and haven't looked in to a work around. I have only built packages targeting the Snow Leopard.
>
> I see two possible resolutions:
>
> A) Tag builds as 32-bit and 64-bit. At git-scm.com (and github), link to the list that only shows 32-bit builds. For 99.9% (pulled-out-of-butt) of people using the installer, this will be just fine. For people who care about 64 bit, if they are motivated they can build own or find it.
>
> B) Switch to universal architecture and cause everyone to suffer an addition 30% or so wait while downloading the installer.
>
> What do y'all vote for?

I vote for Universal builds.  I don't think anyone downloading a DMG
will care between 6M and 9M - it's still smaller than most YouTube
videos.  Then I can just have people choose their OS version and
auto-download whatever the latest build is.

Also, fwiw, though this is the first you may have heard about it, I've
personally had probably 5 or 6 people approach me at conferences and
trainings and complain about it - or email me as the maintainer of the
git-scm page to complain.  I probably should have brought it up
sooner, but I've just been so happy you've been doing the builds at
all, I didn't want to complain :)

Scott
