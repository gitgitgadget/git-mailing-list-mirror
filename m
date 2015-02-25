From: =?windows-1252?Q?Jean-No=EBl_Avila?= <avila.jn@gmail.com>
Subject: Re: Internationalization and yes/no prompts
Date: Wed, 25 Feb 2015 10:42:15 +0100
Message-ID: <54ED98F7.1040207@gmail.com>
References: <20150212085211.9112780692@smtp-out.fingerprint.fr>	<54EB4B3F.6080706@fingerprint.fr> <xmqq1tlfqcd8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Pierre-Olivier Vares <pierre-olivier.vares@fingerprint.fr>
X-From: git-owner@vger.kernel.org Wed Feb 25 10:42:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQYU5-0003jv-73
	for gcvg-git-2@plane.gmane.org; Wed, 25 Feb 2015 10:42:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752735AbbBYJmU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Feb 2015 04:42:20 -0500
Received: from mail-we0-f178.google.com ([74.125.82.178]:39788 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751682AbbBYJmT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2015 04:42:19 -0500
Received: by wesx3 with SMTP id x3so2394037wes.6
        for <git@vger.kernel.org>; Wed, 25 Feb 2015 01:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Qm9lAgI9rRStku4daPoViQvy0Yn6q95h8wG3D4ciK2g=;
        b=H0T0wmrwyOU8QyduIDEajpSHR9DkNrMlK3XZmj+dgB2rQZMLDLpUrCf0k73/ogrReB
         Fuk4l0hTJ2ZyBWzjfcOYj1rpLVPmC8nnfxwUpd/AAw19lBdqYIO2LS2w8pqVAuo/5gse
         d4sJPeiDQxzEUbSZ5M+femVQvYSQdmNVr4Lo8F0iNdPQQEtH24VAWEzISsbh2QmaApdn
         mcGj38e3WbFIhhTEyGlXyOx2+nAERnl51HQ1KjRMkwluRj+IxhIjmjSQog6B/HkOAf1T
         VA8vE3ik1WemLYsmEuiCZ5HnpLWcVkbmu6m279JfpHBnZPh+Le5PZPaOriSAJqgSIzND
         I9ZA==
X-Received: by 10.194.108.162 with SMTP id hl2mr4285909wjb.81.1424857337719;
        Wed, 25 Feb 2015 01:42:17 -0800 (PST)
Received: from [192.168.1.101] (static-csq-cds-097114.business.bouyguestelecom.com. [164.177.97.114])
        by mx.google.com with ESMTPSA id uo6sm64021193wjc.49.2015.02.25.01.42.16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Feb 2015 01:42:17 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <xmqq1tlfqcd8.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264374>

Le 24/02/2015 21:32, Junio C Hamano a =E9crit :
>> - explicitly put "y/n" in the message. Translaters should be warned =
to
>> let "y/n",
> This may be suboptimal from the end-user's point of view, but it is
> the least risky of breaking anything.
>
> And it is way better than the status quo.
>
>

I can push a small update for this one.

The "yes" string could be translated in builtin/clean.c

Are there other places where a translated part asks explicitly for a
yes/no reply? It is not clear from the content of the po file.

BR

Jean-No=EBl
