From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH v3] Trivial fix: Make all the usage strings to use the 
	same pattern.
Date: Tue, 22 Sep 2009 16:55:30 -0300
Message-ID: <a4c8a6d00909221255i2f45e19ex95a13b027886d3e4@mail.gmail.com>
References: <1253639330-9185-1-git-send-email-tfransosi@gmail.com>
	 <7vocp2ssv4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 21:55:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqBSb-0003t7-Nh
	for gcvg-git-2@lo.gmane.org; Tue, 22 Sep 2009 21:55:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952AbZIVTz2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Sep 2009 15:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbZIVTz2
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Sep 2009 15:55:28 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:33621 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750707AbZIVTz1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Sep 2009 15:55:27 -0400
Received: by fg-out-1718.google.com with SMTP id 22so33346fge.1
        for <git@vger.kernel.org>; Tue, 22 Sep 2009 12:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ImUwWDQFWh/u8ABJ4bHV30ylM+pSvisJrk4Xs2k2HL0=;
        b=NBZuN3dTqHqX+2XiYa7X7YXpK7gCyYutR+dbiOA6yVGR6W16RZdRVbVRV2Txt8FDUm
         +xnhYuq7ka/fgAZYl6hC9Wyhk7o2BCLr+5N5tZ9dO9ovjnFeCzjQykGATXqQNFNVn3Jt
         mz/uoIPQVKGDZiRgUCmGLty6UE3F2vnSFopTw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DaYbrHRfRDYRJfHhq61YwWHxU6yMimTXlKFtioKkMhMnc9QM7FjxlPwSCXkhps7iXJ
         clZHiN2/2KAyaBBunAJ4Kf0obBJftCCwPb4tZlYkHm6Lxj379yIZUoJKoO7+E1KsC2Q0
         lHAAOTSdpQ72cfFduml10vqtHmHHeRnAqWI0s=
Received: by 10.86.243.15 with SMTP id q15mr1261017fgh.21.1253649330183; Tue, 
	22 Sep 2009 12:55:30 -0700 (PDT)
In-Reply-To: <7vocp2ssv4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128956>

On Tue, Sep 22, 2009 at 4:05 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> What does this _fix_?
The answer here is nothing. But I think the benefit is to a have a
pattern, but if it is _not_ desired, I can stop here.

> I see v2 and v3 were posted 15 minutes apart. =A0People need to check=
 both
> to see what changed, and that also adds to the cost.
>
> Please slow down.
I sent the v3 to fix my mistake: api-builtin.txt to api-parse-options.t=
xt
You are right, I have to slow down here.
>
> I do not mean "please slow down working on your patch, and instead sp=
end
> time somewhere else". =A0I mean "please spend more time rre-re-re-rev=
iewing
> what you are going to send." =A0If you did so, externally it would lo=
ok as
> if you slowed down ;-).
As I said above, I can stop here if this is not a good change.

> Among the topics that are cooking in 'next', at least builtin-commit.=
c and
> fast-import.c have changes to overlapping areas this huge patch touch=
es.
> At least, exclude the changes to them from this patch, and make patch=
es
> separately for them. =A0That would make the cost of conflict resoluti=
on
> slightly smaller. =A0You need to also check with 'pu', but writing th=
is
> response has already made me exceed my git time for today.
If the answer above is yes (I can continue), I will separate it in a
bunch of commits(patches)  and I will check more careful before submit
another patch here.
