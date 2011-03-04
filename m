From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH/RFC] init, clone: support --real-git-dir for .git file
Date: Fri, 4 Mar 2011 11:33:13 +0700
Message-ID: <AANLkTik3A3x=L-nuXrnmp6Zpxs+AB2ig2zY4KxJpUFBf@mail.gmail.com>
References: <1299156201-12149-1-git-send-email-pclouds@gmail.com>
 <7v8vwv927a.fsf@alter.siamese.dyndns.org> <buozkpb8qvn.fsf@dhlpc061.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Fri Mar 04 05:33:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvMi5-0003kL-Ez
	for gcvg-git-2@lo.gmane.org; Fri, 04 Mar 2011 05:33:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758545Ab1CDEdp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Mar 2011 23:33:45 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:51785 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758381Ab1CDEdo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Mar 2011 23:33:44 -0500
Received: by wyg36 with SMTP id 36so1760559wyg.19
        for <git@vger.kernel.org>; Thu, 03 Mar 2011 20:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=RqWPt2E/inE87BRovk2hzUbL7ix6kXAA8XHLZYFAzks=;
        b=npyn8lovDzyqTjV6RI5TMiwKvFPGaWFzn/57p0ynTPBa2pcQxfyw/+rmDUVEir3nvm
         n2WzDhcVvBqmwlZXy2zRwVwcLiazJ45blByHWsWrlR2NgBVCpAzcm0FTCatxRUcv4ktN
         FhZon8j91G4bkdG2MU1E0mXEs1lqoyDHZv898=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=mk1DvS0H160ci/S8Yejb5ngAtDW6yMJOLd78xLL1scbnfP47+ujyYsPdujqdbH38VH
         AxOe2Pm99NRs+XQLoU3xwAlRfWG97kdgK1PvWOb8pgbMyLK4GM1I86Utu+YGlQouZUs7
         N1MdE5ouhn2MKmUQQ4SasK4iWz3o4/3t0cbSs=
Received: by 10.216.82.13 with SMTP id n13mr147773wee.1.1299213223074; Thu, 03
 Mar 2011 20:33:43 -0800 (PST)
Received: by 10.216.239.5 with HTTP; Thu, 3 Mar 2011 20:33:13 -0800 (PST)
In-Reply-To: <buozkpb8qvn.fsf@dhlpc061.dev.necel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168427>

2011/3/4 Miles Bader <miles@gnu.org>:
> Junio C Hamano <gitster@pobox.com> writes:
>>> Instead of creating the repository at $GIT_DIR, --real-git-dir will
>>> tell git to put the repository there, then make $GIT_DIR a .git fil=
e
>>> that points to --real-git-dir.
>>
>> Just like you, I am also bad at naming things, so I cannot offhand s=
uggest
>> a better name, even though I _know_ --real-git-dir sounds horrible.
>
> --separate-git-dir =C2=A0?
>
> [Terms like "separate source dir" and "separate build dir" seems to b=
e
> common when talking about build systems, and it seems a somewhat
> similar situation -- separation of usually co-located information.]

Sounds good.
--=20
Duy
