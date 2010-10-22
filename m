From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: git merge --abort? [was: Re: [PATCHv4 00/21] git notes merge]
Date: Fri, 22 Oct 2010 10:57:32 -0500
Message-ID: <AANLkTimFsVDoPUiVgPpWe+iZZOUNuUKN=0tya6PFwK5N@mail.gmail.com>
References: <1287626936-32232-1-git-send-email-johan@herland.net>
 <201010221611.15425.johan@herland.net> <20101022145553.GA9224@burratino>
 <201010221712.06059.johan@herland.net> <AANLkTimzryq2Qa5sZNmXVY5Z1epg5Zxe3TMk9CX_+VX8@mail.gmail.com>
 <20101022154815.GE9224@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, bebarino@gmail.com,
	avarab@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 22 17:58:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9K0E-0000ca-Ic
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 17:57:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757524Ab0JVP5x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 11:57:53 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:58012 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755403Ab0JVP5x (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 11:57:53 -0400
Received: by gxk23 with SMTP id 23so529935gxk.19
        for <git@vger.kernel.org>; Fri, 22 Oct 2010 08:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=QSf4deyqbkTa+d1Demmq+0NFY36U4qYoSvDrLrraagQ=;
        b=PCleM/LD3cjPXoqRou6IG/PdkBYM3XHNAt8rdAL+fAud0VQEWLE1wgD6WNMzPoD4HY
         jZVCbRq03PpPO5M4MOfGyTb9YAMA7vSzvondqEpbfPuwd1Tjtly9sTucSZczZwvkktBh
         4Svg8sAyCkfxVpYVomHTpC/i4QehJ9fgNXTKU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=eoIxu1YRts5IfVuY0hLQTNr+EPphDqGTcdoezdIS/yvsDBaHVYpbxaBZE4A+yPeWzo
         iL5vO9G3N+IwT+xbFzp5DrxyKxvTOl0G3wycRi89IGmeBAyv3yKk39OUMvl24b39pU4z
         S1m7TvPh0BTXpvITnpJG2YMaNht3vhqu/HaUY=
Received: by 10.150.177.7 with SMTP id z7mr6285199ybe.433.1287763072224; Fri,
 22 Oct 2010 08:57:52 -0700 (PDT)
Received: by 10.151.45.12 with HTTP; Fri, 22 Oct 2010 08:57:32 -0700 (PDT)
In-Reply-To: <20101022154815.GE9224@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159707>

Heya,

On Fri, Oct 22, 2010 at 10:48, Jonathan Nieder <jrnieder@gmail.com> wrote:
> I doubt[*] 'git reset --merge' could be anything but a mistake when used
> outside the context of a merge (remember that the plumbing is called
> "read-tree", not "reset").

In that case, we should perhaps deprecate 'git reset --merge' and
encourage users to use 'git merge --abort' instead. (I was thinking
first that it doesn't make sense conceptually to have a command under
'git reset' that only works for merges, but we have the same with 'git
checkout' already in the form of 'git checkout --ours', so perhaps
it's ok to keep 'git reset --merge' then.)

-- 
Cheers,

Sverre Rabbelier
