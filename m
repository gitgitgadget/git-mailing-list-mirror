From: Nicolas Sebrecht <nicolas.s-dev@laposte.net>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Sun, 5 Apr 2009 06:08:31 +0200
Message-ID: <20090405040831.GA18892@vidovic>
References: <20090404220743.GA869@curie-int> <20090405000536.GA12927@vidovic> <20090405T001239Z@curie.orbis-terrarum.net> <20090405035453.GB12927@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Sebrecht <nicolas.s-dev@laposte.net>
X-From: git-owner@vger.kernel.org Sun Apr 05 06:13:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqJjm-00014i-SI
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 06:13:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758401AbZDEEIl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 00:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758633AbZDEEIk
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 00:08:40 -0400
Received: from mail-ew0-f165.google.com ([209.85.219.165]:60984 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758623AbZDEEIj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 00:08:39 -0400
Received: by ewy9 with SMTP id 9so1470440ewy.37
        for <git@vger.kernel.org>; Sat, 04 Apr 2009 21:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=93nTMIJbJATuYIH46iEkamB/6DDhS8QZwbO1E4i9Vqc=;
        b=izO7eHL8tvra87TICuZEdptaiRxdglrJaCSySKzvhuy5PrAi1+XsoQxxT0FB9wXVbA
         tQMnin9kwp30++OstqIr8wxM6JDu6ak7V4qPaQk7aIVunUubWf0EFs5IiaNH7cU5Ls+c
         U2Nnc/2H/Q25BfI84eaw5AvPLlnlZtxpFpG6M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=CKOLMDqIrWWY/OQRbKQCxbTifafWiEDRUioNCFI5IU2VCgiVDMV82B7B2OxSee6yY3
         HTGdTec1TnFLFJmsTy/vHczicDrOBDNMNyidnxMb01iYPaPJSyLnJuuHoxGZr+1qYtxF
         qtsycachf+NKzyX+PgI2qvInYkjjEs4ust1NQ=
Received: by 10.210.21.6 with SMTP id 6mr2202341ebu.90.1238904515671;
        Sat, 04 Apr 2009 21:08:35 -0700 (PDT)
Received: from @ (ABordeaux-258-1-82-86.w86-201.abo.wanadoo.fr [86.201.73.86])
        by mx.google.com with ESMTPS id 7sm5003637eyb.40.2009.04.04.21.08.33
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 04 Apr 2009 21:08:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090405035453.GB12927@vidovic>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115632>

On Sun, Apr 05, 2009 at 05:54:53AM +0200, Nicolas Sebrecht wrote:

> One repo per category could be a good compromise assuming one seperate
> branch per ebuild, then.

s/ebuild/package/

-- 
Nicolas Sebrecht
