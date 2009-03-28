From: demerphq <demerphq@gmail.com>
Subject: Re: On git 1.6 (novice's opinion)
Date: Sat, 28 Mar 2009 11:33:10 +0100
Message-ID: <9b18b3110903280333t1b7ec8d9x252f7e67e0753796@mail.gmail.com>
References: <49CC8C90.12268.242CEFCE@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
	 <49CCCB3D.8010706@drmicha.warpmail.net>
	 <49CCE72E.20081.258EE61F@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
X-From: git-owner@vger.kernel.org Sat Mar 28 11:34:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnVsC-0005QR-HS
	for gcvg-git-2@gmane.org; Sat, 28 Mar 2009 11:34:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753650AbZC1KdN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Mar 2009 06:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752198AbZC1KdN
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Mar 2009 06:33:13 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:1562 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753362AbZC1KdM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Mar 2009 06:33:12 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1283459ywb.1
        for <git@vger.kernel.org>; Sat, 28 Mar 2009 03:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5OWvfXPk7w5FygefvHTWCu0bBML9FRpNI7dnOg3N5Yg=;
        b=ViKHGsSGeo49D5HwnZ+BWRQiBOCmnl2iu3atkp63AiNtJ64Lvgopww16oy6AmXj0Hf
         AWHpMebw7bl+IcoUCTOdnnHos0XCVtCNFXEdSrkGaNgvclzFqIUS3EANc0zUrp7EgQ0W
         I/h+UBIJUb8SVP94YgJse41BeY8nACixqy7dg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Z/p1OjBzi1rTL4vuxaLwlHCzNCc45FBNdWkEKzp1a2KJMgtOmKty/qGna8nCLOKRV2
         BPN77u673O+VJbGRfupkteDbfCIpOAsrXclIdMK+DM29Edgq5mNQE1+gXKiAeJGPH4sM
         Anw+tbYOGGHGoszYq/1joYrP1Il2qoXMQ1YO4=
Received: by 10.231.15.202 with SMTP id l10mr670821iba.35.1238236390225; Sat, 
	28 Mar 2009 03:33:10 -0700 (PDT)
In-Reply-To: <49CCE72E.20081.258EE61F@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114946>

2009/3/27 Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>:
> On 27 Mar 2009 at 13:49, Michael J Gruber wrote:
>
>> Ulrich Windl venit, vidit, dixit 27.03.2009 08:21:
>
> [...]
>
>> Keyword substitution and cvs/svn style version numbers are independent
>> issues. The sha1 describes a commit uniquely, one could use that as a
>> keyword.
>
> However version numbers and time stamps have the property of being at least
> partially ordered in respect of "newer/older". That property does not hold for
> SHA-1 checksums. Just imagine suggesting users to upgrade from Microsoft
> Word/004765c2a1e9771e886f0dbe87d4f89643cd6f70 to Microsoft
> Word/00b7e6f51130f234a969c84ee9231a5ff7fc8a82 ;-)

The problem here is that in some "version control" systems the concept
of "release version" has been conflated with "version control system
revision number".

They arent the same thing, never were, and conflating the two only
caused and causes trouble.

A "release version" is a *tag*, always has been or should have been
really, and in git is in fact.

Cheers,
yves



-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
