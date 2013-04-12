From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 02/12] pretty: share code between format_decoration and show_decorations
Date: Sat, 13 Apr 2013 09:36:02 +1000
Message-ID: <CACsJy8CmzuDxCPebMaEkmF=u3xA4wXq2ydRMiU_rNsy1Pr411w@mail.gmail.com>
References: <1363400683-14813-1-git-send-email-pclouds@gmail.com>
 <1364636112-15065-1-git-send-email-pclouds@gmail.com> <1364636112-15065-3-git-send-email-pclouds@gmail.com>
 <7vd2uejfxr.fsf@alter.siamese.dyndns.org> <515E83EF.3070609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 13 01:36:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQnWH-0008K9-Eq
	for gcvg-git-2@plane.gmane.org; Sat, 13 Apr 2013 01:36:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753871Ab3DLXgd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Apr 2013 19:36:33 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:64952 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753794Ab3DLXgd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Apr 2013 19:36:33 -0400
Received: by mail-oa0-f50.google.com with SMTP id n1so3017759oag.37
        for <git@vger.kernel.org>; Fri, 12 Apr 2013 16:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=UAosm19NTwKBFAB030a6vHwSncSvvTBS/D5Azk6SLVw=;
        b=I7rkKfiTCLndIrwVovrM8rSvoZw3c3gCLKbTCUN2sRFYz85Cemkg+hM4N4J+L+1392
         03xn1mO73gxIcS4QSB8Fev1lciiRleKGFe+U71YeLnJWNeNHm6Lv8TERb+soF8SGY9i0
         IJCLZPN/s1/P9td9c99uCoC5iUbsrMQ+LmOdd0dlYyBUUOpS6oHbN4b+WdmJm51tUnQy
         izoceJjvk5l0c0HnIrFy3fYXlQwU98FYaP70N7gwuFti/eutxT4sXteRzLB8kMCQcOnK
         K99fJTWeR0rflN5Gz2vmnQaJ9HvZxzLvaeP6VKI0Kn++wb0XUIhh/j49JJRbyeJyMl70
         l+DQ==
X-Received: by 10.182.19.168 with SMTP id g8mr606019obe.21.1365809792633; Fri,
 12 Apr 2013 16:36:32 -0700 (PDT)
Received: by 10.76.27.137 with HTTP; Fri, 12 Apr 2013 16:36:02 -0700 (PDT)
In-Reply-To: <515E83EF.3070609@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221040>

On Fri, Apr 5, 2013 at 6:57 PM, Jakub Nar=C4=99bski <jnareb@gmail.com> =
wrote:
>>> +void format_decoration(struct strbuf *sb,
>>> +                   const struct commit *commit,
>>> +                   int use_color);
>>
>> I think you can fit these on a single line, especially if you drop
>> the unused variable names (they help when there are more than one
>> parameter of the same type to document the order of the arguments,
>> but that does not apply here).  That would help people who run
>> "grep" on the header files without using CTAGS/ETAGS.
>
> Well, I think "int use_color" should be left with variable name,
> don't you think?

I don't care too much about this. If Junio does not respond, I'll
leave the names in place (in one long line).
--
Duy
