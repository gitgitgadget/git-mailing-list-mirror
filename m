From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Bulgarian translation of git
Date: Mon, 13 Feb 2012 09:56:23 -0600
Message-ID: <20120213155623.GH4140@burratino>
References: <75009f1d7c4aba4d62bb226ab122932c@192.168.122.10>
 <CANYiYbGr3zN-kJwq_MCnttNZP6Cc0aj-fsZjd4V=4z+BA5TvUw@mail.gmail.com>
 <7vy5s7idxb.fsf@alter.siamese.dyndns.org>
 <20120213133957.GA4838@burratino>
 <CANYiYbHkbUvL-d4M0iOyE5F-6rM=swk_knGEFTr9HGBK6T9UDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Alexander Shopov
	 =?utf-8?B?KNCQ0LvQtdC60YHQsNC90LTRitGAINCo0L7Qv9C+?=
	 =?utf-8?B?0LIp?= <lists@kambanaria.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 13 16:56:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwyGZ-0007Ik-D7
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 16:56:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757039Ab2BMP4a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Feb 2012 10:56:30 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48567 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754117Ab2BMP43 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Feb 2012 10:56:29 -0500
Received: by iacb35 with SMTP id b35so4570246iac.19
        for <git@vger.kernel.org>; Mon, 13 Feb 2012 07:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=zdQtcx6o97Lp2CQDT6lwClh5Ij8PnMBQvHXYhYF7KYM=;
        b=aCJQXjZePRR/MjLMNw2Vh9gA/cJ0A8In89Q8y/d4WOAjLHn3L+zQKf0B1504ZM0rlW
         la5CbqWNVMSvotD3lVLaabQ/i7zotb5QPfkyewEJ/5pNeyN8Voma2ZwPCcieQH0AKNCy
         5SpPCB973c+dpbvBBV5V5FcT4Pydnn6Agf68o=
Received: by 10.42.19.65 with SMTP id a1mr22291573icb.48.1329148588651;
        Mon, 13 Feb 2012 07:56:28 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id h9sm28325581ibh.11.2012.02.13.07.56.27
        (version=SSLv3 cipher=OTHER);
        Mon, 13 Feb 2012 07:56:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANYiYbHkbUvL-d4M0iOyE5F-6rM=swk_knGEFTr9HGBK6T9UDg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190634>

Jiang Xin wrote:
> 2012/2/13 Jonathan Nieder <jrnieder@gmail.com>:

>> I wonder if there's a simple to ask the gettext tools to make a po
>> template including strings from both 'maint' and 'master'. =C2=A0(Ha=
ckish way
>> demonstrated below.)
>>
>> Hopefully that would make it easier for translators to keep both
>> tracks well maintained at the same time.
[...]
>> What do you think?
>
> Translators on a new language may not like this. Translating the obso=
lete
> messages in pot file is boring and waste of time.

Right, doing this for real require somehow removing stale messages,
too, so the pot file would only contain messages from actively
maintained releases (the tip of 'master' and 'maint').

Will experiment privately a little more.
