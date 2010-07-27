From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Recommended work flow with git to send in patches
Date: Tue, 27 Jul 2010 21:09:03 +0530
Message-ID: <20100727153901.GA5351@kytes>
References: <AANLkTiksAOpFG3vGVGcbeZ0NcpQ5FbDjnZ7yDxUsAY_r@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tong Sun <suntong@cpan.org>
X-From: git-owner@vger.kernel.org Tue Jul 27 17:40:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdmH0-0004MD-PR
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 17:40:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754927Ab0G0Pkt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jul 2010 11:40:49 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:62047 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752725Ab0G0Pkt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 11:40:49 -0400
Received: by pwi5 with SMTP id 5so498811pwi.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 08:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=hJCIRRNLFbjciU1r1njIjmwt3AMdXmxIbPMKN+LC3Qo=;
        b=wjyfJTW+iVdxyYjbzCEwV/FqtcJ2RpPOW3VLe8bX6HVeOqK4VLU6UGwqdkxy7Z8lq6
         OOb8GWC9fG6BYmhFzs1dXbIektwLEwKvrXOidnhsvQ+TzjMvYthUOcWJi1xw3jTwzBm3
         eYtQmBQZFPJ4CrJU7woGeEbTIIKhZIyWjnZw0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=U7wlgpzD1POJiZf1BIhmRk4ucr2Ke2POn4pmSHCEHuqcMTprE7VlKp41BLBgrj4dPV
         uYlBnFIyvbw+VSgUqi8+QkVU7KrM/l2VJdMZpJC9s0Hb2pggMe6kwcqTDs3Yl333DVVy
         0AHuTZUnsMvj7rNqZzVoAMpxC5wzDR9ignh2g=
Received: by 10.142.187.9 with SMTP id k9mr753710wff.153.1280245248060;
        Tue, 27 Jul 2010 08:40:48 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id 33sm5801727wfg.21.2010.07.27.08.40.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 Jul 2010 08:40:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTiksAOpFG3vGVGcbeZ0NcpQ5FbDjnZ7yDxUsAY_r@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151950>

Hi Tong,

Tong Sun writes:
> Compressing my "life long story" into a single question -- what's the
> recommended work flow to work with git and send in patches, when
> upstream might be slow in respond, and require squashing relevant
> patches into one?

Personally, I use `git symbolic-ref` to create a new branch without
history, stage and create commits to send off to the list from there;
it's also worth noting that I keep the branch to fixup my commits and
re-roll after reviews.

-- Ram
