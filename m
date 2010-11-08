From: David Barr <david.barr@cordelta.com>
Subject: Re: Status of the svn remote helper project (Nov, 2010)
Date: Mon, 8 Nov 2010 17:20:02 +1100
Organization: Cordelta Pty Ltd
Message-ID: <201011081720.02961.david.barr@cordelta.com>
References: <20101107112129.GA30042@burratino> <201011081456.26618.david.barr@cordelta.com> <20101108061140.GB29738@burratino>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 08 07:20:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFL5V-00049D-TW
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 07:20:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239Ab0KHGUJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 01:20:09 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:60096 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994Ab0KHGUI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 01:20:08 -0500
Received: by gxk23 with SMTP id 23so3124096gxk.19
        for <git@vger.kernel.org>; Sun, 07 Nov 2010 22:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:organization:to
         :subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:message-id;
        bh=VRZjVpyV+xVySb9mIxzFjqDKLfSJpAwwvnoGxSIZXYY=;
        b=fZ5ndeVfW1NbFG8yPEEdzITKFFejQLI1XOpiMITiBsMbHKPYsvf9w/Sbnc2pNLzZem
         vukHPIKdBWKymI8h/QAbVrXfcRwRlGzVU2/Q722LGo1hOmxm9+JhmbdQi+Y8dGnGqjwS
         ISI7t1dhR80LJi4Kd+7urhc1b6ewnqiFpPN04=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        b=fgIDgE8zWUanrad6zXo4/N9YXGRckp+40mGw6qgJU7+fxYaOXgYNfdLY/O3obJq/cz
         NjjZTMcUUHJMMsrzNnyjrOjq5CXcHKGv5x62jXw6kwOTN2pKkJ9uT/K4LqFi2apPThgf
         gEbzsHmxktLZljHiuNnsZDrxJY307FjuBJy9E=
Received: by 10.150.186.10 with SMTP id j10mr7887430ybf.364.1289197207767;
        Sun, 07 Nov 2010 22:20:07 -0800 (PST)
Received: from dba.localnet (mailhost.cordelta.com [119.15.97.146])
        by mx.google.com with ESMTPS id p1sm3423492ybn.17.2010.11.07.22.20.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Nov 2010 22:20:06 -0800 (PST)
User-Agent: KMail/1.13.5 (Linux/2.6.35-22-generic; KDE/4.5.1; x86_64; ; )
In-Reply-To: <20101108061140.GB29738@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160911>

Hi,

> >>> [Cooking]
> >>> * jn/svndiff0 (2010-11-06) 24 commits
> [...]
> > I've successfully tested this series against the ASF repository
> > (940,166 revisions) and 5,636,613 blobs were faithfully reproduced.
> 
> Thanks!  Was that using svn-fe, test-svn-fe -d, or some other program
> using the vcs-svn lib?

That was using svn-fe:
svn-fe < svn-asf-public-r0:940166 3<backflow | git-fast-import --cat-blob-fd=3 
3>backflow

--
David Barr.
