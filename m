From: Chengwei Ding <waterding@gmail.com>
Subject: git annotate with date option not working?
Date: Wed, 01 Jun 2011 10:20:37 +0200
Message-ID: <4DE5F655.9020400@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 01 10:21:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRgg4-0001kM-8l
	for gcvg-git-2@lo.gmane.org; Wed, 01 Jun 2011 10:21:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162455Ab1FAIUt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2011 04:20:49 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:41638 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161810Ab1FAIUp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2011 04:20:45 -0400
Received: by ewy4 with SMTP id 4so1898562ewy.19
        for <git@vger.kernel.org>; Wed, 01 Jun 2011 01:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :subject:content-type:content-transfer-encoding;
        bh=yD8zJo6kzCeViXll0x5pVrTQ37A2sjE0YCJQmkHpb3Y=;
        b=mnset88JFKSn0AqfQ9DAsL+jiiTRfSTpDIwpheOdm2gizi5QFbu1AzPgHK4tAJtEYw
         3017nFAiedP4UZTQKJp5zKxqUKOYbSAbltTfADL/lOdogX3qrym7nhmjtKCVH7XjM3pN
         3NN4bNKaBJIyFhttuIrDUtGEdYOhtC1QaOYeE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=uJS4PPnZ6815m9sY55yEtk/sLQ621IeamS8Jkmv5U1yBCjbJlZQ8UxvIfw59wW5bT6
         uIKQ5ZOvs+jZbjeMug54KTTcG+FUAUY2wVECd3zC7Gu8JdXYhW7U1OqEBvX54cTpzV/0
         KWOSeo64Ty9ZAXkZFswdpZ8Kr4SMIFcJbi+lg=
Received: by 10.213.109.85 with SMTP id i21mr1778706ebp.39.1306916443715;
        Wed, 01 Jun 2011 01:20:43 -0700 (PDT)
Received: from [10.20.9.95] (mail.kreditor.se [213.136.42.60])
        by mx.google.com with ESMTPS id x3sm547148eef.17.2011.06.01.01.20.41
        (version=SSLv3 cipher=OTHER);
        Wed, 01 Jun 2011 01:20:42 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110424 Lightning/1.0b2 Thunderbird/3.1.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174853>

hello,

can anyone confirm that this "--date" option is working for git annotate 
cmd.

i tried the same option on blame cmd which seems to be working, but not 
on the annotate which i use git annotate --date=relative or i wrote date 
config variable as blame.date which again work for blame but not 
annotate, but document says it should share same variable.

my env:
ubuntu 11.04 64
git ppa source 1.7.5.2

Regards
