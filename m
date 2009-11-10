From: =?UTF-8?Q?Bj=C3=B6rn_Gustavsson?= <bgustavsson@gmail.com>
Subject: Re: [PATCH 6/8] builtin-fetch: add --prune option
Date: Tue, 10 Nov 2009 10:49:21 +0100
Message-ID: <6672d0160911100149k6d89ba14rb94f25fe49fee75c@mail.gmail.com>
References: <4AF92133.6070005@gmail.com>
	 <7vfx8mg3mw.fsf@alter.siamese.dyndns.org>
	 <7vbpjag3as.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 10 10:49:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7nM8-0002h2-EP
	for gcvg-git-2@lo.gmane.org; Tue, 10 Nov 2009 10:49:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752895AbZKJJtT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Nov 2009 04:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751913AbZKJJtS
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 04:49:18 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:46195 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751271AbZKJJtS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Nov 2009 04:49:18 -0500
Received: by fxm21 with SMTP id 21so784564fxm.21
        for <git@vger.kernel.org>; Tue, 10 Nov 2009 01:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Rger2+xYJMW/ML/IIiMO55cw/PQbVpg2p9w/tKhRU68=;
        b=EO3g6/4OXJnQR8NuXFOKg+fcdIYX3Gr8cN4Wv11fzuk4DjYQ1Kt9JMfY6XslX33+GW
         DdDp5lubBaupoH67dKZkodDfxVEM0eEtuSoE0596nouYHK7YNQIsR+7IuehdbCldnWdM
         tEolsvzgBWjsr9HHy9NGmlU/+84na6webcXXc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=NPEs2aOZTMbvV7PGtDjuL0veLh/brlzQhpDzfBcHCkG4s7J6aC8Sv082J+NupnEXFt
         0CXEcXn0r/aIzcXiPYJRshJM0hO8egfSD2I0cB30SUOfEERqf2k5/xryRVjVMlC+0ygh
         NyZCuPq/D5KmvPdisIr/mMvK/w/jOcAv37XuQ=
Received: by 10.204.34.201 with SMTP id m9mr9865605bkd.77.1257846561933; Tue, 
	10 Nov 2009 01:49:21 -0800 (PST)
In-Reply-To: <7vbpjag3as.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132557>

2009/11/10 Junio C Hamano <gitster@pobox.com>:
>> Yuck...
>>
>> builtin-fetch.c: In function 'prune_refs':
>> builtin-fetch.c:500: error: implicit declaration of function 'get_st=
ale_heads'
>> builtin-fetch.c:500: error: initialization makes pointer from intege=
r without a cast
>> builtin-fetch.c:501: error: 'dry_run' undeclared (first use in this =
function)
>> builtin-fetch.c:501: error: (Each undeclared identifier is reported =
only once
>> builtin-fetch.c:501: error: for each function it appears in.)
>> make: *** [builtin-fetch.o] Error 1
>
> Ah, I know. =C2=A0You forgot the first one from Jay's series.
>

Off-by-one error when I ran format-patch. Sorry for that.

--=20
Bj=C3=B6rn Gustavsson, Erlang/OTP, Ericsson AB
