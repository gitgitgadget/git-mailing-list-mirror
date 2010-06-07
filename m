From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: DWIM "git checkout frotz" to "git checkout -b frotz origin/frotz"
Date: Mon, 07 Jun 2010 09:53:27 +0200
Message-ID: <4C0CA577.6080103@gnu.org>
References: <20100605110930.GA10526@localhost> <vpqljas5e33.fsf@bauges.imag.fr> <20100606164642.GA10104@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	Peter Rabbitson <ribasushi@cpan.org>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Jun 07 09:53:40 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLX9M-0003iB-Vb
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 09:53:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212Ab0FGHxc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jun 2010 03:53:32 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:43319 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756372Ab0FGHxb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jun 2010 03:53:31 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1525776fga.1
        for <git@vger.kernel.org>; Mon, 07 Jun 2010 00:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=w0DF5Iw14B49siMIdkYPQNUJnLuOsiRVjqiEbPa+CjE=;
        b=NJs1rmxuyEaio2gxVsXzxWZ0f+dz4hBr7Pmwuc1++mz9N3Bc8dXJgvd2PsD3uyedyI
         aMJvEsoW3Rk/htFT74cRkz6tK3wxwdOQC7cSqNRB94y7s2rrYUMgMD0rasFCY4blcmml
         1zItcSAWx8NziKkm/Zq3Mr3LVgpaKAd9FYIMc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=g+rot4a4G7gzzoKUyRT/N0eu/v1m4CquH0A4yIzZ9X7MCJOtjH/6gCZjMf6gY4aVxX
         NSO/isPHpY8WeUn/SOFUQkpYy93STWSv4RtoGgaGR1JnLAKuBHTNtRObDhgzV03aGopJ
         zR8dwK+ZB9ZB83Mu305nk6K/Qi07Zh6oF4Neg=
Received: by 10.87.68.7 with SMTP id v7mr22141780fgk.71.1275897209879;
        Mon, 07 Jun 2010 00:53:29 -0700 (PDT)
Received: from yakj.usersys.redhat.com (s209p8.home.99maxprogres.cz [85.93.118.17])
        by mx.google.com with ESMTPS id h2sm5611581fkh.25.2010.06.07.00.53.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Jun 2010 00:53:29 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100430 Fedora/3.0.4-3.fc13 Lightning/1.0b2pre Thunderbird/3.0.4
In-Reply-To: <20100606164642.GA10104@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148583>

On 06/06/2010 06:46 PM, Clemens Buchacher wrote:
> That is exactly my point. Trying to read the user's mind is not a
> solution to this problem. The user does not even know what they are
> doing and will inevitably end up even more confused.

Maybe you just want branch.autosetupmerge = false?

Paolo
