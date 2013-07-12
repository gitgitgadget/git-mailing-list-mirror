From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: Cygwin, git and x: directory
Date: Fri, 12 Jul 2013 11:27:14 -0400
Message-ID: <51E02052.4050804@gmail.com>
References: <20130712124213.GL14578@lakka.kapsi.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: cygwin@cygwin.com, git@vger.kernel.org
To: Mikko Rapeli <mikko.rapeli@iki.fi>
X-From: git-owner@vger.kernel.org Fri Jul 12 17:27:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxfFi-0000q6-S5
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 17:27:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932967Ab3GLP1T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 11:27:19 -0400
Received: from mail-qc0-f181.google.com ([209.85.216.181]:52200 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932863Ab3GLP1S (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 11:27:18 -0400
Received: by mail-qc0-f181.google.com with SMTP id u12so5009857qcx.40
        for <git@vger.kernel.org>; Fri, 12 Jul 2013 08:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=IQh8d4zbQHN1rHtq/2e2ziCfaBEoFyNzDUVnDAIfw4M=;
        b=Osmx1ktaUks6d6jOoYDH2I8MsGNJeWiPLgbjn5ng9dXzHuXkmUc69ilmKLQnQ3cR7x
         9jj80/wHoB3NmnrNPOv3RZa+9o5pSprdcQEqwfjUqwlH1QIOuuMISDG8lLywIio7P0DS
         1DXEZdn70xwRlS5Ko1pwTD1iYn54hyYl6AerIQJc+aENaroX3J+ONLD3Dpp/kYdwvTjk
         OWJYuRQMjlHesfleTHVCvjnMW4IW0jGziUmfQqlYBtLk2SR6+OGiaOV6lp/mBXjaisOw
         DQ/uV1R4zAbNsqfmKxJGuJzAETa5vpa/jXEihDcskiHCgKEb8snhQBZHLm5kxALpWTGY
         CJ1w==
X-Received: by 10.49.82.234 with SMTP id l10mr35056665qey.17.1373642837873;
        Fri, 12 Jul 2013 08:27:17 -0700 (PDT)
Received: from mark-laptop.lan (pool-72-66-83-222.washdc.fios.verizon.net. [72.66.83.222])
        by mx.google.com with ESMTPSA id y4sm35375861qai.5.2013.07.12.08.27.16
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 12 Jul 2013 08:27:16 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
Newsgroups: gmane.comp.version-control.git,gmane.os.cygwin
In-Reply-To: <20130712124213.GL14578@lakka.kapsi.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230200>

On 07/12/2013 08:42 AM, Mikko Rapeli wrote:
> (please Cc: me in replies, not subscribed to the lists)
>
> Hi Cygwin and git developers,
>
> Does following scenario show signs of bugs in Cygwin and/or git?
>
> # setup git repo
> $ cd /tmp
> $ mkdir foo && cd foo
> $ git init
>
> # create x: directory
> $ mkdir x:
> $ ls
> x:


I would report this on the Cygwin list, not here. Any use of dos file 
paths using a Cygwin tool is not recommended, officially only POSIX 
paths are supported. If cygwin's Cmake is generating dos style paths, 
that is a bug that needs reporting to the Cygwin list. Also, I'm not 
sure how the developers will react to mishandling a directory named x:, 
but the behaviour you see is a limitation of the Cygwin platform, not of 
git.

Mark
