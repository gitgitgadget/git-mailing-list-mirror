From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [PATCH v2] Re: use "up-to-date" instead of "uptodate" for
 consistency
Date: Wed, 7 Jul 2010 07:46:21 +0200
Message-ID: <20100707054621.GC13054@vidovic>
References: <AANLkTimvQ8_SKa_VSvQk1_c3aRVv1lZCMYNOVLXBuC4W@mail.gmail.com>
 <b49995cd151b36cfff5231b28f5e8ff3970c14a2.1278431239.git.nicolas.s.dev@gmx.fr>
 <7v8w5n2744.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wincent Colaiuta <win@wincent.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 07 07:46:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWNSp-0007pB-OU
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 07:46:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752328Ab0GGFq0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jul 2010 01:46:26 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:64319 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937Ab0GGFqZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 01:46:25 -0400
Received: by wyf23 with SMTP id 23so2956733wyf.19
        for <git@vger.kernel.org>; Tue, 06 Jul 2010 22:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=csQTsHTQlq+0vyF9lcJ+6xytD330Spcfe+I1BBfRtUY=;
        b=ju15mWEs3zQlJt71FHSWUxkfJIuRPJXk3hmifKc/vxw/maZWsN+CKxtOVBlZ9lApJY
         eklK6ExVZEqf04b+eaNM1kgDiq3SS+6ZxqSfodlZrZINGR3CPWp5hL5l3cpEkHPPt2UA
         UanjGs5y+SE4ws0QJFwlwBTyzINXI0FmXPrC4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=U2jB1edyfeJdXl6ZftF/aza9s8Bhhrbadtieuq2bvXkJeQGADlxJZGggAO6mWNu2z1
         gWw3Zk+mie2Be5feaPMaIoGbPlnhuuo1u4juTq0X3C2ao9YjLmD4VWyvqa6NFZGRMssT
         eRU5yWODD2j6V+aK+MwMs4lOQPjVkUvu0lays=
Received: by 10.227.144.1 with SMTP id x1mr4447277wbu.199.1278481584469;
        Tue, 06 Jul 2010 22:46:24 -0700 (PDT)
Received: from vidovic (aqu33-8-83-155-187-36.fbx.proxad.net [83.155.187.36])
        by mx.google.com with ESMTPS id o54sm187122wej.29.2010.07.06.22.46.23
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 06 Jul 2010 22:46:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v8w5n2744.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150451>

The 06/07/10, Junio C Hamano wrote:
> Nicolas Sebrecht <nicolas.s.dev@gmx.fr> writes:
> 
> > @@ -22,7 +22,7 @@ static struct unpack_trees_error_msgs unpack_plumbing_errors = {
> 
> What word do you see before "errors" on the hunk comment line?

So you'd rather not touching it? Or wait until the next release cycle?
Or a better commit message? Anything else?

-- 
Nicolas Sebrecht
