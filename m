From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: GIT get corrupted on lustre
Date: Mon, 21 Jan 2013 14:29:14 +0100
Message-ID: <CABPQNSbJr4dR9mq+kCwGe-RKb9PA7q=SKzbFW+=md_PLzZh=nQ@mail.gmail.com>
References: <50D861EE.6020105@giref.ulaval.ca> <50D870A0.90205@interlinx.bc.ca>
 <50EC453A.2060306@giref.ulaval.ca> <50EDDF12.3080800@giref.ulaval.ca>
 <50F7F793.80507@giref.ulaval.ca> <CAGK7Mr4R=OwfWt4Kat75C8YDi3iLTavMLxeoLxkf1-gKhxrucg@mail.gmail.com>
 <50F8273E.5050803@giref.ulaval.ca> <871B6C10EBEFE342A772D1159D1320853A042AD7@umechphj.easf.csd.disa.mil>
 <50F829A9.7090606@calculquebec.ca> <871B6C10EBEFE342A772D1159D1320853A044B42@umechphj.easf.csd.disa.mil>
 <50F98B53.9080109@giref.ulaval.ca>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "Pyeron, Jason J CTR (US)" <jason.j.pyeron.ctr@mail.mil>,
	Maxime Boissonneault <maxime.boissonneault@calculquebec.ca>,
	Philippe Vaucher <philippe.vaucher@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	=?ISO-8859-1?Q?S=E9bastien_Boisvert?= 
	<sebastien.boisvert@calculquebec.ca>
To: Eric Chamberland <Eric.Chamberland@giref.ulaval.ca>
X-From: git-owner@vger.kernel.org Mon Jan 21 14:30:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxHS4-0002Ni-Sr
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 14:30:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751635Ab3AUN34 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 08:29:56 -0500
Received: from mail-ie0-f173.google.com ([209.85.223.173]:37755 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751178Ab3AUN3z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 08:29:55 -0500
Received: by mail-ie0-f173.google.com with SMTP id e13so9731453iej.4
        for <git@vger.kernel.org>; Mon, 21 Jan 2013 05:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:reply-to:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=nFyYPweTUmHDym4kNfsvNUJDFx25Sdui6fdu2E4axQQ=;
        b=heWodINjL5AHASOLewNUG8hYeW/Nxd9Wuq5gUy6H9Oazb7vqzscI+wQFQIqwhNat4r
         b7gWbzHTZyYyORrLzVnsoaaMsNpLJJduw7gznMmqI0AsKPNr+jsCrxGxBeK4Wig/HwgP
         po7CLkIvIMwlDUoZIhteRLPKwaZkYytSr6NwYHkI79qnrUEOigLX0CTNYBPt9a4YKl/J
         UYJGkqI+wPZ1xFmdlvLiwlEsh72AODybQM0V4mPI7DxhzACSEoQB6ndjHWv+P0d0+bp+
         SdNiEPoRYRFM9TbvKT/6xNxyhdEuXQ8Dv2o0PwntjwfEATJ95IBfd35/cOqpV1fRGPca
         EvjQ==
X-Received: by 10.50.16.210 with SMTP id i18mr9177223igd.53.1358774994986;
 Mon, 21 Jan 2013 05:29:54 -0800 (PST)
Received: by 10.64.9.112 with HTTP; Mon, 21 Jan 2013 05:29:14 -0800 (PST)
In-Reply-To: <50F98B53.9080109@giref.ulaval.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214118>

On Fri, Jan 18, 2013 at 6:50 PM, Eric Chamberland
<Eric.Chamberland@giref.ulaval.ca> wrote:
> Good idea!
>
> I did a strace and here is the output with the error:
>
> http://www.giref.ulaval.ca/~ericc/strace_git_error.txt
>
> Hope it will be insightful!

This trace doesn't seem to contain child-processes, but instead having
their stderr inlined into the log. Try using "strace -f" instead...
