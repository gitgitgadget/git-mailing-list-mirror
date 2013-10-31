From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 06/16] shortlog: add missing declaration
Date: Thu, 31 Oct 2013 13:33:34 -0600
Message-ID: <CAMP44s2zTFKeHxp0G1imLXdHfzao_DSY+mkm7awYedwYafFZ+w@mail.gmail.com>
References: <1383211547-9145-1-git-send-email-felipe.contreras@gmail.com>
	<1383211547-9145-7-git-send-email-felipe.contreras@gmail.com>
	<xmqqk3gt5kht.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 31 20:33:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vbxzv-0006sV-Op
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 20:33:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752984Ab3JaTdg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 15:33:36 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:61792 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752303Ab3JaTdf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 15:33:35 -0400
Received: by mail-lb0-f177.google.com with SMTP id u14so2742944lbd.22
        for <git@vger.kernel.org>; Thu, 31 Oct 2013 12:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=tJU0K7CCZ7FuwTsPRNBfRA9jGBwuR6Ns3gM5QRcB6jc=;
        b=sYuQ3YnKGJanCjJ1vQeEZlfc6FfED/QmGE6beKsg2RPyu0LSLlZ+ushTAUFfWOosDb
         tpw6fBktH65dJWjKMXuV4Fo/Fz1im+X7nDbstEY4YjwNByZZuMsCS85NAVPfZKmN5kUu
         D9fp4uKW9b/MxwhCyEu5sjLg4e5P5mEf5opKMNvhhCPrrMpHJ/RdwXC+nvyomsiUeNFm
         tt7BLQy4QiahwYJ+vObeG/UpdhUpMLBgGukNpJV8awxd+6nWMAtlneKX8gkBBg0zAPUU
         FC703zU33vJCnVP378BCH/pjVPBD+36Kknw97vt3HJitFHRVu9T0q6pkd120aF/taTlm
         YsQA==
X-Received: by 10.112.12.234 with SMTP id b10mr582687lbc.56.1383248014191;
 Thu, 31 Oct 2013 12:33:34 -0700 (PDT)
Received: by 10.114.201.69 with HTTP; Thu, 31 Oct 2013 12:33:34 -0700 (PDT)
In-Reply-To: <xmqqk3gt5kht.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237165>

On Thu, Oct 31, 2013 at 1:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Otherwise we would have to include commit.h.
>
> Was there a reason why commit.h is not included here, just like
> revision.h would include diff.h, so that users of shortlog.h do not
> have to worry about including commit.h themselves?

Because you can't do:

struct diff_options;
struct diff_options diffopt;

The storage size is not known, but you can do:

struct diff_options;
struct diff_options *diffopt;

-- 
Felipe Contreras
