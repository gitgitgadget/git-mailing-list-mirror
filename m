From: Geoff Russell <geoffrey.russell@gmail.com>
Subject: gc getting called on each git command ... what's wrong?
Date: Wed, 8 Jun 2011 11:03:41 +0930
Message-ID: <BANLkTi=oUARfwvNFNj-_FvZdwxQgibqPOg@mail.gmail.com>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 03:33:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QU7eZ-0006IB-0i
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 03:33:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932746Ab1FHBdn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 21:33:43 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:38559 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756263Ab1FHBdm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 21:33:42 -0400
Received: by ewy4 with SMTP id 4so10650ewy.19
        for <git@vger.kernel.org>; Tue, 07 Jun 2011 18:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:date:message-id:subject
         :from:to:content-type;
        bh=lPNQScxaTDvsjyFQzqTh3TqGJjYbO2T7aVgTBOeeuPk=;
        b=Yhnn7H4/o2qzKLTE5u0mhPTrFEB1NI4kJG2LyCb/tlhFe95PQxOhpBKJBf9afWMt1t
         JbuRBZ57QPQmK8Oq7WhFzpivDzPN/pD263yq2HFZF5emXPCW+Inu8kBmMPntLGJg6ozg
         4e5++SxXECyIHx1U4Xc9YKTS0bVB2991R3rOo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:date:message-id:subject:from:to:content-type;
        b=B93qtEvXYBBUQLFVCEfYszvjBWtj5u4MKRNgax4ODH3akkfRqel/tihttaBofH+KN+
         Z46MSPE9S9nKbCwoe0OaIhKA2GBKb0YFH4IVERrAf2a1JhfO2oGE6bzrDmea9TsTBsiz
         59aIcWoZdLfekUvdbGfGW+Yox9vFiRXSCA4L4=
Received: by 10.14.95.8 with SMTP id o8mr2541186eef.76.1307496821449; Tue, 07
 Jun 2011 18:33:41 -0700 (PDT)
Received: by 10.14.98.205 with HTTP; Tue, 7 Jun 2011 18:33:41 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175290>

Hi all,

I'm running git version 1.7.0.4 on Ubuntu 10.04 LTS

As of today, almost every time I do a git command, gc is getting
invoked. This is a multi-gigabyte repository with over
half a million objects, so this takes a while ... and I'm guessing
that it shouldn't be happening anyway!

I've run an fsck (which doesn't do a gc!) and the repository looks
clean ... no output.

I have packSizeLimit set to 30M ... not sure why I did this, was
investigating something I
didn't understand.  There are 96 pack files.

Any help greatly appreciated, many thanks,

Cheers,
Geoff
