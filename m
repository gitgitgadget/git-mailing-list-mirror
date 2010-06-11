From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: Git sideband hook output
Date: Fri, 11 Jun 2010 17:54:42 -0400
Message-ID: <4C12B0A2.4020205@gmail.com>
References: <AANLkTinLWDFTn7bhcF3Vk-q9aw4lJC2vFj95M9bxLbBT@mail.gmail.com> <20100608214632.GN14847@spearce.org> <A612847CFE53224C91B23E3A5B48BAC744839BF3DD@xmail3.se.axis.com> <alpine.LFD.2.00.1006090934320.30664@xanadu.home> <A612847CFE53224C91B23E3A5B48BAC744839BF6AE@xmail3.se.axis.com> <20100610183019.GR14847@spearce.org> <AANLkTikQQh4sUA7h2k1jvQ7aMgYyq7WFetJvJZvqpVxt@mail.gmail.com> <AANLkTikYBB1DsGRRsu4pSNr1j8fFXD-99c4lRAaBqd3M@mail.gmail.com> <3B9F4351-4608-455E-B433-A5337A946F8A@wincent.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: PJ Hyett <pjhyett@gmail.com>, Scott Chacon <schacon@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	git list <git@vger.kernel.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Fri Jun 11 23:55:00 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONCBo-0007PV-4a
	for gcvg-git-2@lo.gmane.org; Fri, 11 Jun 2010 23:55:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755233Ab0FKVyz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Jun 2010 17:54:55 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:62839 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752485Ab0FKVyy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jun 2010 17:54:54 -0400
Received: by gwj15 with SMTP id 15so1132144gwj.19
        for <git@vger.kernel.org>; Fri, 11 Jun 2010 14:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=Xr16QvpAfXKUo62wPptQFXo9yLp85NXVsKYjUa/cw0Y=;
        b=s0TISx5r5e6Jxvz3+4YU0yHN35D320pOWE3VwbvuzymWGi58VrGE55eUBl1COtuD1J
         sKVnFK6iJHJlY2hHj2EcBPRNMfyQZpAGQQM4cATDzDQ9etO9wO+EvJy2SdDBiiZvjpjw
         rxU92ty2pbURctwQRwuNOGZVm5aig8zetxSJo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=sqPT77m+f/lUtL2+sV+d/8PJyPZ1NNvN4EIwS1JDkItKivjc1HnzpXuCEp6DYv93p0
         M1vu4RxR4uqzKzggeNZ7qdPMQVA+7092hAaP2y3V6AG/5ZEtZSbpEy9tgNyZTKXye5Iy
         oa+RXFPHT64w7VtcP0QFZqcwrMYlkIrIZfhdo=
Received: by 10.151.95.31 with SMTP id x31mr4496889ybl.2.1276293292954;
        Fri, 11 Jun 2010 14:54:52 -0700 (PDT)
Received: from [10.0.0.6] (c-24-129-111-166.hsd1.fl.comcast.net [24.129.111.166])
        by mx.google.com with ESMTPS id j3sm12980514ybe.43.2010.06.11.14.54.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 11 Jun 2010 14:54:51 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <3B9F4351-4608-455E-B433-A5337A946F8A@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148972>

Wincent Colaiuta wrote:
> El 11/06/2010, a las 16:34, PJ Hyett escribi=F3:
>=20
>> Hi,
>>
>>> On Thu, Jun 10, 2010 at 8:30 PM, Shawn O. Pearce <spearce@spearce.o=
rg> wrote:
>>>> If its really a problem, maybe "remote: " prefix should turn into
>>>> something shorter and language agnostic, like "<< ".  But thus far
>>>> we hadn't had to worry about it, since we didn't have translation
>>>> support in Git...  (though yes, I see that is changing now).
>>>>
>> I'm also in favor of making the default '>>' instead of 'remote:' if
>> nothing isn't an option.
>=20
> Funny, as '>>' is basically meaningless. At least 'remote:' has seman=
tic value (ie. it indicates _where_ something is coming from).

Seconded.
