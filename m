From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Configuring the location of ~/.gitconfig
Date: Thu, 27 Sep 2012 12:19:36 +0530
Message-ID: <CALkWK0nYnyaoOsH_x8U96ADZT7VuP-pR36+RRcjTw39Kp1qCnw@mail.gmail.com>
References: <CALkWK0nEP2gf4fYL=hjHg_U3X67M4PF1aupV+VJb9T6eBEo0MQ@mail.gmail.com>
 <CAJDDKr6q1k+nM9VTukLvze2E6wRBrMOHeZRAoAbKp0MbGv4cQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Anurag Priyam <anurag08priyam@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 27 08:50:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TH7vD-0000jr-Cz
	for gcvg-git-2@plane.gmane.org; Thu, 27 Sep 2012 08:50:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754824Ab2I0Gt6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2012 02:49:58 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:49165 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754766Ab2I0Gt5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2012 02:49:57 -0400
Received: by qchd3 with SMTP id d3so807762qch.19
        for <git@vger.kernel.org>; Wed, 26 Sep 2012 23:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=4+WLD+X37GhnbtCkUV5pJsipBllKMZhmzZ44SljyMH8=;
        b=ryNkSkkNXceQfNiXeIeCMTS4NrSrtUFslvz5NKZ19bcYwmdPSTKUaFQFD+iQUjoh0q
         AnfVAac9Zm/VgwIeL/G48RWDJCXEQC+3lQB1v6uPQr7fe7YZEPpYTiRACTHc3NEluCDg
         cA2jgGVD6ugO4gawFojYqWMz/Ahv8BdMspI3E83RuQ1FJ7IMRZYD84kDndU8FHWoo28f
         U2J1D7NN2if35Y/k/PMf/foTwoQgct2FuNXKuDoSM1n+p2vPS/dVfBP0TYG7QHKE7Hw6
         H09bDQIi15FCX5jtlyOcQ/Z0eV3Ipcr3vnkKqanoZYPinwgfXot/Zhxt6tBLguf5iQ6+
         1HAg==
Received: by 10.224.58.147 with SMTP id g19mr7485546qah.77.1348728597012; Wed,
 26 Sep 2012 23:49:57 -0700 (PDT)
Received: by 10.49.84.105 with HTTP; Wed, 26 Sep 2012 23:49:36 -0700 (PDT)
In-Reply-To: <CAJDDKr6q1k+nM9VTukLvze2E6wRBrMOHeZRAoAbKp0MbGv4cQQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206467>

Hi David,

David Aguilar wrote:
> Would that help, or are the XDG variables too global for your usage?

Yeah, they're too global.  I'll write a patch.

Ram
