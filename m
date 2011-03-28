From: David Barr <david.barr.cordelta@gmail.com>
Subject: Re: vcs-svn: integrate support for text deltas
Date: Mon, 28 Mar 2011 22:56:17 +1100
Message-ID: <E60A9EC9-DD21-46A8-9BB6-2A5FBC6FF6A9@gmail.com>
References: <1300518231-20008-1-git-send-email-david.barr@cordelta.com> <1300519254-20201-1-git-send-email-david.barr@cordelta.com> <20110328070015.GE11987@elie>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: David Barr <david.barr@cordelta.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Tomas Carnecky <tom@dbservice.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 13:56:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4B3e-0005IT-LH
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 13:56:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753169Ab1C1L40 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 07:56:26 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:64693 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347Ab1C1L4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 07:56:25 -0400
Received: by iyb14 with SMTP id 14so3044925iyb.19
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 04:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:mime-version:content-type:from
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to:x-mailer;
        bh=OFw3rn3qHYTLTMsVU2kDUxbVPHNohxIjFoVzLcWRZ28=;
        b=jUp8e4gnuqC8MVtg/As+q8EYEaQ2ASSRigp0//oWHw6BMq18Mx2frHnhS0Nfu1mi9T
         zECjTKhaeTcDYl0z3gRb154v+NzjzGhc3iyQysyo1sBJi6nIzgjevU/33cdoCShTTJeu
         ZR4iCqNzDWACceTzwc66ZdUY3g7LnIW2GmKvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=qORc4+RsUcfFjuP4cNSLFuLKsnIGUXTL26knNPeedfyhES9FIpJfkMY1yTb1w+A6hy
         WTEI5DxgP5EdUr7Y1NNVu67HU25FCQKaT7Aj/vYimKx8q44AOWLG+OmZGmE/UyK9Broa
         VwdYVif4OM/R5+1yN8jlQOCooH4XKAYZZ2ZyY=
Received: by 10.42.154.198 with SMTP id r6mr3762866icw.166.1301313384566;
        Mon, 28 Mar 2011 04:56:24 -0700 (PDT)
Received: from [192.168.1.1] (d110-33-88-245.mit3.act.optusnet.com.au [110.33.88.245])
        by mx.google.com with ESMTPS id 8sm2913111iba.55.2011.03.28.04.56.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 Mar 2011 04:56:23 -0700 (PDT)
In-Reply-To: <20110328070015.GE11987@elie>
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170116>

Hi,

> Thanks much for digging this up.  (To think, it's been half a year
> since the svndiff0 parser was written!)  I've queued everything except
> patch 16, and grabbing patch 16 on top of db/delta-applier +
> db/vcs-svn-incremental should be just a formality.


Once more, I'll run the tests just in case there's any regression.
(Having applied the aforementioned skipped patch.)

--
David Barr.
