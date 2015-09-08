From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: bash completion lacks options
Date: Tue, 8 Sep 2015 13:28:53 +0200
Message-ID: <CACBZZX44qsZZovvJFwP9foqhWaD1ZmL3u+F3hYv2iVq0CKnO6g@mail.gmail.com>
References: <20150907150757.GA6720@aepfle.de> <CACBZZX4aZo_hn07Pho2GtBVNWm7WHLbV6xSi_r-BjW97QWNqEg@mail.gmail.com>
 <55EDAEF3.7000503@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>
To: Olaf Hering <olaf@aepfle.de>
X-From: git-owner@vger.kernel.org Tue Sep 08 13:29:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZH5h-000301-8Q
	for gcvg-git-2@plane.gmane.org; Tue, 08 Sep 2015 13:29:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754489AbbIHL3R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Sep 2015 07:29:17 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:33610 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754003AbbIHL3N convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Sep 2015 07:29:13 -0400
Received: by qkdw123 with SMTP id w123so25447164qkd.0
        for <git@vger.kernel.org>; Tue, 08 Sep 2015 04:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=HA19P/3ebnl6mMZ4Dc3bMsVUQdfNc6mbomF2o8xRxWY=;
        b=DaT7b2HGV+Gf6rp8x+Yr9c+h3ijl7lB6qSQCMIkXMGQL85ItyWag3RC6v6H+g7+Uk4
         o2kS3jrYxNdwq4bNGsnuskGJgKwhKdVM4IsLBVb/Yhs57GCKHDYnMH0IzUyFbhRefCyY
         T8gOWA3F2Djug/pHsbJ+JQDCitl+vdyx5QCBsRX2HFRVfZuOScqC8YBIm0ow2UdKDPgZ
         knahWoDFpyMlUxN7x9GOfL3AcXiBkS/hhdUl2AXC0GMPicwl7aZze+HOEO2FHGMdh4HZ
         IAiRBHvqmsjpMwLjuydi4cgT2MbUgm1rhpt4MCKZGaqL3uW00YY7eOqjWCOw7+uL45d5
         19pQ==
X-Received: by 10.55.201.141 with SMTP id m13mr33478398qkl.68.1441711752745;
 Tue, 08 Sep 2015 04:29:12 -0700 (PDT)
Received: by 10.55.24.209 with HTTP; Tue, 8 Sep 2015 04:28:53 -0700 (PDT)
In-Reply-To: <55EDAEF3.7000503@aepfle.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277500>

On Mon, Sep 7, 2015 at 5:36 PM, Olaf Hering <olaf@aepfle.de> wrote:
> Am 07.09.2015 um 17:34 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason=
:
>> On Mon, Sep 7, 2015 at 5:07 PM, Olaf Hering <olaf@aepfle.de> wrote:
>
>>> https://github.com/libguestfs/libguestfs/commit/0306c98d319d189281a=
f3c15101c8d343e400f13
>>
>> This is an interesting approach, but wouldn't help with git-send-ema=
il
>> in particular, it's a Perl script, so there's no ELF section to pars=
e.
>
> format-patch is a ELF binary, a link to git itself as I notice
> just now.

Yes, format-patch is written in C, but you mentioned send-email, which
is a Perl script.
