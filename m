From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Stitching together two split segments from svn
Date: Fri, 25 Jul 2008 09:21:28 +0200
Message-ID: <200807250921.35412.jnareb@gmail.com>
References: <654935030807241633g763e622br4feb8b4e23ee64e2@mail.gmail.com> <m3ljzqvo6i.fsf@localhost.localdomain> <654935030807241941p620201a2q21bb4513cd21225d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Liam Healy" <lnp@healy.washington.dc.us>
X-From: git-owner@vger.kernel.org Fri Jul 25 09:22:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMHdc-0008Bu-Ns
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 09:22:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbYGYHVx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 03:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750867AbYGYHVx
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 03:21:53 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:5650 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753AbYGYHVw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 03:21:52 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1212452nfc.21
        for <git@vger.kernel.org>; Fri, 25 Jul 2008 00:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=LM40bJjSkicYyevymsU9twrYnu3TKMP3FWhFeml3SsE=;
        b=W3gKng/Cm7xoIZoj4ToTmSY5Q4ubPLBGqf8n7jQXOOrFqEaqfiVFjo+qtsho+U12Ua
         z9X4La/SWz45gixwUWeedJG44u0AKDDMqKv+nMGsVLbKBWq4A2Uo/z5f/HBdEt8B8pWK
         VMhneRhtyTlOcRsv/vp/AmWatIxBodwpCsS8Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=M+jPXmZT9KjeHwKqIHaTMQo+kohhU4V2P2xB7RHYui+RePPWP3dCuh/5dXGuDT0r/3
         uiY4nm5I1enukkQmTftAaZst4V0Q0y91GaAdOVBo6MWzk0ppoFhuRQwhsjZbZShFvrXw
         G1wpQ4zx08YhxYhWDkRyjs5iAZ3molRSuu9Tk=
Received: by 10.210.71.13 with SMTP id t13mr1547643eba.42.1216970509594;
        Fri, 25 Jul 2008 00:21:49 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.243.125])
        by mx.google.com with ESMTPS id y34sm14830297iky.10.2008.07.25.00.21.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 25 Jul 2008 00:21:47 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <654935030807241941p620201a2q21bb4513cd21225d@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90006>

On Fri, 25 Jul 2008, Liam Healy wrote:
> 
> Thanks for the advice -- this did exactly what I wanted.
> 
> For anyone else wanting to do this: one thing that threw me for a
> while was that .git/info/grafts does not accept an abbreviated SHA,
> the full 40 hex digits is needed.  I would see "bad graft data" from
> gitk with no other explanation.  There is very little documentation
> that I could find on the grafts file; the best I could find was in the
> man page for git-filter branch:
>
>   http://www.kernel.org/pub/software/scm/git/docs/git-filter-branch.html.

You can find definition of grafts in `gitglossary', and where you can
find them together with description of grafts file format in
`gitrepository-layout'
-- 
Jakub Narebski
Poland
