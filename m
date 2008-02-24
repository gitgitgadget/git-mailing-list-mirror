From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: on subtree checkout
Date: Sun, 24 Feb 2008 16:45:47 +0100
Message-ID: <200802241645.49718.jnareb@gmail.com>
References: <fcaeb9bf0802240134i46e276ajfe83071e0b18ce61@mail.gmail.com> <m31w72d63a.fsf@localhost.localdomain> <fcaeb9bf0802240712u5bc7173du1fe67c3bcd89d1a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "git mailing list" <git@vger.kernel.org>
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 16:46:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTJ3w-0004Rb-Uv
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 16:46:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752864AbYBXPqN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 10:46:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752750AbYBXPqM
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 10:46:12 -0500
Received: from py-out-1112.google.com ([64.233.166.183]:20204 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752599AbYBXPqL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 10:46:11 -0500
Received: by py-out-1112.google.com with SMTP id u52so1981347pyb.10
        for <git@vger.kernel.org>; Sun, 24 Feb 2008 07:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=klf4e6bnxD/Wq99mLO0t92k/TbrZtHUHndOjGQQ0uuU=;
        b=Hkg/9fkhs11y4EUp5qRmVOBDY14aMW4W7QTbJ03bxHZFtJ+/E9JZDyB3q25q2ubujKnYYNERht9LaHnN1Lafk1BlSqjPL7+1uDNe/cz+oC33zgmkLMPyZ0DVE6Yokx65RQFAglzvu4rax920Iut/ukJwS+itFYdYOexWFUco0gs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=SlP1OPwk2Sq+6gOGLMlcL0MXnqSviozo9OtrpIw0mAxruVxIVhFxDXK3+TcArpVMpiwecL0Ds3iluPd656sNPGsTPcC8ztxsPv0jKuJthLanjqSPfjCZA0+p79UK/I8X5gqJuteTtnfO3KBs4tqviv8KMYdNbgdgCj05U4lJ4bk=
Received: by 10.65.240.17 with SMTP id s17mr3916337qbr.53.1203867961156;
        Sun, 24 Feb 2008 07:46:01 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.255.46])
        by mx.google.com with ESMTPS id z40sm6591997ikz.4.2008.02.24.07.45.58
        (version=SSLv3 cipher=OTHER);
        Sun, 24 Feb 2008 07:45:59 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <fcaeb9bf0802240712u5bc7173du1fe67c3bcd89d1a4@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74941>

Nguyen Thai Ngoc Duy wrote:
> On Sun, Feb 24, 2008 at 5:03 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>>
>> "Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:
>>
>>> I'm going to implement subtree checkout. [...]
>>
>>  As far as I can see the problem lies in merging...
> 
> Can you elaborate? I'm really noob at merging.

What to do if when merging, or rebasing, there is conflict _outside_
checked out subtree?

-- 
Jakub Narebski
Poland
