From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [GSoC update] git-remote-svn: Week 12
Date: Wed, 21 Jul 2010 18:01:42 +0530
Message-ID: <20100721123142.GA24156@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Stefan Sperling <stsp@elego.de>,
	Daniel Shahaf <d.s@daniel.shahaf.name>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 21 14:33:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObYUd-0001F0-UI
	for gcvg-git-2@lo.gmane.org; Wed, 21 Jul 2010 14:33:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752005Ab0GUMdn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jul 2010 08:33:43 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:52522 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751305Ab0GUMdm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jul 2010 08:33:42 -0400
Received: by pzk26 with SMTP id 26so2055985pzk.19
        for <git@vger.kernel.org>; Wed, 21 Jul 2010 05:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=gjWWcXMWmg8q1u1/XSr0a49rnr9g/oqjfmEYC246LSA=;
        b=TExv5ls7RsbmZycbAE+xLRuf2/M+QOhVr8n/FF182WWTnrIHCA2+9+ma7UlB5HHOdh
         e8CPTdqm6VRWbUdoPIqFTjpG3+Zpf63cwvbaRykfc/PLITFMzAld2qnah1ucDr+ruMcc
         SfVlk7Hne9w+Y6cUtVsee1w0WevMQVg6RrvUg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=BYGl0V9/trjgH6d8a0c7nIAyISSVAWNN4ZGs+k+qivh7X/OGYKH0Eso28AAZd41ck1
         WPLabCHgqzQy1OQQ/6I5hqlxnM3GhQz+iAq39mPl3Qj3VZOK8aLunoIQvKbZGduqO9ao
         BwulNHWN4tH/eBSfD0kY8F3GvSoVunImrny/A=
Received: by 10.142.166.6 with SMTP id o6mr127401wfe.75.1279715621338;
        Wed, 21 Jul 2010 05:33:41 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id c38sm1866469rvf.17.2010.07.21.05.33.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 21 Jul 2010 05:33:40 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151395>

Hi,

I returned to India a few days ago and got a lot of administrative
work out of the way. I also managed to become a little more familiar
with Subversion and committed svnrdump with some improvements to
trunk. Now I'll start focusing on finishing the dumpfilev3 parser so
that I can plug into svn-fe.

-- Ram
