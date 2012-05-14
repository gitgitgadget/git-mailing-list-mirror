From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v5] completion: add new __git_complete helper
Date: Mon, 14 May 2012 16:38:10 +0200
Message-ID: <CAMP44s380rQtpDesBA5N8EWd5TUZDFMKaXgyTVoZb390aKqdGg@mail.gmail.com>
References: <1337009718-1164-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 14 16:38:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1STwPh-0000td-Br
	for gcvg-git-2@plane.gmane.org; Mon, 14 May 2012 16:38:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754136Ab2ENOiN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 May 2012 10:38:13 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:61150 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752402Ab2ENOiM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2012 10:38:12 -0400
Received: by lbbgm6 with SMTP id gm6so3352371lbb.19
        for <git@vger.kernel.org>; Mon, 14 May 2012 07:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=DJgDVwe1HrEgsvIRFrbsB5loU+2y7XqQiaWixXZCsW4=;
        b=V/yizW8RAVvk+F5oTC+HqfEO14Ac1ybskBLp4V4UCo7xnovwMl7bIk4fpMIXe1ZcUL
         S+z/+DDw0CTjL3MPiLBXXghCsVMW5PustnvMH85gIhULxLfgTFzX1Tuxfqt+EsmOquh/
         mrNFu3U5l/x6puj9AfPJamfCj2qURbi5F+dTBIKK1DSYLTQDUnMSrtE5cr1AAyqRAtaa
         ldZP0BrIar/Sr0dW2HYopL7MZuZ2eQcKsPi8lpniS8KpN76sDh3Kt/6/SPnAm/LdOLJT
         Yq4VKET+iXQ+aOpNUXNct5Vm1DwZRbyQwG8lH4eYlStic6XQXZD/dErZ+/uv9mwXdCum
         cOOQ==
Received: by 10.152.104.171 with SMTP id gf11mr464893lab.5.1337006291120; Mon,
 14 May 2012 07:38:11 -0700 (PDT)
Received: by 10.112.107.65 with HTTP; Mon, 14 May 2012 07:38:10 -0700 (PDT)
In-Reply-To: <1337009718-1164-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197772>

On Mon, May 14, 2012 at 5:35 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> This simplifies the completions, and would make it easier to define
> aliases in the future.

Since last version:

I renamed the wrapper function so they would end up as __git_wrap_foo,
and got rid of all the convenience to avoid specifying the prefix of
the functions; this function is not intended to be used outside git
anyway.

-- 
Felipe Contreras
