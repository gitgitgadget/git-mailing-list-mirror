From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 38/42] Remove all logic from get_git_work_tree()
Date: Fri, 29 Oct 2010 10:09:38 -0700
Message-ID: <AANLkTim-uW4Esk1bkPzNNGRb8svZoNwCUvXF3Fqb4QmR@mail.gmail.com>
References: <1288334934-17216-1-git-send-email-pclouds@gmail.com> <1288334934-17216-39-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 19:10:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBsSs-00038i-21
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 19:10:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934143Ab0J2RKA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Oct 2010 13:10:00 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:36268 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932342Ab0J2RJ7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Oct 2010 13:09:59 -0400
Received: by yxk8 with SMTP id 8so1782142yxk.19
        for <git@vger.kernel.org>; Fri, 29 Oct 2010 10:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=dLDAAZ0kTNCIYOVlitcw1JplNc5GAxND8oJQNQXPWYA=;
        b=Mzk4dtGmTpW48SvCzDpfoHnb7bPvcUoKcM2BvPovZP17RKL9mD2FuX7JozWgwfCUcw
         Zope5NDJvNMf6v2oMKn9D4WOdieG0TVz9EBbhswjXEJNNWYRfsC+qk0hc/kmKXI+xlP4
         VyPbCP5TAXHI4KWBfm5EW9Y3mH9MOlx2+Q7Xw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=OoANWbvCH7P9/HD3WDkN3X9F6FMyCQM0Drs+LDwAk01tz7ylrbXdvI2TFhQGdh02pc
         5uMwH/MS6hQPA2LjIy7DNUFM9UPxq9YCj9ldRRmJa8pYbHdpUaJkAMDb4JcFY67qS+SR
         7qSn3o9HwuhXC6GPzV3ah9VevFhLr7Yy6qXaQ=
Received: by 10.150.177.7 with SMTP id z7mr10283300ybe.433.1288372198482; Fri,
 29 Oct 2010 10:09:58 -0700 (PDT)
Received: by 10.151.45.12 with HTTP; Fri, 29 Oct 2010 10:09:38 -0700 (PDT)
In-Reply-To: <1288334934-17216-39-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160344>

Heya,

2010/10/28 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com=
>:
> This helps break things some more. Eventually all repo setup logic
> should be centralized in setup_* functions. This helps push all the
> bugs back to setup_* functions.

I don't know about this, do we really want to willingly break the test
suite (and fixing it later)? Perhaps we can review this as-is and then
squash the commits before they are merged to next so that there is no
breakage? We could even attach the original commits as notes :).

--=20
Cheers,

Sverre Rabbelier
