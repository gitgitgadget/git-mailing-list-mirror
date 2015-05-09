From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] bisect: print abbrev sha1 for first bad commit
Date: Fri, 8 May 2015 17:29:42 -0700
Message-ID: <CAGZ79kYjES6DXmvQdmXLAXrKMGrnvQ-vqJuHQU2QxVC4+6M0aA@mail.gmail.com>
References: <1431128763-28453-1-git-send-email-tbsaunde@tbsaunde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Trevor Saunders <tbsaunde@tbsaunde.org>
X-From: git-owner@vger.kernel.org Sat May 09 02:29:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqseT-00032V-UF
	for gcvg-git-2@plane.gmane.org; Sat, 09 May 2015 02:29:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752809AbbEIA3o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 20:29:44 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:34343 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751380AbbEIA3n (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 20:29:43 -0400
Received: by iedfl3 with SMTP id fl3so84301400ied.1
        for <git@vger.kernel.org>; Fri, 08 May 2015 17:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=UPuYM7nBxCl3eJ+VY6UcgHEl3Sl5I21XSRNJy78TOeE=;
        b=C97Oihl4xquHmDXXYpkFA4ioh6TibGzDU2+blURlLNXffOqzbZarjyWP+j5SPBOpHQ
         lfDQHKN9AwosIT4oHO4uLQm+Rl9afIt8xlY4eSA+JRMGY2lsU0wOl8boeV9XAwQof2hV
         Ytc9woOYg3Im9arwab96ry9xogiEK7uNMnT/VhI2ZwMqOz0CW5fA5E+PD/YVPEva3/VG
         ymWSaQJYYof+s1X/u+gaaRErOVL1XzM73Pynrgq+fYNim+F44MLyqNGUBU7h98daID9Y
         RFeAjHiDCrvwhHRwLdjKFEGpBszTrBETZNQNrPCp+QFEcyYMH8nM6K4RMAS3qBy1RujU
         4WYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=UPuYM7nBxCl3eJ+VY6UcgHEl3Sl5I21XSRNJy78TOeE=;
        b=ND93GfSIoCE5z0nXgbMdVuz/coM2W4TdavEoTCqbSV2LAPABGOjtJGitRGYw5wCa64
         FWPECppb1Gw0cIQAT9f/zeOpWUe/z5UEBMsyOdWztPBD/Is9qOdhNT0EUeO5fKfHOOT6
         sNXO1NKGW0V4gUZAUGkMT0VZwDbaI0li5TuZ4mKFkvgMbOS1ddZef4E42an48VzW1WtS
         oL3QHykOWpkW/rDJrKDJXstJmgNxcxZlfpzy65Z3q7auiPOWvYYW9wybZo04i02NY9eF
         Gjj1mf6avMSLjN+4Zh/NtvbkoJ9ly73zZ0+ekCsZOP50kEHDmv5ROKv6j7rGI12/8jGj
         Vxhw==
X-Gm-Message-State: ALoCoQnKzaiqAidFkaROrfTwGLkUOGDedhkN09VkmYeB5M54044wItS3I5WlU803ZZziCvJctlZe
X-Received: by 10.107.132.223 with SMTP id o92mr691693ioi.49.1431131382944;
 Fri, 08 May 2015 17:29:42 -0700 (PDT)
Received: by 10.107.46.22 with HTTP; Fri, 8 May 2015 17:29:42 -0700 (PDT)
In-Reply-To: <1431128763-28453-1-git-send-email-tbsaunde@tbsaunde.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268689>

On Fri, May 8, 2015 at 4:46 PM, Trevor Saunders <tbsaunde@tbsaunde.org> wrote:
> its rather silly especially considering the next line contains the
> full hash again.

Maybe we can omit it altogether then?
