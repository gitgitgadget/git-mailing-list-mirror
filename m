From: Yann Simon <yann.simon.fr@gmail.com>
Subject: Re: [egit] Git repository with multiple eclipse projects ?
Date: Thu, 26 Nov 2009 09:39:11 +0100
Message-ID: <551f769b0911260039u1f75decg66eded8069e67791@mail.gmail.com>
References: <20091125164734.GF21347@linagora.com>
	 <20091126004817.GL11919@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Yann Dirson <ydirson@linagora.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Nov 26 09:39:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDZsn-0007cu-2n
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 09:39:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753475AbZKZIjI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Nov 2009 03:39:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753365AbZKZIjI
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 03:39:08 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:9610 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752753AbZKZIjH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Nov 2009 03:39:07 -0500
Received: by fg-out-1718.google.com with SMTP id e12so218273fga.1
        for <git@vger.kernel.org>; Thu, 26 Nov 2009 00:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3Tas+ppjRS/Cf+9HQzP0uXihYUHYGegO5/PydB0c5ik=;
        b=tPDnc1FxB9S8As3fTBF3A3TB8kwPGURIusQmrcNpBd/S9rBnHRt96edIOb4VDxm8Bv
         uX/HC2Jjjr4hLbhIRHNfg9mY//dnYI/8tCYx6qBqOGsF1RHfJDMQNyNIaimeWjnZ8Dvy
         oi2Km5LMMsjWN/KG+Let21zRYjzP6+HeWGnKk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=kebA+yEKY0MVrdQijqzgTKVeugFCSjKzBnwUB3wntGQC4gBxIxjUIo2VS1W53+YJzW
         Q8gfWTe+EMsuQRv2utJ3sU0fweJLP38OtJJzxRt8SYd/QEWk3rvVEkfinSOSlv6XiQLq
         XBFO8oTDlrKQHeLvwahMCKYia39OOSIPEiKyQ=
Received: by 10.239.144.100 with SMTP id n36mr896502hba.19.1259224751553; Thu, 
	26 Nov 2009 00:39:11 -0800 (PST)
In-Reply-To: <20091126004817.GL11919@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133778>

2009/11/26 Shawn O. Pearce <spearce@spearce.org>:
> Yann Dirson <ydirson@linagora.com> wrote:
>> It also does not look like it would be possible to use the "share"
>> functionnality to setup such a repository from multiple projects (or
>> from a project set), right ?
>
> Nope, I don't think this is supported right now. =C2=A0You need to
> initialize the git repository by hand in the higher level directory
> that holds the projects.

That was the question I initialy understood.
