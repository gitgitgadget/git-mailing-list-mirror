From: "Jonas Fonseca" <jonas.fonseca@gmail.com>
Subject: Re: [JGIT RFC PATCH] Improve handling of parsing errors in OpenSshConfig
Date: Thu, 25 Sep 2008 16:30:19 +0200
Message-ID: <2c6b72b30809250730kf643fb3p9881e82b998ca100@mail.gmail.com>
References: <20080925083934.GB10273@diku.dk>
	 <tQAHDMR4.1222342394.9002900.roro@localhost>
	 <20080925132937.GA16151@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Robin Rosenberg" <robin.rosenberg.lists@dewire.com>,
	"sverre@rabbelier.nl" <sverre@rabbelier.nl>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Robin Rosenberg" <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Sep 25 16:31:50 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KirsR-0005tt-Ei
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 16:31:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752191AbYIYOaW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 10:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752188AbYIYOaV
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 10:30:21 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:61699 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752162AbYIYOaV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 10:30:21 -0400
Received: by gxk9 with SMTP id 9so7042356gxk.13
        for <git@vger.kernel.org>; Thu, 25 Sep 2008 07:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=eh6jUhP7jepuvjbnTx1UJIZymH55NbpGF9Gb4HeXe1Q=;
        b=n/CkOo0PRjjvQyhpiukKbT44yK1HZoVwMpxYJ8wxEhR8xJfWAsQaSn3+9adM/QQo0W
         Tm8yd/Q2r2DBCZBORzoGCPNp6yDBAiWMs+sR+x1X0LXsBcsOrPwAVguWBfSZJomJg5Yy
         JCUigBA/DNiHqqlFOVnXh10p0BM8aive4z93M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=XONpaKFGRZA9gAj8TKe8M2OFmv8Qb/tvzCvBbvzxVzrmLUVfU8TCEI6RQCRZF82BrG
         JhbEqWJLvGM5WZT6rJM1DFaThsCwcUPdMMFUaOYBAQZEcfutleoMxT/lDS1lt53obkLn
         kpSbKsjQeDZCMVn99TFdcT8u4Bu9Q1ujdCITk=
Received: by 10.142.47.6 with SMTP id u6mr3147339wfu.300.1222353019589;
        Thu, 25 Sep 2008 07:30:19 -0700 (PDT)
Received: by 10.142.153.19 with HTTP; Thu, 25 Sep 2008 07:30:19 -0700 (PDT)
In-Reply-To: <20080925132937.GA16151@diku.dk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96767>

On Thu, Sep 25, 2008 at 15:29, Jonas Fonseca <fonseca@diku.dk> wrote:
> Badly quoted entries are now ignored similar to how bad port number are
> currently ignored. A check for negative port numbers is now performed
> so that they also will be ignored.

Sorry for spamming this list today. The commit message should of
course read something like:

Throw an OpenSshConfigException when parsing meet badly quoted entries
and port numbers, which do not contain numbers or are negative.

-- 
Jonas Fonseca
