From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [ANNOUNCE] GIT 1.5.6.2
Date: Sun, 06 Jul 2008 01:09:08 -0700 (PDT)
Message-ID: <m38wwffn3b.fsf@localhost.localdomain>
References: <7vy74fo9t4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 06 10:10:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFPK3-0006tD-EL
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 10:10:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751803AbYGFIJN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 04:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751855AbYGFIJN
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 04:09:13 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:3427 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798AbYGFIJL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 04:09:11 -0400
Received: by fg-out-1718.google.com with SMTP id 19so663513fgg.17
        for <git@vger.kernel.org>; Sun, 06 Jul 2008 01:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=w8zvzgIFFiER4AnQn/rGN/voE382xL6NXyUUvPx2vjs=;
        b=ulzGCfO5plSwrynehJQem/MNNm5390ikm+Rlj0tJMONIAReBV2rXnfQlzpOtWIZeMN
         cnWca5fObnFzVkJvWwMgGClfidxtQmz1t4mlnGHIcn94/alBeDykygj9RzN8c1jpHg2v
         zMonWoAFARrPGVM9Gf01yDMZ6upH4BiNj7n2k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=styZDmzGbYoKMX09eYS6Fb3YwjphRdvqM3mn4lW16ISLY6tsG4Xm9ZLAhSYzlBEKSz
         /rueYiQpq7xjMVr/jNm0bv5YRRWY2eSZ1BvMzTRd0msIajjdkmWsH8Nqilx6QKu2v22P
         mV4ZOwHAPW0azBAS/nCAVUG/cXO4Ui5w3P6Fo=
Received: by 10.103.24.11 with SMTP id b11mr1374760muj.77.1215331749229;
        Sun, 06 Jul 2008 01:09:09 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.224.192])
        by mx.google.com with ESMTPS id w5sm10027641mue.11.2008.07.06.01.09.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Jul 2008 01:09:08 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m668CVoX028524;
	Sun, 6 Jul 2008 10:12:42 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m668C9fb028519;
	Sun, 6 Jul 2008 10:12:09 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vy74fo9t4.fsf@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87503>

Junio C Hamano <gitster@pobox.com> writes:

> The RPM binary packages for a few architectures are also provided as
> courtesy.  As the machine I cut them at kernel.org has been updated to FC9
> recently, their filenames now have .fc9. in them.
> 
>   RPMS/$arch/git-*-1.5.6.2-1.fc9.$arch.rpm	(RPM)

This unfortunately includes also SRPMS (.src.rpm), even though the
source RPM from git repository is not distribution specific.  I think
that src.rpm should drop '.fc9.' from name

-- 
Jakub Narebski
Poland
ShadeHawk on #git
