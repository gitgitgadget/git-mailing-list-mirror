From: Marius Storm-Olsen <marius@storm-olsen.com>
Subject: Re: [PATCH] Add bare repository indicator for __git_ps1
Date: Tue, 24 Feb 2009 20:47:18 +0100
Message-ID: <49A44EC6.3070800@storm-olsen.com>
References: <1235227723-11471-1-git-send-email-git@storm-olsen.com> <7v8wnzr3k9.fsf@gitster.siamese.dyndns.org> <49A05958.7050703@trolltech.com> <20090223154237.GH22848@spearce.org> <49A2C8D1.3080104@trolltech.com> <20090223161657.GL22848@spearce.org> <7vab8cpqgl.fsf@gitster.siamese.dyndns.org> <49A40372.2060600@tedpavlic.com> <49A40858.6010108@trolltech.com> <49A414B8.8010906@tedpavlic.com> <7vljrvixa3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Ted Pavlic <ted@tedpavlic.com>,
	Marius Storm-Olsen <marius@trolltech.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Marius Storm-Olsen <git@storm-olsen.com>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 20:48:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lc3Go-0001Gv-GD
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 20:48:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757788AbZBXTrS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 14:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757710AbZBXTrS
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 14:47:18 -0500
Received: from fk-out-0910.google.com ([209.85.128.190]:9615 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756988AbZBXTrR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 14:47:17 -0500
Received: by fk-out-0910.google.com with SMTP id f33so1824251fkf.5
        for <git@vger.kernel.org>; Tue, 24 Feb 2009 11:47:14 -0800 (PST)
Received: by 10.103.227.10 with SMTP id e10mr18195mur.30.1235504833382;
        Tue, 24 Feb 2009 11:47:13 -0800 (PST)
Received: from ?192.168.0.196? (cm-84.215.55.206.getinternet.no [84.215.55.206])
        by mx.google.com with ESMTPS id p39sm154619ugd.3.2009.02.24.11.47.11
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 24 Feb 2009 11:47:12 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.19) Gecko/20081209 Thunderbird/2.0.0.19 ThunderGit/0.1a Mnenhy/0.7.5.666
In-Reply-To: <7vljrvixa3.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111335>

Junio C Hamano said the following on 24.02.2009 18:01:
> Ted Pavlic <ted@tedpavlic.com> writes:
>>>> Keep in mind that "BARE:master" doesn't make much sense. If
>>>> you're
>>> It reflects what HEAD points to in the bare repository.
>> Obviously, but that seems disingenuous when you're inside the git
>>  dir. "HEAD" is supposed to reflect the name of the currently 
>> checked-out branch, and so it is tied to a working directory. I'm
>> not sure why it's useful to show $GIT_DIR/HEAD in PS1 while
>> inside .git as it invites operations that probably should not be
>> done while within the bare repo.
> 
> It still indicates the branch in interest.  That's the one you get
> a checkout for when you clone from the repository.

Junio, unfortunately you applied the incorrect version.

It was v3 (Message-Id: 
<1235244057-16912-1-git-send-email-git@storm-olsen.com>) which was the 
correct one, since it's the one that avoids the "GIT_DIR!" in a bare 
repo. :-/

--
.marius
