From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 01/10] sequencer.c: remove broken support for rfc2822
 continuation in footer
Date: Tue, 22 Jan 2013 01:49:16 -0800
Message-ID: <20130122094916.GB8908@elie.Belkin>
References: <1358757627-16682-1-git-send-email-drafnel@gmail.com>
 <1358757627-16682-2-git-send-email-drafnel@gmail.com>
 <20130122075413.GB6085@elie.Belkin>
 <CA+sFfMfERgGbf58LjOfAhhO_-YLu+yo+L-vYMuAuOUaP90yvgA@mail.gmail.com>
 <20130122094720.GA8908@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, pclouds@gmail.com, git@vger.kernel.org,
	Brandon Casey <bcasey@nvidia.com>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 10:49:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxaUD-0002Pr-Jh
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 10:49:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752744Ab3AVJtW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 04:49:22 -0500
Received: from mail-pa0-f42.google.com ([209.85.220.42]:60267 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752580Ab3AVJtV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 04:49:21 -0500
Received: by mail-pa0-f42.google.com with SMTP id rl6so3966632pac.15
        for <git@vger.kernel.org>; Tue, 22 Jan 2013 01:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=tM8kBolkYXAtIo2PLdV5VfJtQnPE5n77GBhrvEXT+dA=;
        b=Hs9PXm4mv8DqD+0dCoK99HKO4BmhZX5hqdbUQzgARK7nrdge4PT1ft8lZQtMHCheiX
         rUMoeMpjqqwa1D/3Bj9dpgbqoM9+F6G00VBwmsFt6m6r9XdVlWArvvsIt5EW7fnEpKee
         Hz8pSmtjVMEIzacC+qrjhT083/zwAu5Dwq13TwyfgI4gJhLIoVh8ytNSCwVPhIPJiCdF
         oL6a3maVbefmuvTBp3eF2ZRxEQlYAHBBFpQk+NEeOK3K2FAZF3ZFsqIL4A208SU8aLTk
         j0R3uT6zPHlCorvHYf6cT99BOP7+aEffUuBRhH2zUMe9Fe2WPT1aUdTNQ+DL1R8Bsf49
         X3Ig==
X-Received: by 10.66.82.35 with SMTP id f3mr54550650pay.49.1358848161050;
        Tue, 22 Jan 2013 01:49:21 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id wh4sm10455623pbc.18.2013.01.22.01.49.18
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 22 Jan 2013 01:49:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130122094720.GA8908@elie.Belkin>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214228>

Jonathan Nieder wrote:

> Here is the loop in master:
>
> 	int hit = 0;
> [...]
> 
> 	for (i = len - 1; i > 0; i--) {
> 		if (hit && buf[i] == '\n')
> 			break;
> 		hit = (buf[i] == '\n');
> 	}
>
> I don't see any adjacency check.

Of course that's because I can't read. :)  Checking again.
