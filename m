From: "Dmitry Kakurin" <dmitry.kakurin@gmail.com>
Subject: Re: Windows support
Date: Wed, 25 Jul 2007 19:56:02 -0700
Message-ID: <a1bbc6950707251956h3db847c9v8db438f4c665b2cf@mail.gmail.com>
References: <a1bbc6950707250335m3d37d4farceffc50945e31f6c@mail.gmail.com>
	 <46A73015.7020306@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Steven Grimm" <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 04:56:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDtWL-0001ar-Ru
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 04:56:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756439AbXGZC4H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 22:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756285AbXGZC4G
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 22:56:06 -0400
Received: from rv-out-0910.google.com ([209.85.198.188]:42925 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756087AbXGZC4D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2007 22:56:03 -0400
Received: by rv-out-0910.google.com with SMTP id k20so15736rvb
        for <git@vger.kernel.org>; Wed, 25 Jul 2007 19:56:02 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dWGD4Nbyl1DP9LtkSiQpch+DtH22TbBtX94HVoS3ij90lcCaCFcUc2Q3Tbi7Z1JpT3bU9wEDwaZhoAm5AhL5roVjkrxr3k7NW1oY7mHUM1IN9jfdz4h3Aw5/gyT7/MUankovvBrFuvc2Vevcd01ydWI3AGNH9Z1XIOJGKtf6s+c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Tsh5lyCWkxo2tQ7Ux+334UTQxsRASDc813I4WkMggrJdhxQWfOZN3AamRJBtrqcmO0P6XOu7zJ4C4QNv2/Woac+M/Q78EvP4lhHX4Es7YGVSGPWs0MBX8+XBszJ0LnSaAqArKo5pktkEdZdpkBnWazGRcsMtL3YVdCKhMCf6VRI=
Received: by 10.141.34.12 with SMTP id m12mr414154rvj.1185418562641;
        Wed, 25 Jul 2007 19:56:02 -0700 (PDT)
Received: by 10.141.2.18 with HTTP; Wed, 25 Jul 2007 19:56:02 -0700 (PDT)
In-Reply-To: <46A73015.7020306@midwinter.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53749>

On 7/25/07, Steven Grimm <koreth@midwinter.com> wrote:
> > How serious are you guys about Windows support?
> Much (nearly all?) of the core git team never touches Windows, so they
> both have no selfish motivation to get it working well and no way to
> test their changes even if they decide to take it up for the greater good.

This actually answers my question (if it's true).
If core team is not interested in supporting Windows then I cannot
trust this system with my source code :-(.

My concerns are (mostly):
* lack of (or insufficient) testing for Windows platform
* possibly lower code quality of Windows port, since core devs don't
touch it and don't care
* possible troubles with support if issues arise
* Windows port could become abandoned if those few brave people, who
work on it right now will leave

In short, all kinds of issues associated with software not being a
first class citizen :-).

- Dmitry
