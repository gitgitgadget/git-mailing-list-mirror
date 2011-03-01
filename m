From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1.8.0] add: make "add -u" update full tree without pathspec
Date: Tue, 1 Mar 2011 21:15:21 +0700
Message-ID: <AANLkTikLJXyQH8au5SpfvAMgq3sA1PqKsG16GK0YcCFB@mail.gmail.com>
References: <1297045643-26697-1-git-send-email-pclouds@gmail.com>
 <7vei6t4uwa.fsf@alter.siamese.dyndns.org> <AANLkTi=BwTHRWcUu26VLWAhFupmuJpu8fvOF98--HJ5f@mail.gmail.com>
 <7vy6512rnb.fsf@alter.siamese.dyndns.org> <AANLkTimqBxhHBVzet9M-6AqiCp664hkroM9QWS_1SiLP@mail.gmail.com>
 <7vk4gkk5pd.fsf@alter.siamese.dyndns.org> <AANLkTimRuUdGsgkt63PspvNXXjusZeOJWMhSXQ5nS81t@mail.gmail.com>
 <7v1v2reywi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Sebastian Pipping <webmaster@hartwork.org>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 15:15:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuQMo-00032A-P4
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 15:15:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753369Ab1CAOPx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 09:15:53 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:35718 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752908Ab1CAOPw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 09:15:52 -0500
Received: by wyg36 with SMTP id 36so4694609wyg.19
        for <git@vger.kernel.org>; Tue, 01 Mar 2011 06:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=2cLHMmizfOyKw53nX63X+YSDJM7l5IAaj9NzMrWtSgw=;
        b=OmCS3cLkuyqXPoxKTO3/y8iuYMvLct3ckfWmsc6dN0FfRNoTDMo6eyCwdwnL1Un6mc
         JMR6U2fCSyXGWcc2q//jaBOFySSe2ol6XgbMsx+9SpqzdSen7kMzVKEziRB7WqWI9Edy
         eFZvLvNvPe+S/Er6aHyZQX7uCp8wJ8cRJL2Hs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=QIGWEqRI28lOtISspAfKUz/C0CWe8r7Ld6Guijk0MeyUMHQZeyWk/Z0wjFcmAuf0ed
         CQgVYQjzDZ/NRBZx1aGv6tVnRDTRgb56KC5iINaDueamAPepvJPiStnoCQfHQsRfQIQ1
         sYyCumT79pEqryndTQSLClYX1BE9AHExbR5OE=
Received: by 10.216.59.3 with SMTP id r3mr681498wec.28.1298988951143; Tue, 01
 Mar 2011 06:15:51 -0800 (PST)
Received: by 10.216.239.5 with HTTP; Tue, 1 Mar 2011 06:15:21 -0800 (PST)
In-Reply-To: <7v1v2reywi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168221>

On Tue, Mar 1, 2011 at 8:46 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> On Mon, Feb 28, 2011 at 1:56 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> But how many people may be impacted this way? ...
>> Or accept that evolution is painful and go with current plan, which I'm OK too.
>
> So even though you raised a concern on possible pains during the
> migration, you think that the migration plan outlined would be the
> least bad one?

I only see two ways. The 'new command' approach only delays the
transition until a later (user decided) point. There's no guarantee
that I (user) would make a good decision to switch. Plus the outlined
plan looks simpler. Yes, it seems better.
-- 
Duy
