From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Massive repository corruptions
Date: Tue, 13 Jul 2010 05:40:58 -0400
Message-ID: <AANLkTimQPv5MhLo4wwVTt2LiaWxqWwoYykEbz3wBS-OY@mail.gmail.com>
References: <20100713015600.GA29392@nibiru.local> <AANLkTilXQ3VgPjihf0pjt4QPN-nCjwAWyHwoosLMeRpH@mail.gmail.com> 
	<20100713050350.GB29392@nibiru.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: weigelt@metux.de
X-From: git-owner@vger.kernel.org Tue Jul 13 11:48:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYc6j-0003IK-K7
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 11:48:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755184Ab0GMJsv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Jul 2010 05:48:51 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:36111 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754552Ab0GMJsu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Jul 2010 05:48:50 -0400
Received: by yxk8 with SMTP id 8so1151707yxk.19
        for <git@vger.kernel.org>; Tue, 13 Jul 2010 02:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=IOwgF1r0Ll3IJapna/E4TcFQ4iZpX3/SNRH7JxxtaU4=;
        b=FDr5CAeXx0b7qi4TnN5FEVwBy6TMexPfmqysFXIXQZqa3OlFEJBiEVfsYBd/YpH8mS
         aKj6SKVj7irP/O8OupQALU2Ldbcxp8oGzxShgm6XK48XrD29OzL7NkZtRlkglq7ujB51
         nN/FD6Hvg9+4LFMhjEQKkE6xs8f4t/npU4jwo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=J1Ixb2CY1ykPazaQIf+Zy+SUVBqgNavGOSgmdrnN6JMsyEkt0drHb2Sdesh1GD/Ve9
         BlyZClKxKNBwVZ71LDdcGkN09Ap4p3GkNvq78bmQPZlZzp5z1h8AfLpd5AqvAY/X4nAz
         NNz0AJRAVOVorOaF7dFZ5vx4PXoKAkFZ3MD6o=
Received: by 10.150.62.3 with SMTP id k3mr6372697yba.95.1279014078210; Tue, 13 
	Jul 2010 02:41:18 -0700 (PDT)
Received: by 10.151.85.19 with HTTP; Tue, 13 Jul 2010 02:40:58 -0700 (PDT)
In-Reply-To: <20100713050350.GB29392@nibiru.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150893>

On Tue, Jul 13, 2010 at 1:03 AM, Enrico Weigelt <weigelt@metux.de> wrot=
e:
> * Avery Pennarun <apenwarr@gmail.com> wrote:
>> Do you know which packfiles are corrupted? =A0Does 'git index-pack' =
on
>> the files reveal anything?
>
> git@blackwidow ~/metux/work.git/pack $ git index-pack pack-3b6cbd5dc5=
f54cf390cfaa479cac6a99d7401375.pack
> error: inflate: data stream error (incorrect data check)
> fatal: pack has bad object at offset 37075832: inflate returned -3
>
> (that's essentially the same git-gc says)

What's the size of that .pack file?

Avery
