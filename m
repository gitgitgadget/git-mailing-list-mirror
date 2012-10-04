From: Pascal Obry <pascal@obry.net>
Subject: Re: Ignore on commit
Date: Thu, 04 Oct 2012 22:06:40 +0200
Organization: Home - http://www.obry.net
Message-ID: <506DEC50.7090402@obry.net>
References: <CAKRNd4w4Z-LS9O5ffkbTSZ0Guv4KCmWR=AtW3EpxQ2sSgazG=Q@mail.gmail.com>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marco Craveiro <marco.craveiro@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 00:50:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJthK-00033L-DL
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:15:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751641Ab2JDUGp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 16:06:45 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:48924 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750883Ab2JDUGp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 16:06:45 -0400
Received: by mail-we0-f174.google.com with SMTP id t9so577142wey.19
        for <git@vger.kernel.org>; Thu, 04 Oct 2012 13:06:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:reply-to:organization:user-agent:mime-version
         :to:cc:subject:references:in-reply-to:x-enigmail-version
         :content-type:content-transfer-encoding:x-gm-message-state;
        bh=ExOqn3Zsw0ydwok8+LCX93DY3Us1Z2Wm011d+IYGAkc=;
        b=MEyNvgKOvlkfcJqCX5zSVXIUOk+Cq8gar1dDGRLfHDBw+H4tHFT31EH66dt9gGIR6j
         JMJHu4s73UHeDS0HLt3+af6uXyyUYiou20uIUCO50Wq9F/xOATaqO2zIJdms7L0wDeyj
         NjD2OpUIZbLcQCJdbKUH8qi/un6U7bkDv3QDz2UaeNB7dxPi6c6YnA6h9e7V5ZLatf4i
         aAF0sUvjKKhW4zsiRO4XwF4+B8lyX7jkTShV9vbwjHi2PAR1I9j2TWHf3tM7jEOYrNJ4
         uccwR6WmZ38Qbt6ZAPVDBdCZ6lRpb8kEY7EOyody2pVobsQJZmsdZw3lkfaop/jF1QNx
         ecSA==
Received: by 10.216.71.82 with SMTP id q60mr4166529wed.64.1349381203687;
        Thu, 04 Oct 2012 13:06:43 -0700 (PDT)
Received: from [192.168.0.100] (APuteaux-651-1-239-26.w82-120.abo.wanadoo.fr. [82.120.66.26])
        by mx.google.com with ESMTPS id v3sm34067558wiw.7.2012.10.04.13.06.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 04 Oct 2012 13:06:42 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR; rv:1.8.1.22) Gecko/20090605 Thunderbird/2.0.0.22 Mnenhy/0.7.5.0
In-Reply-To: <CAKRNd4w4Z-LS9O5ffkbTSZ0Guv4KCmWR=AtW3EpxQ2sSgazG=Q@mail.gmail.com>
X-Enigmail-Version: 1.4
X-Gm-Message-State: ALoCoQnDytzAmarIN4p995YPX55nc2HOu6gULIEiz60CpPRxe6SXyx+YvMHQLoBuC3tg+0MmlzD/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207029>


I'm not sure to follow everything... But looks like:

   $ git add -p

or

   $ git add -i

should do what you want, no?

You select the hunks to commit, let over the "hacks" and then

   $ git commit

-- 

  Pascal Obry /  Magny Les Hameaux (78)

  The best way to travel is by means of imagination

  http://v2p.fr.eu.org
  http://www.obry.net

  gpg --keyserver keys.gnupg.net --recv-key F949BD3B
