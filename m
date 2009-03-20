From: Alexander Lippling <lippling@googlemail.com>
Subject: Multiple Projects in one SVN Repository
Date: Fri, 20 Mar 2009 20:51:10 +0100
Message-ID: <DE6E225C-CAB4-4051-A3B5-294FE69502F2@gmail.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=WINDOWS-1252;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 20:52:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lkklt-0003Bl-4H
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 20:52:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757300AbZCTTvT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Mar 2009 15:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755432AbZCTTvT
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 15:51:19 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:14153 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755264AbZCTTvT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Mar 2009 15:51:19 -0400
Received: by fg-out-1718.google.com with SMTP id e12so231573fga.17
        for <git@vger.kernel.org>; Fri, 20 Mar 2009 12:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to
         :content-type:content-transfer-encoding:mime-version:subject:date
         :x-mailer;
        bh=wDCx9LzShicADeh1GO0fST5TnTT7EpdpQFOKm1hDUq8=;
        b=NXbSG8iaijBBsL1XdCW2Cm8jMlhhqYZMlceMtxT+uEX/9nE7hASVt75o1CfVDKLWsG
         lHdoS0lqOAE9iyzBYTlsOqFssEyz/b0grbYruR+r+dysSfPtO8BVtJl6aD9Yc36k8T7B
         sfow3tLl8bh4xKjxBWq/hEP9+lk8FNfu5LV2Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding
         :mime-version:subject:date:x-mailer;
        b=hObVcUtpV9s622sUuJVx1Uz4S95WLsWlUbSjxoqGCUPIK9lVX6a4ZNxs6ip1t18DEt
         82GCiXU7S86rt8lmcJ2bEdc1McP/TTKXtFQjus2tzxIugd9nN3nabCfo4IV9tjFZ8NF5
         f6p1iLRdCR7RjfYRiINsh0yoSX9a3CiV7Ezfw=
Received: by 10.86.96.1 with SMTP id t1mr1805981fgb.35.1237578676295;
        Fri, 20 Mar 2009 12:51:16 -0700 (PDT)
Received: from ?192.168.1.202? (ip-78-94-173-187.unitymediagroup.de [78.94.173.187])
        by mx.google.com with ESMTPS id 4sm81143fge.8.2009.03.20.12.51.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Mar 2009 12:51:16 -0700 (PDT)
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113997>

Hi folks,

I'm evaluating git and I'm wondering how to manage the following =20
problem:

We have a svn repository which contains all of our projects. They =20
reference each other relatively (e.g. ../../../ProjectA.dll).
The projects are each of the following structure:
	=95 <project>
		=95 trunk
			=95 current (this is needed, because relative links wouldn't work =20
without additionally changes when the trunk is branched)
		=95 branches
			=95 <branch name>
		=95 tags
			=95 <tag name>

How can I use git svn to manage this situation?

It is important, that the projects are checked out in a way so that =20
the relative links to other projects still work.

- Alexander