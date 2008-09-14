From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git at Better SCM Initiative comparison of VCS (long)
Date: Sun, 14 Sep 2008 23:29:01 +0200
Message-ID: <200809142329.03186.jnareb@gmail.com>
References: <200809131906.18746.jnareb@gmail.com> <20080914194802.GH28210@dpotapov.dyndns.org> <20080914210648.GB26608@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Dmitry Potapov <dpotapov@gmail.com>, git@vger.kernel.org,
	Alexey Mahotkin <squadette@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Sep 14 23:30:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KezAj-0000lF-5Q
	for gcvg-git-2@gmane.org; Sun, 14 Sep 2008 23:30:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753375AbYINV3O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Sep 2008 17:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753389AbYINV3N
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Sep 2008 17:29:13 -0400
Received: from an-out-0708.google.com ([209.85.132.250]:34712 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752623AbYINV3M (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Sep 2008 17:29:12 -0400
Received: by an-out-0708.google.com with SMTP id d40so171801and.103
        for <git@vger.kernel.org>; Sun, 14 Sep 2008 14:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=r/MCZheWSyls+CvWjHLMdoO5Z6dQI0BweHURudgMRkE=;
        b=i5W7eQb2ov0/kNzsCZ+V4hDd/dUxpJ7ruN4GPzb6zGGB0wYyNwIJH63tpPtlDjE0+d
         tCKJCD4FB6WZbFLMXvzxfu25hrUHWcIdAs/HjTQbr5ZP9AM6daxh8y9Mm5XowoFloOcG
         upp8ZYYlDJn8jA3zlVQdLc4wCjv+rsxGGtb+U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Wra6UWkv4T1YxN8/Bz9Fldmt35iqteK5zTgvg1wNnjvVCEpkp+hm04g3eJPzbb/W3V
         +QMjOg5GP3Op4mbmI/2sjWvSj/OqZ6NmNqc+76hup25C2bJefn5RgP9Gd2c1GYzvbgqe
         YfW60etU2nqQ1OoB8sTQ/mPl3/Oq7sD8sfkMs=
Received: by 10.86.93.19 with SMTP id q19mr5336013fgb.4.1221427750646;
        Sun, 14 Sep 2008 14:29:10 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.251.193])
        by mx.google.com with ESMTPS id d6sm14045550fga.2.2008.09.14.14.29.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Sep 2008 14:29:09 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080914210648.GB26608@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95869>

On Sun, 14 Sep 2008, Shawn O. Pearce wrote:
> Dmitry Potapov <dpotapov@gmail.com> wrote:
>> On Sun, Sep 14, 2008 at 07:48:05PM +0200, Jakub Narebski wrote:
>>> 
>>> [...] if it is possible
>>> using current hooks infrastructure to restrict changes coming from
>>> some account in such a way as to allow it only if all changes are
>>> restricted to specified directory. 
>> 
>> I believe the update hook should be able to do that. You have oldrev and
>> newrev, so you can run "git diff --name-only oldrev newrev" and see what
>> files are going to change. And then verify that the user has the write
>> access to this directories or files.
>> 
>> I have not tried it yet, and I don't think we have a ready example of
>> how to do that, but I believe that the example of the update hook that
>> restricts user access based on the target branch can be used as a
>> starting point.
> 
> contrib/hooks/update-paranoid can do both branch and file path
> level restrictions.  I used it at my prior day-job to prevent some
> accidental changes from folks who didn't usually need to modify
> certain parts of the repository.

Could you then update contrib/hooks/update-paranoid documentation?
It talks only about branch level restrictions (created, delete, 
fast-forward, forced update for a given ref class).

Thanks in advance
-- 
Jakub Narebski
Poland
