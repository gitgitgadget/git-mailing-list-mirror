From: Pascal Obry <pascal@obry.net>
Subject: Re: French git user
Date: Wed, 26 Nov 2008 19:06:27 +0100
Organization: Home - http://www.obry.net
Message-ID: <492D9023.9010508@obry.net>
References: <492B9985.10103@morey-chaisemartin.com>	 <46d6db660811242238q4bc919a6l12bfd9a38639e46e@mail.gmail.com>	 <C10BF28F-3466-4908-A5ED-6FB68FBEC3A2@yahoo.ca> <46d6db660811250741w54d34062w7766efd135c457b8@mail.gmail.com> <492C2F2E.2050200@morey-chaisemartin.com> <492D0295.6060808@morey-chaisemartin.com>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jean-Francois Veillette <jean_francois_veillette@yahoo.ca>,
	git@vger.kernel.org
To: devel@morey-chaisemartin.com
X-From: git-owner@vger.kernel.org Wed Nov 26 19:08:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5Onz-0006vl-Oc
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 19:08:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752305AbYKZSGh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2008 13:06:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752312AbYKZSGg
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 13:06:36 -0500
Received: from fk-out-0910.google.com ([209.85.128.190]:10876 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752305AbYKZSGg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2008 13:06:36 -0500
Received: by fk-out-0910.google.com with SMTP id 18so518029fkq.5
        for <git@vger.kernel.org>; Wed, 26 Nov 2008 10:06:34 -0800 (PST)
Received: by 10.181.60.13 with SMTP id n13mr2028603bkk.92.1227722794175;
        Wed, 26 Nov 2008 10:06:34 -0800 (PST)
Received: from ?192.168.0.100? (AVelizy-154-1-42-242.w82-124.abo.wanadoo.fr [82.124.146.242])
        by mx.google.com with ESMTPS id p17sm925743fka.36.2008.11.26.10.06.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 26 Nov 2008 10:06:32 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; fr-FR; rv:1.8.1.18) Gecko/20081105 Thunderbird/2.0.0.18 Mnenhy/0.7.5.0
In-Reply-To: <492D0295.6060808@morey-chaisemartin.com>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nicolas,

There is also at least two commands that I used often that are missing
to me:

   $ git checkout -b branch_name branch_point

Which is equivalent to:

   $ git branch branch_name branch_point
   $ git checkout branch_name

The other missing command is:

   $ git add [-p|-i]

Very important to create a set tightly related commits out of a dirty tree.

Maybe also adding a note about aliases:

   $ git config --global alias.co checkout

Pascal.

-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|              http://www.obry.net
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver wwwkeys.pgp.net --recv-key C1082595
