From: Gabriel Filion <lelutin@gmail.com>
Subject: Re: remote-bzr status
Date: Mon, 04 Oct 2010 14:03:36 -0400
Message-ID: <4CAA16F8.4050705@gmail.com>
References: <4CA8F2F1.5090407@gmail.com> <20101004061104.GH24884@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>, Sverre Rabbelier <srabbelier@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 20:03:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2pOH-00054A-Ji
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 20:03:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756721Ab0JDSDm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 14:03:42 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:39678 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756393Ab0JDSDm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 14:03:42 -0400
Received: by qyk10 with SMTP id 10so1495614qyk.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 11:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=csVb+4kx+4f79Z+sR2DzPhPArZMseKgzmDvySZOe6mg=;
        b=Aj69Wu2s4avFLj6jfDNLW8J17xGvdKi+ovEfGlvK2EIDe5AnGy/9A5GEFEFISsxR+i
         bdy5W5/nAK/D/Oyhr5HYfAcs+d8Ik2Y98PjKYtXXhMKooFNnk1aUznMv/6wgCo56HR+F
         WjCBEvO3xp3cHart4fxtjU3V8oNVEmKMNnAhc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=VtEZh/1kH2P4/3PWP+Hfi0leL1EmPY7Fi0ck9hbc6VHziNB8hl6XP4k/kOiOmp7377
         u3DP0kf7t8BsGBxjewXWiSxZRaHhCC3eGHebxuLNYEAZr3RyjpNHJbclR5wvJLGT7zSr
         /8FZY5eU3s+Hzm3lztBHEiqEe4ZA/1HhLq6jI=
Received: by 10.229.223.210 with SMTP id il18mr7255811qcb.133.1286215419766;
        Mon, 04 Oct 2010 11:03:39 -0700 (PDT)
Received: from [192.168.2.202] (dsl-150-76.aei.ca [66.36.150.76])
        by mx.google.com with ESMTPS id t24sm5818402qcs.47.2010.10.04.11.03.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 04 Oct 2010 11:03:38 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.11) Gecko/20100805 Iceowl/1.0b1 Icedove/3.0.6
In-Reply-To: <20101004061104.GH24884@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158076>

On 2010-10-04 02:11, Jonathan Nieder wrote:
> What is the license on your code (if any)?

hmm right, there's nothing about this in the repo yet..
I guess I'd put a GPLv2 license on it to be similar to git's license.

> Would you be interested
> in including it in contrib/ or core git?

yes I would (after review from the community, and when the code reaches
better functionality and testing.) It would mean greater visibility for
the code, added functionality to git and the possibility for more
maintainers to help ;)

My original plan was to try and make the helper work both ways, and then
to incorporate it into git.git to build patches on top of master (since
it's a new feature that should be working on the current master).

-- 
Gabriel Filion
