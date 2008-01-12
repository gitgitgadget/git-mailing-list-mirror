From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] Teach remote machinery about remotes.default config variable
Date: Sat, 12 Jan 2008 14:34:48 -0500
Message-ID: <47891658.3090604@gmail.com>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com>	<1200022189-2400-2-git-send-email-mlevedahl@gmail.com>	<7v1w8o4ws0.fsf@gitster.siamese.dyndns.org>	<30e4a070801111252s4e17b9c4m62adeb9032963e66@mail.gmail.com>	<7v63xzzszp.fsf@gitster.siamese.dyndns.org>	<478855B5.9070600@gmail.com>	<7vbq7ry405.fsf@gitster.siamese.dyndns.org>	<47885B2C.8020809@gmail.com>	<7v7iify2wm.fsf@gitster.siamese.dyndns.org>	<4788BFA8.2030508@gmail.com> <7vwsqeubj8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 20:35:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDm8X-0006H2-Rc
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 20:35:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755019AbYALTey (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 14:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755266AbYALTey
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 14:34:54 -0500
Received: from ag-out-0708.google.com ([72.14.246.245]:34751 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754924AbYALTex (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 14:34:53 -0500
Received: by ag-out-0708.google.com with SMTP id 23so1087673agd.10
        for <git@vger.kernel.org>; Sat, 12 Jan 2008 11:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=tC6Gk78OewYrZxEUTE3yxJrmWq5YKTABKxB/+x0kWy4=;
        b=Zh9nTF7cWqYvgL4td5sDy15K8h9RoQjpcZ7PYM/kdF3Qrp57J5DLe63Tthyw3pNU/otzFfnWtmkBng4mzmrTiaRcTDscHPylGoaSWhrgmXpHW2IVSbv9VzC/smTLYZMSuvhBbKsEYsdFIUSGHguyhFGcgyu7lOkCuFbfxq0lh00=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=XTeKZklhkYrxsC8CBOwOnirah5vZ08AD3CQwvzfj0JSM+4oDG9HrRkqG7c+j27RLbs75mpL7PozGDglB/ObSK0kKu/8fnKZbLKTVrSk50aWR/+Y2vUzjAK8q9PnbOpSYdkziUMSYQM855MwQoW4hBHtIPi4WnmrxbA0KVBSgVl8=
Received: by 10.100.123.4 with SMTP id v4mr9933993anc.99.1200166490781;
        Sat, 12 Jan 2008 11:34:50 -0800 (PST)
Received: from ?192.168.1.117? ( [71.163.17.196])
        by mx.google.com with ESMTPS id c2sm6284566ana.4.2008.01.12.11.34.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 12 Jan 2008 11:34:49 -0800 (PST)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <7vwsqeubj8.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70355>

Junio C Hamano wrote:
> Ahh.
>
> Does that suggest the new configuration thing is only about the
> "submodule update" command, not "remotes.default" that affects
> how the non-submodule merge and fetch works?
>
>   
Yes - this patch set was inspired by the single question of "how do I 
avoid needing to define origin as opposed to a server-specific nickname 
now that I am using sub-modules?"

Mark
