From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH] Avoid the use of backslash-at-eol in pack-objects usage 
	string.
Date: Thu, 17 Sep 2009 19:06:41 -0300
Message-ID: <a4c8a6d00909171506l6c4b6a49i22d7b337a0c6cfa2@mail.gmail.com>
References: <1253224300-18017-1-git-send-email-tfransosi@gmail.com>
	 <7vvdjhgrjv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 18 00:06:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoP7p-0001HL-Hn
	for gcvg-git-2@lo.gmane.org; Fri, 18 Sep 2009 00:06:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbZIQWGk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Sep 2009 18:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751003AbZIQWGj
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Sep 2009 18:06:39 -0400
Received: from mail-yx0-f199.google.com ([209.85.210.199]:36622 "EHLO
	mail-yx0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845AbZIQWGj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Sep 2009 18:06:39 -0400
Received: by yxe37 with SMTP id 37so274591yxe.33
        for <git@vger.kernel.org>; Thu, 17 Sep 2009 15:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xGInW9DkOiZvWjSyxqqaVLx3xc74H45sxB5WtRFvrfE=;
        b=Q8nHbFpct9T8Fv5QJy1AKVpVazpLYn89gibjrwU/rvBDHFP4MLWDm5mzccZbI16R1D
         03wAw70ho01g418C03CbwC4DEXjr+6Zwo+v6hB5dEQmes9EIIQCB5nBiWgJ+yFMTz45s
         ZZxi9mAWNiKaYB+2msawOk6a6kg0a3bQkCSPg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qdXMN2em39EqIByfcYE7cEX7WW7Hg0Shq8Gx5TI9MqTrcVUmIiA0RddbxThhPhY6EZ
         EWHMELwsnoWY5laH9v/2U6KGipiviLCd+F1RyQPOJcrmOd8zBpPs2kNMUyeKn+82Qst1
         JpTmMfowE9Wit4CwlSaMg4pPh+szR/0CsDdUk=
Received: by 10.101.27.20 with SMTP id e20mr689540anj.137.1253225202721; Thu, 
	17 Sep 2009 15:06:42 -0700 (PDT)
In-Reply-To: <7vvdjhgrjv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128776>

On Thu, Sep 17, 2009 at 7:00 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Thiago Farina <tfransosi@gmail.com> writes:
>
>> +static const char pack_usage[] =3D
>> + =A0"git pack-objects [{ -q | --progress | --all-progress }] \n"
>> + =A0" =A0 =A0 =A0 =A0[--max-pack-size=3DN] [--local] [--incremental=
] \n"
>> + =A0" =A0 =A0 =A0 =A0[--window=3DN] [--window-memory=3DN] [--depth=3D=
N] \n"
>> + =A0" =A0 =A0 =A0 =A0[--no-reuse-delta] [--no-reuse-object] [--delt=
a-base-offset] \n"
>> + =A0" =A0 =A0 =A0 =A0[--threads=3DN] [--non-empty] [--revs [--unpac=
ked | --all]*] [--reflog] \n"
>> + =A0" =A0 =A0 =A0 =A0[--stdout | base-name] [--include-tag] \n"
>> + =A0" =A0 =A0 =A0 =A0[--keep-unreachable | --unpack-unreachable] \n=
"
>> + =A0" =A0 =A0 =A0 =A0[<ref-list | <object-list]";
>
> Do you still want to keep the trailing whitespace on these lines?
I did this to maintain the same output of the old string, but if you
want I can change, what you suggest?
