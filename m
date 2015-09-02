From: Chris Packham <judge.packham@gmail.com>
Subject: Re: Git book figure bug
Date: Wed, 2 Sep 2015 20:36:58 +1200
Message-ID: <CAFOYHZChEdNJq2g5mcNL0AmTFUmMmuZ26Rpqv6gzbsNCcTvbLQ@mail.gmail.com>
References: <FADA8795DF99B842A563D149FBDDAE5F58341EF5@VMPREVAS2.prevas.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Scott Chacon <schacon@gmail.com>
To: =?UTF-8?Q?Jesper_J=C3=B8rgensen?= <Jesper.Jorgensen@prevas.dk>
X-From: git-owner@vger.kernel.org Wed Sep 02 10:37:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZX3XW-00026c-Qc
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 10:37:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754024AbbIBIhB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Sep 2015 04:37:01 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:34295 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753909AbbIBIg7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Sep 2015 04:36:59 -0400
Received: by iofb144 with SMTP id b144so12082484iof.1
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 01:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=cy2yy41WkDn3hm81kjhQREv/emdeAqoG9/+a7UmU994=;
        b=jajt02Hyckzw2GXLVDMXYs7RtLS9QK7nSdjEjgs/MvG030tdRPXNFdaNQysFpM4qwR
         wYcezWP+JqN18JS/dAVxH5ISqDpkROvBWKuCozHeIpGr2ui6GsPrMGmDhONdHd1o0sP9
         a8HHiDCHDQSBnNo10AmHEAqb7JWRZxgtk62B8DQFdmoIY9gWvF0uvheYL1EHQj3NSZss
         kWSVgT3T1OPBGtncuQp5zmR5vQ2F8XhrvY4hbJ1PxEOHWyzdf3RMBXqozPpC8PFI8vqQ
         vd0W6k0/yn4f3yPMQ/vRL99x0ww7UkpBc6vhelEOxhlR8quJyY0PJEBCXXv2m00p9cYB
         jimA==
X-Received: by 10.107.18.167 with SMTP id 39mr5581540ios.34.1441183019036;
 Wed, 02 Sep 2015 01:36:59 -0700 (PDT)
Received: by 10.79.109.71 with HTTP; Wed, 2 Sep 2015 01:36:58 -0700 (PDT)
In-Reply-To: <FADA8795DF99B842A563D149FBDDAE5F58341EF5@VMPREVAS2.prevas.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277080>

On Wed, Sep 2, 2015 at 7:45 PM, Jesper J=C3=B8rgensen
<Jesper.Jorgensen@prevas.dk> wrote:
> Hi,
>
> I am learning how git works, and is using the excellent book on the o=
fficial site.
> I believe I have located a mistake in one of the images.
> It is  about Figure 3.17 on this page : http://git-scm.com/book/en/v2=
/Git-Branching-Basic-Branching-and-Merging
>
> As far as I understand it, the right most snapshot called C5 should h=
ave been named C6.
> The texts describes a new snapshot being made from the merge of the 2=
 branches.
> Having 2 snapshots both named C5 does not seem like it can be possibl=
e.
>

Indeed you are correct. Looks like this was fixed a while ago
https://github.com/progit/progit2/commit/3491527b33251fcacd8d2964bf7fb5=
e0f1cfe455
but hasn't made it into the "live" website.
