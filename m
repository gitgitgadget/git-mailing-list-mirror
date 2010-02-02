From: Pascal Obry <pascal@obry.net>
Subject: Re: Question about git rebase --onto
Date: Tue, 02 Feb 2010 19:19:24 +0100
Organization: Home - http://www.obry.net
Message-ID: <4B686CAC.7020103@obry.net>
References: <4B6865A9.60603@obry.net> <7v636f7biw.fsf@alter.siamese.dyndns.org>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 02 19:19:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcNLB-00076S-NJ
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 19:19:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756574Ab0BBSTF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 13:19:05 -0500
Received: from mail-ew0-f228.google.com ([209.85.219.228]:53031 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754272Ab0BBSTB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 13:19:01 -0500
Received: by ewy28 with SMTP id 28so209563ewy.28
        for <git@vger.kernel.org>; Tue, 02 Feb 2010 10:19:00 -0800 (PST)
Received: by 10.213.37.206 with SMTP id y14mr6223871ebd.4.1265134740087;
        Tue, 02 Feb 2010 10:19:00 -0800 (PST)
Received: from ?192.168.0.100? (AVelizy-154-1-45-106.w82-124.abo.wanadoo.fr [82.124.149.106])
        by mx.google.com with ESMTPS id 14sm21358ewy.11.2010.02.02.10.18.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Feb 2010 10:18:58 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR; rv:1.8.1.22) Gecko/20090605 Thunderbird/2.0.0.22 Mnenhy/0.7.5.0
In-Reply-To: <7v636f7biw.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138736>

Junio,

> Possible user errors I can think of are:
> 
>  - If 'topic' is not a local branch, the result will be on a detached
>    HEAD, as you are starting from a detached HEAD (i.e. 'topic' could be a
>    tag);

I'm not on this case.

>  - Until you resolved and said "rebase --continue" (or --skip) to allow it
>    to conclude the rebase when the operation conflicted, you would be on a
>    detached HEAD.

I'm not in this case either.

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
