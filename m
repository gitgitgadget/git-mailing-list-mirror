From: MrUnleaded <mrunleaded@gmail.com>
Subject: Re: git svn import fails.
Date: Mon, 13 Jul 2009 13:49:57 -0700
Message-ID: <fe66c02a0907131349p708e4a16hde3cd9b9c7a7a9a3@mail.gmail.com>
References: <fe66c02a0907131343m5c05af68n88a749c08d3dc70a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 13 22:50:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQSTV-0007o9-3o
	for gcvg-git-2@gmane.org; Mon, 13 Jul 2009 22:50:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757194AbZGMUuA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jul 2009 16:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757175AbZGMUuA
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Jul 2009 16:50:00 -0400
Received: from mail-qy0-f192.google.com ([209.85.221.192]:60027 "EHLO
	mail-qy0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755725AbZGMUt7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jul 2009 16:49:59 -0400
Received: by qyk30 with SMTP id 30so967352qyk.33
        for <git@vger.kernel.org>; Mon, 13 Jul 2009 13:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=esBJqBvK0vkGe7I8xbd86JxsaMWl4yvQSnI8GSy4nJc=;
        b=mV12IXCCk0LBsRr2g3aUzYg1jyMg8BclNBuK09Mvx3tOEcU5+bGiU98BRxI/x78Fck
         K9j3qDFUMXjvP54T0ZtwDYNzbQITmH4NK1Lz0soVLlht3upjU1gbvECCuS/jauaHl69e
         3Zy132fSa1UShM2vmeZ7RbopW6iI4PsdUFRUs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=vcQGWdfobPFBKyI53q7xTvh4oJZAeX+PfAurqf33OMpQQ6Lrs5SDnFIi298caENuB/
         qP+3eSx6jXm80thCatGcCyAGnLa0/HBofWSqjT/zohwzU7KEETMFdDb033JJ7b35kYJI
         0/onOQQoi/g10g3trmSvYzyEDdMNEGkzwPuKk=
Received: by 10.229.81.136 with SMTP id x8mr840962qck.95.1247518198022; Mon, 
	13 Jul 2009 13:49:58 -0700 (PDT)
In-Reply-To: <fe66c02a0907131343m5c05af68n88a749c08d3dc70a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123203>

Hello, I have been attempting to import a public repo but it seems to
fail predictably at the same revision with the following error:

RA layer request failed: REPORT request failed on
'/svn/!svn/vcc/default': REPORT of '/svn/!svn/vcc/default': 200 OK
(https://mosa.svn.codeplex.com) at /usr/local/libexec/git-core/git-svn
line 4505

I have tried the following:
git svn clone https://mosa.svn.codeplex.com/svn/trunk

git svn clone -s https://mosa.svn.codeplex.com/svn

I have also tried git svn rebase once it fails on the clone.

Each time it fails on the same revision.

If anyone has any suggestions I would appreciate it.

Thanks.

-- 
Kevin
