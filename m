From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 16/16] add: avoid yoda conditions
Date: Thu, 31 Oct 2013 13:56:35 -0600
Message-ID: <CAMP44s3adv0MKeuYU1D1B-kdtWvyN4Dr9-ee_xrtdnAOYaHhGw@mail.gmail.com>
References: <1383211547-9145-1-git-send-email-felipe.contreras@gmail.com>
	<1383211547-9145-17-git-send-email-felipe.contreras@gmail.com>
	<CANiSa6i5z8Z9HPzsUWTh8U2HXc9p6MPgQjJ7K6KSDw8FXtFyww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 31 20:56:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbyMD-0008Qo-Pp
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 20:56:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755202Ab3JaT4h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 15:56:37 -0400
Received: from mail-lb0-f181.google.com ([209.85.217.181]:62698 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753605Ab3JaT4h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 15:56:37 -0400
Received: by mail-lb0-f181.google.com with SMTP id x18so2828056lbi.12
        for <git@vger.kernel.org>; Thu, 31 Oct 2013 12:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=LzVgim2TkAvTseJpQC62z8Ig4KUcuZdTzIWjfORrDME=;
        b=Ofh9IJpcIPdFGQirb2+/fUuTNQvejAikcVeA8Q6XzIn6unNbRoMTaFZoiB0PlMWwLd
         rJIXXfs5MTcUHUL0aeoADOEZXsCoYtaIDhtQM+ZErJiUD1TynSaO3kYMwYI0Giu+q6/i
         GgZKl/s51dYY6n2IJ5n5Hd58twD63IpVG2dGGbXMeT8C4I5WKvYHWYPlx44q7Ici601t
         CX8vY+o0qapc729E1+WYBsLuQEulyP14aePDbpP6uqnxajLWaoXGCZtZ0V3aI4UqyWd0
         FFK64Dw8riZTQjqkWPlbjtdR3b1NsJX0XpYFDe61zIJnWSsjM355ahdYUgmSELV3AVDu
         P74Q==
X-Received: by 10.152.180.139 with SMTP id do11mr3078554lac.23.1383249395799;
 Thu, 31 Oct 2013 12:56:35 -0700 (PDT)
Received: by 10.114.201.69 with HTTP; Thu, 31 Oct 2013 12:56:35 -0700 (PDT)
In-Reply-To: <CANiSa6i5z8Z9HPzsUWTh8U2HXc9p6MPgQjJ7K6KSDw8FXtFyww@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237174>

On Thu, Oct 31, 2013 at 1:48 PM, Martin von Zweigbergk
<martinvonz@gmail.com> wrote:

> I guess what I'm trying to say is that either we accept them and get
> used to reading them without being surprised, or we can change a bit
> more than one at a time perhaps? I understand that this was an
> occurrence you just happened to run into, and I'm not saying that a
> patch has to deal with _all_ occurrences. I'm more just wondering if
> we want mention our position, whatever it is, in CodingGuidelines.

Yes, I'm all in favor of updating CodingGuidelines with that.

-- 
Felipe Contreras
