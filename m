From: Pascal Obry <pascal@obry.net>
Subject: Re: [PATCH] On Cygwin support both UNIX and DOS style path-names
Date: Thu, 28 Jul 2011 11:28:54 +0200
Organization: Home - http://www.obry.net
Message-ID: <4E312BD6.6020901@obry.net>
References: <FD5C22CB4AC2439D8151F6B7CD4B7CC9@martinic.local>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Theo Niessink <theo@taletn.com>
X-From: git-owner@vger.kernel.org Thu Jul 28 11:29:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmMtv-0004Gr-Pi
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 11:29:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754457Ab1G1J3D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 05:29:03 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:41023 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754263Ab1G1J3A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 05:29:00 -0400
Received: by wwe5 with SMTP id 5so2268780wwe.1
        for <git@vger.kernel.org>; Thu, 28 Jul 2011 02:28:59 -0700 (PDT)
Received: by 10.227.55.72 with SMTP id t8mr1087429wbg.68.1311845338001;
        Thu, 28 Jul 2011 02:28:58 -0700 (PDT)
Received: from [192.168.0.100] (AVelizy-154-1-6-251.w82-124.abo.wanadoo.fr [82.124.68.251])
        by mx.google.com with ESMTPS id fx12sm668035wbb.25.2011.07.28.02.28.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 28 Jul 2011 02:28:56 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR; rv:1.8.1.22) Gecko/20090605 Thunderbird/2.0.0.22 Mnenhy/0.7.5.0
In-Reply-To: <FD5C22CB4AC2439D8151F6B7CD4B7CC9@martinic.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178052>


Theo,

>> +#define has_dos_drive_prefix(path) (isalpha(*(path))&&  (path)[1] == ':')
>> +#define is_dir_sep(c) ((c) == '/' || (c) == '\\')
>
> I think that by defining is_dir_sep you enable DOS/Windows style paths
> throughout Git, so you might want to check compat/mingw.h for other, related
> changes. You will probably at least want the MinGW version of
> find_last_dir_sep as well, because the default find_last_dir_sep doesn't use
> is_dir_sep.

Thanks for the review/feedback. Will work on that and propose another patch.

Pascal.

-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|    http://www.obry.net  -  http://v2p.fr.eu.org
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver keys.gnupg.net --recv-key F949BD3B
