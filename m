From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Draft of Git Rev News edition 1
Date: Sun, 22 Mar 2015 13:19:13 +0100
Message-ID: <CAP8UFD1HFVKr1xADSGDzJGXeve7W9eenpL16kRa_2z2rsJU_GA@mail.gmail.com>
References: <CAP8UFD1WtwKri8cWABnzeRvxKhdNmUfVw5xm=F4oLrevuOGyUA@mail.gmail.com>
	<87lhipnupj.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Paul Tan <pyokagan@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Dongcan Jiang <dongcan.jiang@gmail.com>,
	Jeff King <peff@peff.net>, Doug Kelly <dougk.ff7@gmail.com>,
	Bharat Suvarna <bharat.bs84@icloud.com>,
	Kevin D <me@ikke.info>,
	"Randall S. Becker" <rsbecker@nexbridge.com>,
	Stephen Robin <stephen.robin@gmail.com>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Mar 22 13:19:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZeqd-0003yS-Hc
	for gcvg-git-2@plane.gmane.org; Sun, 22 Mar 2015 13:19:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818AbbCVMTP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2015 08:19:15 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:34633 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751454AbbCVMTO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2015 08:19:14 -0400
Received: by iedfl3 with SMTP id fl3so21786725ied.1
        for <git@vger.kernel.org>; Sun, 22 Mar 2015 05:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=j7kjtHP21xyhDTqJjByg3dQm+sgURfUK2XuJZ1q5KxY=;
        b=Gq3YZiOIad7CYXxDvHuGZnPC/fM4uSWJjLqZNnlAX3vV7pBUlu3IfGw+gQbCjlwwmD
         BY9dSkCFn8kSNov8zHijOeBfMPml6iD0WfUAtCyOSvfGctAMRMaPGsGzp1zVIqx7QGeS
         S02Wa22zsjwyax0a/7N862NgGUYRyCR07JSPSMTjtxB6XqNLvMf2pRi8hB7QMZtmfNTl
         pKTR+S8wf/pzBhQ5H4qTxtnlBFgKjFy7bXf1EBzIdQT8I9lPICRB2+6q7WRn3LcXj+5b
         FnYm9Qu/51uOvZy3014QDP54RmElRW2u8Bhp6KFGrKbkFTsNM0euQUh0IQfHm94B+Df8
         FmnQ==
X-Received: by 10.50.253.12 with SMTP id zw12mr8061975igc.24.1427026753759;
 Sun, 22 Mar 2015 05:19:13 -0700 (PDT)
Received: by 10.50.245.168 with HTTP; Sun, 22 Mar 2015 05:19:13 -0700 (PDT)
In-Reply-To: <87lhipnupj.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266070>

On Sun, Mar 22, 2015 at 12:21 PM, David Kastrup <dak@gnu.org> wrote:
> I've seen
>
>     David Kastrup (dak at gnu.org) previously reimplemented significant
>     parts of "git blame" for a vast gain in performance with complex
>     histories and large files. As working on free software is his sole
>     source of income, please consider contributing to his remuneration
>     if you find this kind of improvements useful.
>
> Thank you very much for this heads-up.  However, I'd replace
> "previously" with "as of version 2.1.0".  That's where the big
> difference is, so if people actually are impacted they'll know whether
> and what to benchmark and/or upgrade.

Ok, there is now "as of version 2.1.0".
