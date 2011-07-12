From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 04/17] revert: Rename no_replay to record_origin
Date: Tue, 12 Jul 2011 12:02:56 -0500
Message-ID: <20110712170256.GC13578@elie>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <1310396048-24925-5-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 12 19:03:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QggMa-0003mq-MZ
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 19:03:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753262Ab1GLRDI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jul 2011 13:03:08 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:44908 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751203Ab1GLRDH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2011 13:03:07 -0400
Received: by gyh3 with SMTP id 3so2021855gyh.19
        for <git@vger.kernel.org>; Tue, 12 Jul 2011 10:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=RLPf+ReDqd5u7kL1oFChCDhI+xGTHqUN+SlrQpsXi6Q=;
        b=auvJdzaiUOlO2yP/YaXhoZwxiAj8kraJMDzuBCXnFfobb2O20xj2eXahNGbC0/YZpO
         MDfDDuKsgxC0a+hsmFWuaq8CZXYyY4XbY4y2jg4DwS3X8BJwbGc5TsAwNTMm22vkasm+
         8FQY96mKG2/9Kr9sxjTGpRp03nqloZpoe5dno=
Received: by 10.236.157.167 with SMTP id o27mr270171yhk.6.1310490185341;
        Tue, 12 Jul 2011 10:03:05 -0700 (PDT)
Received: from elie (adsl-69-209-70-6.dsl.chcgil.sbcglobal.net [69.209.70.6])
        by mx.google.com with ESMTPS id p50sm745369yhj.70.2011.07.12.10.03.02
        (version=SSLv3 cipher=OTHER);
        Tue, 12 Jul 2011 10:03:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1310396048-24925-5-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176952>

Ramkumar Ramachandra wrote:

> Rename the variable corresponding to the "-x" command-line option from
> "no_replay" to a more apt "record_origin".

Why is it more apt?  What does "-x" do?  Why was it called "no_replay"
before?  Is there some other motivation to this change (e.g., does this
pave the way to using the name "replay" for something else)?
