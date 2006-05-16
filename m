From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Pickaxe usage question -- only matching on added string
Date: Tue, 16 May 2006 15:37:26 +1200
Message-ID: <46a038f90605152037g1498bbfbm8d652ee9ff760ead@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue May 16 05:37:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfqNP-0002Y5-VJ
	for gcvg-git@gmane.org; Tue, 16 May 2006 05:37:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbWEPDh3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 23:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbWEPDh2
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 23:37:28 -0400
Received: from wr-out-0506.google.com ([64.233.184.238]:55911 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751107AbWEPDh1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 May 2006 23:37:27 -0400
Received: by wr-out-0506.google.com with SMTP id i28so992837wra
        for <git@vger.kernel.org>; Mon, 15 May 2006 20:37:27 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=qylWM+IXDHqQpld+o8RJaX/GbpGlYy1AxCy4ITt7Fx+1kLqJPcsG4pgDPsenuca2gcBDhBGrO2xCeu4H1miPjzzyK3tRcNXRtbrvUqLwOq/JipxsaFjd77iaESUf8o07Aa5xpWBxH2CuCR3cYguKyKtUedfH9rK4XwdPMOBfZ+Q=
Received: by 10.54.66.8 with SMTP id o8mr6997984wra;
        Mon, 15 May 2006 20:37:27 -0700 (PDT)
Received: by 10.54.127.17 with HTTP; Mon, 15 May 2006 20:37:26 -0700 (PDT)
To: git <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20098>

Documentation for diffcore-pickaxe (in Documentation/diffcore.txt) says:

When diffcore-pickaxe is in use, it checks if there are
filepairs whose "original" side has the specified string and
whose "result" side does not.  Such a filepair represents "the
string appeared in this changeset".  It also checks for the
opposite case that loses the specified string.

Now, is there a way to get diffcore to match only on 'added' (or on
'removed', for that matter)? I am tring to identify commtis that added
patches to a project, and I seem to be getting matches that add and
remove when I do:

   git-whatchanged -p -C -S"\t" master

cheers,


martin
