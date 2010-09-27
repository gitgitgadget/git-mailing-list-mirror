From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Encoding problem on OSX?
Date: Sun, 26 Sep 2010 21:31:22 -0500
Message-ID: <20100927023122.GA8802@burratino>
References: <20100809234620.GA6418@burratino>
 <AANLkTikqpYO9GG9PZD_==PyUSGRV8=L5LrZ0RVsESuXN@mail.gmail.com>
 <20100811075503.GD5450@burratino>
 <AANLkTin1bspb+bzt6P1Fz7Q11=F2ZBftC19XQuQqHL+B@mail.gmail.com>
 <20100811082953.GA16456@burratino>
 <AANLkTim5Z7M0CypudaGtb2UuON5ajf3Xn=hz6oAJwv8w@mail.gmail.com>
 <20100811084443.GF16495@burratino>
 <AANLkTinS0BeHWNJ0mCtTbVRz=7FBwE0_OTKDfS2gPXdN@mail.gmail.com>
 <AANLkTi=sBNmMoZmqO_-AFNO6bVqtJmXbdXYUf7-bKars@mail.gmail.com>
 <20100811092311.GA16901@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?xLBzbWFpbCBEw7ZubWV6?= <ismail@namtrac.org>,
	Richard MICHAEL <rmichael@leadformance.com>
X-From: git-owner@vger.kernel.org Mon Sep 27 04:35:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P03ZH-0002mX-Hi
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 04:35:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758202Ab0I0CeW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Sep 2010 22:34:22 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:57903 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758174Ab0I0CeV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Sep 2010 22:34:21 -0400
Received: by qyk33 with SMTP id 33so7094631qyk.19
        for <git@vger.kernel.org>; Sun, 26 Sep 2010 19:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ULIkNmLYCmlYQD/TP27hXgTWQBwssX8Dx+4bPlhYSBk=;
        b=eNOTD/vWzMZtASbyuw8Goqcc4i8Rvak81W8gjG2224vR2e7K3qaI+cPJFfHHX3nHBT
         ayrsBzNTjA5WfYplpdajk2O9iz4qaxK7c53b/H35B2RDtgWQvkJLfHSxRmg0hDl2/TdF
         +3msYXAkRyT/lVSSJC5tex9DpuvjHbITWtPE8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=iDo5u9hs9w2Ai+Cc3KCCTGUS5KkrIVZ1aPfrVNBwTXWMBflkLq1A2OfPp4tstNGIz2
         xKHmL0JfyCNZY7+l/ytR7ura/QTzrIgMoxi0nLBkuFa7fw5W2KmuSO0ti1qCBqx/JsUR
         GLueXVJIiGzY70SVw3QjT58R5yMEfgOZSdrVE=
Received: by 10.220.161.201 with SMTP id s9mr2320406vcx.277.1285554860233;
        Sun, 26 Sep 2010 19:34:20 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id e31sm3254016vbe.19.2010.09.26.19.34.18
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 26 Sep 2010 19:34:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100811092311.GA16901@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157287>

Hi again,

=C4=B0smail D=C3=B6nmez wrote:

> Downgrading my sed to v 4.1.5 fixed the issue.

This is nicely explained here:

 https://www.opengroup.org/sophocles/show_mail.tpl?source=3DL&listname=3D=
austin-group-l&id=3D14595

It looks to be a Mac OS libc misfeature.  Could you two lobby Apple to
get this fixed? :)

Thanks again for the reports.
