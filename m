From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: Git push to samba/cifs share fails
Date: Sat, 31 Mar 2012 20:47:40 +0200
Message-ID: <4F77514C.10205@gmail.com>
References: <4F75DDF9.8060305@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Emanuel Rietveld <codehotter@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 31 20:48:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SE3LE-0005kL-Cw
	for gcvg-git-2@plane.gmane.org; Sat, 31 Mar 2012 20:48:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751568Ab2CaSr4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Mar 2012 14:47:56 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:57328 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898Ab2CaSrz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Mar 2012 14:47:55 -0400
Received: by bkcik5 with SMTP id ik5so1447268bkc.19
        for <git@vger.kernel.org>; Sat, 31 Mar 2012 11:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=VQyWP16FgFslesHk/p0vAhehrOYk2VJbYahB1d8O03s=;
        b=asZaTkKF6/+Oz/CVFBGDHNCWCnnxq0Pzxqe025y7VtGs5Ly7Ngp3qvSaVfzv4b5KIG
         BGGoOFceXdzCXDQBBa0IRpoHsTi1sLHn7Ljld9pmAuRrkBeZZ8QVgnfU5wIK+5GUkK9r
         sPVWNkiIjpi5xx5FkkXmP2MCLquxIt9xxT+D77jY90ozgpZeZXDOgC2Pllep9fHrFevK
         LJMTGktOzkrh4bTPJ8e5Sq5CL4xUWjQjGbYU8mWoAjxwN74Uu+LPSG/Yd/RZkrMhRkwB
         51o2SvVMqvHTFzhSYByxOfLYXsXIBdIfnGYGUvVO/s/8B+p5DjIWrCZ6d2vndHt4jAUb
         MDzA==
Received: by 10.204.151.86 with SMTP id b22mr1173322bkw.81.1333219674146;
        Sat, 31 Mar 2012 11:47:54 -0700 (PDT)
Received: from [192.168.178.22] (p5DDB0164.dip0.t-ipconnect.de. [93.219.1.100])
        by mx.google.com with ESMTPS id s16sm27831705bkt.3.2012.03.31.11.47.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 31 Mar 2012 11:47:52 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <4F75DDF9.8060305@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194460>

On 30.03.2012 18:23, Emanuel Rietveld wrote:

> I get an error message when I try to push my git repository to a share
> mounted with mount.cifs.

Hmm, I wonder if this is related to msysgit's "Cannot fetch to mapped 
network drives (Samba)" issue here:

http://code.google.com/p/msysgit/issues/detail?id=130

Please note that the msysgit issue tracker is closed, so you should not 
place any comments there. Post to the msysgit mailing list instead.

-- 
Sebastian Schuberth
