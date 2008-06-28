From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: Adding a 'version' command to the server
Date: Sat, 28 Jun 2008 14:25:20 +0200
Message-ID: <48662DB0.3010608@gmail.com>
References: <7viqvupm3l.fsf@gitster.siamese.dyndns.org> <486572BC.9070201@gmail.com> <20080628114337.GA3489@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 28 14:26:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCZVW-0001q6-O2
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 14:26:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751629AbYF1MZ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2008 08:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbYF1MZ0
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jun 2008 08:25:26 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:42134 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214AbYF1MZZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jun 2008 08:25:25 -0400
Received: by fg-out-1718.google.com with SMTP id 19so436360fgg.17
        for <git@vger.kernel.org>; Sat, 28 Jun 2008 05:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=WoKFmvV2QHdR8dzosVhaiaDWfVfZ64SuMBkaapipyDw=;
        b=qan6kXiwIPSX6alTSWg6NNYz+sxpnTMV6nD6UwmtlvsXkmkMjHHlCYaxM3N46ajpvq
         ivyxq77AXkIvoXf03Bg3te4ih+Mh6ywAKhDmnZMJYMqj/lPxudy9vwCrv422BfkssJWO
         KlgNjQq4H0DhfbB9VDicpvoIZ5UpPyNcwngrs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=KdD5sy/oF5QzfLgbYrU4uYN0smK2gOt0wPIPPUmFqS3Fx6jgRBHZ+54nGLDEt/ibUd
         Pt6QzKyLzJyv0DcewIHWuJeT4AQzhsA63HApf9capaUsCnHCCESoZ7sxfCbjNFeeG3q/
         BBSVhxdHob6HGHvG6xbKglNz8FbM4ktbEukF8=
Received: by 10.125.123.15 with SMTP id a15mr628252mkn.35.1214655924061;
        Sat, 28 Jun 2008 05:25:24 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.234.14])
        by mx.google.com with ESMTPS id g28sm5849998fkg.8.2008.06.28.05.25.22
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 28 Jun 2008 05:25:23 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <20080628114337.GA3489@steel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86714>

Alex Riesen wrote:
> And exactly how are the incompatibility problems avoided? By denying
> the service if the versions don't match?

No, by talking to older servers in a way they understand it.  So for 
instance it would call "git-upload-pack" instead of "git upload-pack".

(See also the SSH protocol with two versions, and I think Subversion's 
svnserve also somehow identifies its own capabilities and/or version.)

-- Lea
