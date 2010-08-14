From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Silent maintenance
Date: Sat, 14 Aug 2010 13:26:05 +0000
Message-ID: <AANLkTing1Lgt7JEeg9SY4J2Q3i_cDuK5uJhmd=6DbzuZ@mail.gmail.com>
References: <20100814131156.GA24769@nibiru.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: weigelt@metux.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 14 15:26:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkGkj-00066U-9R
	for gcvg-git-2@lo.gmane.org; Sat, 14 Aug 2010 15:26:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757075Ab0HNN0I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Aug 2010 09:26:08 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:40963 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756465Ab0HNN0H (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Aug 2010 09:26:07 -0400
Received: by gxk23 with SMTP id 23so1369054gxk.19
        for <git@vger.kernel.org>; Sat, 14 Aug 2010 06:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type;
        bh=/R0lhRqE3vhz4YVAfiHWPwnmSFh2LD5asWtA6FZOUOI=;
        b=jxKAds37SxiQmzTcojdFyoTN7JSagSEZ8peMgiE0Qikh9pnQcuPzXF64vs3SQfoJsN
         A+JJvf2TCYQWyBd+rPLf3zGBOoUcCsqqTOzCqS+LuQeZaGXP/KeICKQ/VgY7gfeOhenA
         Eq4+e+BMCb8HO9/dFTc3rSA61URQDkDlfYUgE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=kyqpL9JUSwMvhv3+SOv50maOlFyuWACPK6OiO4Xe61QhQJ7/oJKIcF87aqU4x7blPK
         PQHgyBCmMUs8G1ysv39EIvoezcxUzgWg0B5jJalZCJdfmfSd3rF1vQPqE5rEeZDHSC2S
         iPojbeWLnPjxdfTSwWWGhoM39v7HS5F1fI9yQ=
Received: by 10.231.35.77 with SMTP id o13mr3175254ibd.92.1281792365903; Sat,
 14 Aug 2010 06:26:05 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Sat, 14 Aug 2010 06:26:05 -0700 (PDT)
In-Reply-To: <20100814131156.GA24769@nibiru.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153559>

On Sat, Aug 14, 2010 at 13:11, Enrico Weigelt <weigelt@metux.de> wrote:
> are there some flags to make the maintenance commands like
> git-repack and git-gc silent, so they only output errors ?

With Git you should check the exit code of commands, not if they're
silent or not.

Are you running something via cron?
