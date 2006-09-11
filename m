From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] git-upload-archive: add config option to allow only specified formats
Date: Mon, 11 Sep 2006 23:50:21 +0200
Organization: At home
Message-ID: <ee4lml$v4v$1@sea.gmane.org>
References: <7vpse4tcyc.fsf@assigned-by-dhcp.cox.net>	<7vk64ctctv.fsf@assigned-by-dhcp.cox.net>	<7v1wqkt2v4.fsf_-_@assigned-by-dhcp.cox.net>	<20060910155837.GA15974@lsrfire.ath.cx> <7vpse3sitc.fsf@assigned-by-dhcp.cox.net> <4505D7F4.8050207@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Mon Sep 11 23:50:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMtfq-0003m5-5X
	for gcvg-git@gmane.org; Mon, 11 Sep 2006 23:50:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964897AbWIKVuf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 11 Sep 2006 17:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964926AbWIKVuf
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Sep 2006 17:50:35 -0400
Received: from main.gmane.org ([80.91.229.2]:52653 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964897AbWIKVue (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Sep 2006 17:50:34 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GMtfd-0003iO-1l
	for git@vger.kernel.org; Mon, 11 Sep 2006 23:50:25 +0200
Received: from host-81-190-17-209.torun.mm.pl ([81.190.17.209])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 11 Sep 2006 23:50:25 +0200
Received: from jnareb by host-81-190-17-209.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 11 Sep 2006 23:50:25 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-17-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26860>

Rene Scharfe wrote:

>> Fine -- do we have any other "list-ish" configuration variable,
>> by the way? =A0I am just wondering if we earlier established a
>> convention to use some delimiter to list out things and if we do
>> have such a convention if delimiter is a comma or not.
>=20
> I didn't find any. =A0The code would accept whitespace as a separator=
, too
> (in order to recognize lists like "one, two"). =A0I found myself abus=
ing
> this during my testing: I always left out the comma. =A0So I dropped =
the
> comma from the list of delimiters in this patch, going with shell-lik=
e
> lists now.

Alternative would be to use multiple valued variable (multiple values w=
ith
the same configuration variable).

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
