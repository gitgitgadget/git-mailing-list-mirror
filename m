From: "Morten Welinder" <mwelinder@gmail.com>
Subject: Re: Error "fatal: cannot pread pack file: Success"
Date: Wed, 28 Feb 2007 11:42:39 -0500
Message-ID: <118833cc0702280842g3e121fg601d7e102956ba93@mail.gmail.com>
References: <17892.64236.443170.43061@lisa.zopyra.com>
	 <20070228035713.GC5597@spearce.org>
	 <20070228044719.GA6068@spearce.org>
	 <17893.40847.313519.283218@lisa.zopyra.com>
	 <17893.42063.186763.291346@lisa.zopyra.com>
	 <20070228155412.GC5479@spearce.org>
	 <17893.43522.511785.121778@lisa.zopyra.com>
	 <17893.44181.129918.669187@lisa.zopyra.com>
	 <20070228163256.GD5479@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Bill Lear" <rael@zopyra.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 28 17:42:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMRtB-0004Nt-C7
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 17:42:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752264AbXB1Qmp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 11:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752265AbXB1Qmp
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 11:42:45 -0500
Received: from wr-out-0506.google.com ([64.233.184.237]:63344 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752259AbXB1Qmo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 11:42:44 -0500
Received: by wr-out-0506.google.com with SMTP id 58so283667wri
        for <git@vger.kernel.org>; Wed, 28 Feb 2007 08:42:43 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dq1qx6s6AZZA20DJ/7l1mTxT7oeyBdmXX/u3ZZnTFmwfBMt9SlOIyJGgU9VKdtJnK9aOSraYSf8qtZ//u+k/gxH7pgQ4I+bSou5J545vgJEuoiOVgwSnMEeWWwOoMuqg/x7+4a2HpujiYO2S6XT3UZ/e7D/i7Cd+R0XPyRUCW9U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gK+370g+NkKezaah7u0Ub4ntlcFCLbSpGu1Nyu3Is9E4E1LSeEijulptR0CXZ1l0rDVOrs2EKhX2WBeQlbkfkbdyfV3OzN4wrs65Bdd8M68REYOuge1r2TpgRGOjD0L5FGkS1nhgNrDa2BKnBwAJDLGNAsO1nSVicaszHqMvnSY=
Received: by 10.114.72.1 with SMTP id u1mr122595waa.1172680959989;
        Wed, 28 Feb 2007 08:42:39 -0800 (PST)
Received: by 10.115.109.18 with HTTP; Wed, 28 Feb 2007 08:42:39 -0800 (PST)
In-Reply-To: <20070228163256.GD5479@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40961>

> +                       die("cannot pread pack file: %s from=%lu, packfile size=%lu", strerror(errno), from, lseek(pack_fd, SEEK_END, 0));

That might give you the errno from the lseek call.

Morten
