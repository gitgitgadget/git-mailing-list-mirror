From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 18/18] revert: Introduce --continue to continue the operation
Date: Wed, 27 Jul 2011 21:26:51 +0530
Message-ID: <CALkWK0k=+d+Nu5BgGhKdg3E13Db9kk-WYUY8dKQN_=QhLZi6GQ@mail.gmail.com>
References: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
 <1311736755-24205-19-git-send-email-artagnon@gmail.com> <20110727052211.GM18470@elie>
 <CALkWK0nX5GsfGi9ifxkfvoZWxVzFKBs8X60Svda0rQWKzz0aww@mail.gmail.com> <20110727154258.GE24785@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 27 17:57:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qm6U3-00052b-Ik
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 17:57:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754528Ab1G0P5O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Jul 2011 11:57:14 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:34054 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754427Ab1G0P5M convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jul 2011 11:57:12 -0400
Received: by wwe5 with SMTP id 5so1562673wwe.1
        for <git@vger.kernel.org>; Wed, 27 Jul 2011 08:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=RftSDyu+NByNFAx557c5ym0DiM3H9Kzd3XklXLfX9SM=;
        b=mgMppEwF2chQ24WaqoR7eLRv9bdfp/JXC8qy3PAhmrMGZw3VnBu9/Cpz79+T2/J0Lx
         SD9mdONcrsHOTnL7THGZvtSvfyUOchaqh8ofZNNYcbV/j0A3OVCnppLsDmQs1C5X7Hdp
         q+UkRZo2NEQn+PLCaaDkL+wiqPV4k3iRjlkOM=
Received: by 10.216.9.134 with SMTP id 6mr30115wet.111.1311782231110; Wed, 27
 Jul 2011 08:57:11 -0700 (PDT)
Received: by 10.216.70.16 with HTTP; Wed, 27 Jul 2011 08:56:51 -0700 (PDT)
In-Reply-To: <20110727154258.GE24785@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177980>

Hi Jonathan,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
>> The previous discussion thread for your reference [1] -- I thought w=
e
>> agreed that it was a glitch.
>
> Ok. =C2=A0I thought it had come up before and that there was not wide
> agreement but probably I imagined it. =C2=A0How about the patch below
> (needs commit message, tests)?

Looks good!  Thanks for working on this.  We can include this near the
beginning of the series I think.

-- Ram
