From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH] Documentation/remote-helpers: explain capabilities
 first
Date: Fri, 18 Mar 2011 17:48:39 -0500
Message-ID: <20110318224817.GA25026@elie>
References: <20110318174504.GA22332@elie>
 <AANLkTimfZM6muiU3vPMgx3NnRdb4H0t4E2DMXt1233LP@mail.gmail.com>
 <20110318222107.GD23407@elie>
 <AANLkTiksEgm+n6nLQ=HYjdE1PV4-XfmJhwj39Wp1crmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Tomas Carnecky <tom@dbservice.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 23:49:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0iTj-0000Bo-Jt
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 23:49:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932627Ab1CRWsv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Mar 2011 18:48:51 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:36082 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756252Ab1CRWss convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Mar 2011 18:48:48 -0400
Received: by gwaa18 with SMTP id a18so1775355gwa.19
        for <git@vger.kernel.org>; Fri, 18 Mar 2011 15:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=lw4mgeYwmu0fcAIOslp9kVMmktQJGjSQ6kUcs76p0to=;
        b=JxZEW34JLi03S3+EtllcNuZk8K1eTxUg6YE6HN+fDDQAAWgPkGKE5Z2lsqYB6v6CY4
         AMX9a4abFVEciG5MS4r+ECbpWsgzOT5CZkpSqVLNzWmnG4OkZth6l0oKJYvbczrdpqOM
         n59HPlqZ5EngispnRRievxAL6SpBG5A+PBOjo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=odTho06nD6DRgCz6Jna5OZ/LN5FF23p5Mk5IzA+NdUnILrrcc8oPAVnRJwmckt/TV+
         qtSeVw9YYBCvD8vB5rKexgjr5FXmhDUFufkT+Rd+aVS9qilqNTb8eN72EPsNJ+f+qEhT
         OnMH1uNtKMcUHAMYLJQd21OuzYJngSbvSOO80=
Received: by 10.236.184.102 with SMTP id r66mr2362041yhm.25.1300488527431;
        Fri, 18 Mar 2011 15:48:47 -0700 (PDT)
Received: from elie (adsl-69-209-56-53.dsl.chcgil.ameritech.net [69.209.56.53])
        by mx.google.com with ESMTPS id h30sm2080712yhm.0.2011.03.18.15.48.44
        (version=SSLv3 cipher=OTHER);
        Fri, 18 Mar 2011 15:48:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTiksEgm+n6nLQ=HYjdE1PV4-XfmJhwj39Wp1crmg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169376>

Sverre Rabbelier wrote:
> On Fri, Mar 18, 2011 at 23:21, Jonathan Nieder <jrnieder@gmail.com> w=
rote:

>> Thanks for explaining. =C2=A0FWIW I'd be interested in your thoughts=
 on this
>> sometime (not now necessarily, just some time before the svn push
>> support project is on the front burner :)).
>
> Any idea on when that will be?

No, not sure.  My current priorities are

 - getting "git clone svndump-alpha::/home/jrn/dump/svn-kde0:1200000"
   to work;
 - mustering up the courage to clean up glibc vfprintf

After that, who knows?

But I hear that Ram has done some work on a fast-import to dumpfile
converter, so push support is definitely simmering even if there is
not much momentum yet.
