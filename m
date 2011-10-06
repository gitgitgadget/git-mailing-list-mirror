From: =?UTF-8?Q?Marcin_Wi=C5=9Bnicki?= <mwisnicki@gmail.com>
Subject: Re: List of directories containing only ignored files
Date: Thu, 6 Oct 2011 16:32:39 +0200
Message-ID: <CAC9GOO_edkZxU=eO93fuCiV0vFaQjcnj7u8FUPYs-1hXrQX48A@mail.gmail.com>
References: <CAC9GOO__nN9W1vvoMxq2LKnn=YoFPjTE6jKPbQ2h7im3JtujQA@mail.gmail.com>
	<4E8DB548.5030108@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 06 16:32:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBp09-0003HW-Ib
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 16:32:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758588Ab1JFOck convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Oct 2011 10:32:40 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:37524 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758558Ab1JFOck convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Oct 2011 10:32:40 -0400
Received: by qyk7 with SMTP id 7so2618833qyk.19
        for <git@vger.kernel.org>; Thu, 06 Oct 2011 07:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=/JhTXujJFCIM7rkc4kD/YgOmDhm6gyKe95GGkMRFUJc=;
        b=qIyTMX/zSicvNFTbi/qUTzoR/8Jypg+imHdOMgvjCK43cspoxDtBaCApjRLxfySOlG
         D//eiHl0R03XSZNCvAbdEOB4+eeeNT2zTyoPWjwkR/XCZGoRTPOVRzAseEY8K7MbjK3c
         5yWp+1x67S6tEMKrLbMyzRWzhHA3NEzFa9bQY=
Received: by 10.229.88.143 with SMTP id a15mr594255qcm.191.1317911559575; Thu,
 06 Oct 2011 07:32:39 -0700 (PDT)
Received: by 10.229.170.2 with HTTP; Thu, 6 Oct 2011 07:32:39 -0700 (PDT)
In-Reply-To: <4E8DB548.5030108@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182954>

2011/10/6 Andreas Ericsson <ae@op5.se>:
> On 10/06/2011 03:56 PM, Marcin Wi=C5=9Bnicki wrote:
>>
>> Alternatively: how to remove such leftovers when switching branches =
?
>
> git clean -X -f
>

That also would delete /project1/obj/foo.o which is not what I wanted.

Anyway I think I have found the answer:

 git ls-files -o --directory --exclude-standard
