From: Kevin <ikke@ikke.info>
Subject: Re: Port 22
Date: Mon, 28 Jan 2013 09:06:13 +0100
Message-ID: <CAO54GHBFo94Pes1cJ9MVvVJGD5ZMK4yMv9+_shtT8iPP-DVtsg@mail.gmail.com>
References: <55B0A474-AD5B-44B5-91E7-FA5253FA5682@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: git <git@vger.kernel.org>
To: Craig Christensen <cwcraigo@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 09:06:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tzjk1-0005x0-ER
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 09:06:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753724Ab3A1IGf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 03:06:35 -0500
Received: from mail-ia0-f180.google.com ([209.85.210.180]:51451 "EHLO
	mail-ia0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753480Ab3A1IGe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Jan 2013 03:06:34 -0500
Received: by mail-ia0-f180.google.com with SMTP id f27so3878846iae.11
        for <git@vger.kernel.org>; Mon, 28 Jan 2013 00:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=db0EFn9ZUg9EqrBFfREOk6kE+Us6WviMipHYPAtGNCM=;
        b=hRQbziQ/+68xOTSyJ9BWK02TTUEHeq6gJJqIeRMzO3eRSBBddgGXXLBhmgpeSldUTE
         mLpUQsMN6aX+m8TfIRATWyM0Cvw8w7oy7458knQRY3jgVXlgD5FDrgWQWwddjeQU6TaJ
         EcRClO+N+UDRaTlKJV/cwa8bnsQmr7cHwmhjJn8K1UPUMiWRviDclLG2Pi7xxqbqNSru
         dnuTz9ELaAtMAJaYsGqySPI7kXKbwK4xa7otsk9Ne9jhR9LQurNTGFT7gD416ZQZon/i
         PScY3E8pDPRa+ROD2CEHynLJWPhaVlHgvREtVqlaoaUdPUTg8l62uefoyYe3QV8s8C+d
         qJvA==
X-Received: by 10.50.108.236 with SMTP id hn12mr4483256igb.109.1359360393617;
 Mon, 28 Jan 2013 00:06:33 -0800 (PST)
Received: by 10.64.38.39 with HTTP; Mon, 28 Jan 2013 00:06:13 -0800 (PST)
In-Reply-To: <55B0A474-AD5B-44B5-91E7-FA5253FA5682@gmail.com>
X-Google-Sender-Auth: czrrmtojTSqYr4ANzq92Cv94LNE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214817>

This is not really a git problem, but more of an ssh problem.

Are you in the position to change the port where the SSH daemon
listens on? Then you could use a different port which isn't blocked
(443 perhaps?).

On Sat, Jan 26, 2013 at 7:56 PM, Craig Christensen <cwcraigo@gmail.com> wrote:
> I am currently a student at Brigham Young University - Idaho and we are use Pagoda Box and Git for our Mobile Apps class.  However, the school's network has blocked incoming trafic on port 22.  I have been searching through all the tutorials and documents provided by Pagoda Box and Git but have not been able to find a solution to solve this problem.  We can use sftp but we then have to manually deploy the latest using the admin panel.  Can you help provide a simple solution?
>
> Thanks,
>
> Craig W Christensen
> cwcraigo@gmail.com
> chr07035@byui.edu--
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
