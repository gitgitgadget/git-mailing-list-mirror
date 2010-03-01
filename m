From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH 2/3] make union merge an xdl merge favor
Date: Mon, 1 Mar 2010 11:55:36 +0100
Message-ID: <36ca99e91003010255h5784f29dq81737a736639cac8@mail.gmail.com>
References: <972adf380be481b5e8d031481586e9c34da2cbb7.1267385538.git.bert.wesarg@googlemail.com>
	 <17999fdb3ff374156acb7fc670426265fa27b94b.1267385538.git.bert.wesarg@googlemail.com>
	 <7vwrxx2k29.fsf@alter.siamese.dyndns.org>
	 <36ca99e91002282257i7f07f035o15d8d64e062ee94e@mail.gmail.com>
	 <7vaausza8v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 01 11:55:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nm3Hs-0007CN-FA
	for gcvg-git-2@lo.gmane.org; Mon, 01 Mar 2010 11:55:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106Ab0CAKzj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Mar 2010 05:55:39 -0500
Received: from mail-fx0-f219.google.com ([209.85.220.219]:51877 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750764Ab0CAKzi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Mar 2010 05:55:38 -0500
Received: by fxm19 with SMTP id 19so557526fxm.21
        for <git@vger.kernel.org>; Mon, 01 Mar 2010 02:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5f3WWc7RhtJWmGBGfy4ncjGLi9eXYPVn1xazzl53FCE=;
        b=V1gpeRbCPms0uuRosr57OWRDJKo4Mwq/Iy5xkJ0nKBAOQtp9bwTrfyhCHMnm835qe2
         GLc/H37tM0OqxLMh56Hpb5fUJXXjr6ltG/uTukrBOFD2mkhOxa088GuxIqX5HSuy5+ju
         JhT6MaJy4rR14qVqrD+Qtt8d7ZIBiL7TfAKmI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=e/1MXU4QBQIp39bQD7sZqHw/rLhlz/aOf7GxiIIrkBUrQNNOALJ7IYdwW3PGeTC2rr
         TPrnsj25k70uANVDgJ62lu7B40wevorAw4Y4gyMoHAOQZks0eah8UZSwg14gx77HcuqS
         d3YwQyBKc++SuIqXMEV5wgYEW70ZNyuUXXSnw=
Received: by 10.223.5.92 with SMTP id 28mr4810663fau.26.1267440936358; Mon, 01 
	Mar 2010 02:55:36 -0800 (PST)
In-Reply-To: <7vaausza8v.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141315>

On Mon, Mar 1, 2010 at 10:01, Junio C Hamano <gitster@pobox.com> wrote:
> Bert Wesarg <bert.wesarg@googlemail.com> writes:
>
>> WIll do. On a side note: I plan to support the --union option also f=
or
>> git-checkout. Would that be a good idea?
>
> What does it do? =C2=A0Resolve conflicted paths using union merge at =
checkout
> time? =C2=A0That somehow feels like a dirty "because we can, and I on=
ly care
> about union" hack to me.

Point taken, I does not have a usecase by myself.
