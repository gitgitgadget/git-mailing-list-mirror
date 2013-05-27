From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: contrib/git-normal-to-bare.sh
Date: Mon, 27 May 2013 11:52:40 +0200
Message-ID: <20130527095240.GA530@paksenarrion.iveqy.com>
References: <CAOsGNSSFx7VEOmz4qTt9nz=SXzQCZH7PdZ+gnYVqLhmRmRcT-A@mail.gmail.com>
 <vpqr4gs23u6.fsf@anie.imag.fr>
 <CAOsGNSRm8QChOupsY_Z++qDOMh4hXq-9A_Z2X6uY5o-tFMNj0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Zenaan Harkness <zen@freedbms.net>
X-From: git-owner@vger.kernel.org Mon May 27 11:51:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ugu5K-0006fx-U2
	for gcvg-git-2@plane.gmane.org; Mon, 27 May 2013 11:51:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755853Ab3E0JvT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 May 2013 05:51:19 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:43484 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755832Ab3E0JvS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 May 2013 05:51:18 -0400
Received: by mail-la0-f41.google.com with SMTP id ee20so6328419lab.28
        for <git@vger.kernel.org>; Mon, 27 May 2013 02:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=CAgv61vobj1v7Rs2MY/ttiwLGaEtkQG4aPAjGT3tftI=;
        b=mUsHAUSAVZY0BEswnh7ona50sOOEOHuxi0fQ3aXLFPvAjCgxQMDyse42z7qxRf40HH
         JHl1ButnFMLkKhBPX999LJTXihoijRUpB7Qm8Ngu2pCBmbFD5klAGjn0TuH8EDBvG9Y+
         HphyBsELBvWg5+r0zJM12eG/qgG16qAMmddAM72f3TM7YKp1T5Csn/I4QRqZ/DkDfn4y
         mVA7TYT/+uKs2iTFCWlkYT0v56PbOb6Ua55JjgxB6tAlYAnQ9O4lBzKVERIW0DkRlvQB
         WFvtwv13V17EOEIhEVwclpykdl8EiZrXtKP6bQM0Ye1BJXto7wOe1uucS6dfe5l6IvG0
         tQsA==
X-Received: by 10.112.1.38 with SMTP id 6mr7979049lbj.100.1369648276982;
        Mon, 27 May 2013 02:51:16 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id e3sm11212747lbf.17.2013.05.27.02.51.15
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 27 May 2013 02:51:15 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1Ugu6a-00008i-30; Mon, 27 May 2013 11:52:40 +0200
Content-Disposition: inline
In-Reply-To: <CAOsGNSRm8QChOupsY_Z++qDOMh4hXq-9A_Z2X6uY5o-tFMNj0A@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225583>

On Mon, May 27, 2013 at 07:43:13PM +1000, Zenaan Harkness wrote:
> In my later email, I changed it to mv - should have highlighted there
> was a change. I got bitten, on a small repo thankfully, where a perms
> or ownership problem caused the whole repo to disappear. So mv it is
> :)

Do you really need bash for that script or will it do with sh? I think
sh is preferred.

Also a mv instead of a rm will require a lot of disc space if you have =
a
big repository.

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
