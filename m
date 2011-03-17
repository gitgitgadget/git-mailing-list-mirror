From: Wolfgang Rohdewald <wolfgang@rohdewald.de>
Subject: Re: git blame --follow
Date: Thu, 17 Mar 2011 11:16:39 +0100
Message-ID: <201103171116.39411.wolfgang@rohdewald.de>
References: <201103151644.44360.wolfgang@rohdewald.de> <201103151926.58449.wolfgang@rohdewald.de> <m3tyf25arl.fsf@localhost.localdomain>
Reply-To: wolfgang@rohdewald.de
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 11:16:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0AFx-0002nV-1b
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 11:16:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753303Ab1CQKQ3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Mar 2011 06:16:29 -0400
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:55063 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751689Ab1CQKQ2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Mar 2011 06:16:28 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; t=1300356986; l=211;
	s=domk; d=rohdewald.de;
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:In-Reply-To:
	References:Cc:Date:Subject:To:Reply-To:From:X-RZG-CLASS-ID:X-RZG-AUTH;
	bh=0mTg4wQzW+ldmShEx0ADxkpvSbE=;
	b=okx04zwUp0F/1cg85MLfG64LuU0kzDsv/Zq5EUyESNupYLaaXin/+aIRQpvW0PFglUK
	gLFKcy3PMaB2kxi+Ff/1vkUeWLyvuozJiPUNxQypPKV9/XwksKChgUZ4IpMwovUCZ4CPG
	YZBRJ2mF0jiUUYT0lTEkcJoEEnAZTThXgwc=
X-RZG-AUTH: :O2MIc0epdfgAjoV+frHI3UhxNCLBO5P+YS73lHhJYRD2uAuzaM+5N8MTperqLH+l
X-RZG-CLASS-ID: mo00
Received: from i5.rohdewald.de (p5B3E06AA.dip0.t-ipconnect.de [91.62.6.170])
	by post.strato.de (mrclete mo63) (RZmta 25.8)
	with ESMTPA id 2005d6n2H8lLpY ; Thu, 17 Mar 2011 11:16:26 +0100 (MET)
Received: from i5.localnet (localhost.localdomain [127.0.0.1])
	by i5.rohdewald.de (Postfix) with ESMTP id 13385EA3425;
	Thu, 17 Mar 2011 11:16:40 +0100 (CET)
User-Agent: KMail/1.13.5 (Linux/2.6.35-27-generic; KDE/4.6.1; x86_64; ; )
In-Reply-To: <m3tyf25arl.fsf@localhost.localdomain>
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY
	shortcircuit=no autolearn=ham version=3.3.1
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on i5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169230>

On Donnerstag 17 M=E4rz 2011, Jakub Narebski wrote:
> So you probably want to run "git blame -C -C <file>", not "git
> blame <file>".

that does the trick - I only tried "git blame -C"

--=20
Wolfgang
