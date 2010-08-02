From: "Joel C. Salomon" <joelcsalomon@gmail.com>
Subject: Re: Back-dating commits--way back--for constitution.git
Date: Mon, 2 Aug 2010 14:41:06 -0400
Message-ID: <AANLkTi=O1qw=xeP3v4X+Yqrb1884azbxLDxFz3PUj=9a@mail.gmail.com>
References: <i372v0$3np$1@dough.gmane.org>
	<20100802183420.GN25268@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Aug 02 20:41:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ofzwr-0001Ac-FP
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 20:41:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754348Ab0HBSlM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Aug 2010 14:41:12 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:48438 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754109Ab0HBSlL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Aug 2010 14:41:11 -0400
Received: by wyb39 with SMTP id 39so3570921wyb.19
        for <git@vger.kernel.org>; Mon, 02 Aug 2010 11:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=TFfF2u04AupXtOOngrUf9ODMjO/iW7HYMEmUeTUp/+c=;
        b=wQFsnucgRlCeZ0+RyxQ8Er5iWOKb/Is3TBlc36y680SE8P9XxH2UewPYSgTxM2dYtU
         aKrh+PCRVaNavJOGpx5ZdSq019VfOmZYg1ixvLmWscnZ8hsCr+hM28Y1S4YkLhc69x0B
         oLGp1UrNr9dQ7fm3oo0sC+3XaeAgzesUofUWc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DJ0+bVRsI7WjdZ3Jbag80s7rINt/yEzKE0jj5Vf8/Zcn554CLyqSC/XaT49fy27ho1
         u7O8SIBROPsx1ZdUC2cOh8dXV/jLSEq1gJGJzHrOX+IlC2RjBsiDRvicHBVYaYD7Bibz
         7Oi2SEb5tOmZkwqFkWlHDNqi0He69kYbyLlIU=
Received: by 10.227.72.141 with SMTP id m13mr5288494wbj.143.1280774468917; 
	Mon, 02 Aug 2010 11:41:08 -0700 (PDT)
Received: by 10.216.38.140 with HTTP; Mon, 2 Aug 2010 11:41:06 -0700 (PDT)
In-Reply-To: <20100802183420.GN25268@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152435>

On Mon, Aug 2, 2010 at 2:34 PM, Shawn O. Pearce <spearce@spearce.org> w=
rote:
> "Joel C. Salomon" <joelcsalomon@gmail.com> wrote:
<snip>
>> =C2=A0 =C2=A0 =C2=A0 $ git commit --author=3D"The Philadelphia Conve=
ntion <>" \
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0--date=3D"Mon, 17 Sep 1787 12:00:00 EST"
>>
>> but that's not actually setting the commit date to 1787.
>>
>> Am I doing something wrong, or is Git (quite reasonably) unable to
>> accept commit dates that far in the past?
>
> Its probably running into problems with time_t on your system being a
> 32 bit value, and thus having trouble going before some time in 1901.

I was afraid of that.  Oh, well.

Thanks,
--Joel
