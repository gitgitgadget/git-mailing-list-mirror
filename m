From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH TAKE 2] Avoid a useless prefix lookup in strbuf_expand()
Date: Sun, 10 Feb 2008 08:00:23 +0100
Message-ID: <e5bfff550802092300i38408493r4d5758c1fc16b0d5@mail.gmail.com>
References: <1202568019-20200-1-git-send-email-mcostalba@gmail.com>
	 <alpine.LSU.1.00.0802100252030.11591@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 10 08:01:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JO6BQ-00079d-7n
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 08:01:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754181AbYBJHAZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 02:00:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753983AbYBJHAZ
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 02:00:25 -0500
Received: from rv-out-0910.google.com ([209.85.198.186]:17856 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753879AbYBJHAY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 02:00:24 -0500
Received: by rv-out-0910.google.com with SMTP id k20so3008430rvb.1
        for <git@vger.kernel.org>; Sat, 09 Feb 2008 23:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=m8Ib2cD7NAjNTrYjrDEXcYnjyOhwrx82skDV4yKQMEY=;
        b=rRiGOJgDbrBYFh6wfNeDCgWyUxW6o+LUQ93QMfFhyVAHIvQXM2sAhSe+CfVy3SjpgrUAwht2MJ073G00voElN8AGqx5X8SUXEaM4j4dxTjRlB95NrpV7iOBW5LHzzELCnL9VR+AqaQcBLs3KzZY0kNslQa1/7JMfChY2LNVhdWA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Z7ZNTTcsvS7xMqhWe6CeP9+s4DF9SYNw4cc4sssnKPzj1hJoWlP4QYX9aAbG9PPxT9L7cyHPb9rxiriV/TWrpTwPbhWWQ2tkVqu2aVnrHuZJHeW3eks0Sf+GvDixlzL0P5SdEv1TtG4RrraOU+6rlEtcjCi/ERcSG3ZEQtIaPyc=
Received: by 10.140.188.10 with SMTP id l10mr9533510rvf.6.1202626823786;
        Sat, 09 Feb 2008 23:00:23 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Sat, 9 Feb 2008 23:00:23 -0800 (PST)
In-Reply-To: <alpine.LSU.1.00.0802100252030.11591@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73321>

On Feb 10, 2008 3:52 AM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Sat, 9 Feb 2008, Marco Costalba wrote:
>
> > +     /* bougus commit, 'sb' cannot be updated, but
>
> s/bougus/bogus/
>

Yes :-) you are right.

Thanks
