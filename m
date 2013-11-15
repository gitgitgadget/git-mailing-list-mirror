From: rhys evans <rhys.evans@ft.com>
Subject: Fwd: Possible bug report: `git commit -ammend`
Date: Fri, 15 Nov 2013 15:44:18 +0000
Message-ID: <CAMyx444wJeQUpxZmXmYx-mKE0kniO=ELo5HgzQ1unV4O15oxWw@mail.gmail.com>
References: <CAMyx446B1U30RL9X7vOrY-u7fQ_cEqRJxn_M8Wn8PuOJhdO-1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 15 16:44:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VhLZU-0005GB-3m
	for gcvg-git-2@plane.gmane.org; Fri, 15 Nov 2013 16:44:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416Ab3KOPoV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Nov 2013 10:44:21 -0500
Received: from eu1sys200aog121.obsmtp.com ([207.126.144.151]:51444 "EHLO
	eu1sys200aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750992Ab3KOPoU (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Nov 2013 10:44:20 -0500
Received: from mail-bk0-f50.google.com ([209.85.214.50]) (using TLSv1) by eu1sys200aob121.postini.com ([207.126.147.11]) with SMTP
	ID DSNKUoZBUjj1Bidp60VJZtVIAJHqmzzTCIFl@postini.com; Fri, 15 Nov 2013 15:44:19 UTC
Received: by mail-bk0-f50.google.com with SMTP id e11so320430bkh.9
        for <git@vger.kernel.org>; Fri, 15 Nov 2013 07:44:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type;
        bh=dGUELNgVNi7a0YJFG4HZnbrZuEMzEqBRzdmXQFYaXOY=;
        b=i3h8hMlTX1qJ0X1P8rVS1ReaY8NiJtFGpKkr1HQoCSWv4R0f1myk+Ehh9HFhO7yeds
         prowa6l+wXQatr7+Ow0uKMA44Y6WYICXOno6M1FCsAep0+Nf8fjQH/ha+RLhs4+Ngluk
         1Efi7N+DKLfmU5A64Q3YYlo9P7jdOIQ+BvewqTb5jJ8pxYDj/sP0g57E3Y5KttriUqfa
         /v2Uz5UJeMR+nYxmYj+Ab6tfm8V1VmoGNMYQ0iLabqzPCK30TR0CXLcvvbyKF0yd/oRi
         tPcarmDdYt/eXHxAbEsGyVcw6DdaVEyVerjOCJ4YAQFsJZVSLE1y5o99xWKTFJOO7krU
         GKlA==
X-Gm-Message-State: ALoCoQnROQPClxymHx3VkwSwZt/X3x/WA67zHteu3gNPjYJw4xyIf7oACHUQ6V0qO+dSD7BAYh25WcgcKqJKkim67uSJUnNtHlcRsajm3MOjd8HDu5xVYgI6ZBPP9AVxppppft+HMD+bzdtulU8sVt8LVSu1mOJnrg==
X-Received: by 10.204.239.10 with SMTP id ku10mr44064bkb.133.1384530258384;
        Fri, 15 Nov 2013 07:44:18 -0800 (PST)
X-Received: by 10.204.239.10 with SMTP id ku10mr44061bkb.133.1384530258253;
 Fri, 15 Nov 2013 07:44:18 -0800 (PST)
Received: by 10.204.69.129 with HTTP; Fri, 15 Nov 2013 07:44:18 -0800 (PST)
In-Reply-To: <CAMyx446B1U30RL9X7vOrY-u7fQ_cEqRJxn_M8Wn8PuOJhdO-1Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237910>

I ran `git commit -ammend` on a repo where 1 out of 3 files changed
were staged for commit.

I would've expected an error to be thrown due to the double typo but
instead it committed all 3 files with the message 'mend'.

So it looks like it interpreted it as `git commit -a -m 'mend'`.

I'm running git 1.8.3.4 using iTerm 1.0.0 on OSX 10.9.

-- 

------------------------------
This email was sent by a company owned by Pearson plc, registered office at 
80 Strand, London WC2R 0RL.  Registered in England and Wales with company 
number 53723.
