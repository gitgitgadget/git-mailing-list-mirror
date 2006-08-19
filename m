From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH] Added support for dropping privileges to git-daemon.
Date: Sat, 19 Aug 2006 15:23:03 +0200
Message-ID: <e5bfff550608190623j58de8c1cn6a9304249ee1ecb8@mail.gmail.com>
References: <1155990772.6591@hammerfest>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 19 15:23:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GEQnW-0007vf-8f
	for gcvg-git@gmane.org; Sat, 19 Aug 2006 15:23:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840AbWHSNXG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 Aug 2006 09:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWHSNXF
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Aug 2006 09:23:05 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:25409 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750840AbWHSNXE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Aug 2006 09:23:04 -0400
Received: by py-out-1112.google.com with SMTP id n25so1563052pyg
        for <git@vger.kernel.org>; Sat, 19 Aug 2006 06:23:04 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LODQ3k4S9v2dm/B6kpLTL8QL0cOjHm/sSHUMSS9zt1I4ns+VClAqk2fevj+FlZ1fBwBFkPshfsI3A+aV/OfqimWlIdofbET0/A+GViAN19YfN+WR2Biih9Y92BnJvzFxsZPihj/kSdVoV+33ainJDM7+pSsQsXI9yvvZAVt7/r0=
Received: by 10.35.99.5 with SMTP id b5mr8392124pym;
        Sat, 19 Aug 2006 06:23:04 -0700 (PDT)
Received: by 10.35.95.9 with HTTP; Sat, 19 Aug 2006 06:23:03 -0700 (PDT)
To: "Tilman Sauerbeck" <tilman@code-monkey.de>
In-Reply-To: <1155990772.6591@hammerfest>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25719>

>
> +       if (!user ^ !group)
> +               die("either set both user and group or none of them");
> +
>

Just a  question. Why simply not

       if (user ^ group)
