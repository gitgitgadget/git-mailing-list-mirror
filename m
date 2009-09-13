From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] completion: Replace config --list with --get-regexp
Date: Sun, 13 Sep 2009 12:51:05 +0200
Message-ID: <36ca99e90909130351m7ad5a641t8adb3ade3d2ec5ca@mail.gmail.com>
References: <a3b675320909100813i3e70ab3at66408aebb9952c7d@mail.gmail.com>
	 <20090911133313.GF2582@inocybe.localdomain>
	 <a3b675320909110700k7eb7286qc8cb5691aae214c7@mail.gmail.com>
	 <20090911141730.GA384@coredump.intra.peff.net>
	 <20090911143651.GE1033@spearce.org>
	 <20090911150934.GB977@coredump.intra.peff.net>
	 <20090911232344.GH2582@inocybe.localdomain>
	 <20090912183139.GO1033@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Todd Zullinger <tmz@pobox.com>, Jeff King <peff@peff.net>,
	james bardin <jbardin@bu.edu>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Sep 13 12:51:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mmmfx-0004FJ-4W
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 12:51:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752809AbZIMKvG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Sep 2009 06:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752631AbZIMKvE
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 06:51:04 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:48431 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752565AbZIMKvD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Sep 2009 06:51:03 -0400
Received: by fxm17 with SMTP id 17so298826fxm.37
        for <git@vger.kernel.org>; Sun, 13 Sep 2009 03:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=aq+5NFjV2V8lsfSIC5Ms2kUExLGvSOy8v60CCukNktw=;
        b=MFSKx3kxqklPTw1WEqvRf6ZAbRyL4l+n2NMfAohz1aWFMzBs7pO43oufVdWUug0D+J
         QvbML//4s18nfgC1ZNrRnokVFd7venp2l2B9dhV3NIbht9zsfIQ+fxit5tAtl77+Hpks
         jAgl8LQLiRHixcMyFP7e570UTYw7AETY8t3gc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ktWYvhJ60TTOYPlYedbQSvSqIvLyD8P2hpoNQ9g/pe75myCJ7RsrSkI4FRZ1xmREXE
         6x6EZjaWfXWAhhrdSMHjYTFGYxYaLDxjhrRvfGDA1Y49k5wR7wBIQ7tt2O6VOgKOLoly
         CXKges3zs+e2gZ4CQtFXX7MPLjs13q7nhPZTI=
Received: by 10.223.7.90 with SMTP id c26mr1809267fac.73.1252839065578; Sun, 
	13 Sep 2009 03:51:05 -0700 (PDT)
In-Reply-To: <20090912183139.GO1033@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128354>

On Sat, Sep 12, 2009 at 20:31, Shawn O. Pearce <spearce@spearce.org> wr=
ote:
> Todd Zullinger <tmz@pobox.com> wrote:
>> James Bardin noted that the completion spewed warnings when no git
>> config file is present. =C2=A0This is likely a bug to be fixed in gi=
t config,
>> but it's also a good excuse to simplify the completion code by using=
 the
>> --get-regexp option as Jeff King pointed out.
>>
>> Signed-off-by: Todd Zullinger <tmz@pobox.com>
>
> Thanks, looks good.
I have not looked into this, but what about pushurl?

Bert
