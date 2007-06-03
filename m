From: "Dana How" <danahow@gmail.com>
Subject: Re: What's cooking in git.git (topics)
Date: Sun, 3 Jun 2007 14:20:43 -0700
Message-ID: <56b7f5510706031420j153f5f36v64e296b3f098f38@mail.gmail.com>
References: <7v646wqrvm.fsf@assigned-by-dhcp.cox.net>
	 <7vfy5wcnbg.fsf@assigned-by-dhcp.cox.net>
	 <7vd50xz7lq.fsf@assigned-by-dhcp.cox.net>
	 <7vodkb1adr.fsf@assigned-by-dhcp.cox.net>
	 <7virac547s.fsf@assigned-by-dhcp.cox.net>
	 <7v6466oygl.fsf@assigned-by-dhcp.cox.net>
	 <alpine.LFD.0.99.0706031703140.12885@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org,
	danahow@gmail.com
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Sun Jun 03 23:21:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuxVj-0006nU-MM
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 23:21:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987AbXFCVUv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 17:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbXFCVUv
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 17:20:51 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:34627 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987AbXFCVUu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 17:20:50 -0400
Received: by ug-out-1314.google.com with SMTP id j3so600575ugf
        for <git@vger.kernel.org>; Sun, 03 Jun 2007 14:20:48 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=THGWwRy2p7CPWiyuEp5a6hLIEzvP82c3uNRzhG9z2b2RskBuTWJFv8psj6lmtRAUO9R8mQLUsRRKsoUz3UgQaetaLbUiHXO+W67AA/gKTBzIKQxKRpe0B0VHBJjXjwbe1pba0UxQ9SltySt8bEYc4aUa26jJANbFe2HQJcoz+2I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Q0dvd91UrP+6pZHaDSxNufkxilY6dQORxSWft7y2/2UVf03EGLgIeqbMAXoXWSUhlTGqoKhbsqyb3l0vTWkM4hGKwbXlzhhwBHD7+oVoinhShEsAX8k+cDryGivzFuAKFTJd+1eGhEEpZmYWmCQel22nujzPrhasVzSeB8hHTbo=
Received: by 10.78.179.12 with SMTP id b12mr1787846huf.1180905648293;
        Sun, 03 Jun 2007 14:20:48 -0700 (PDT)
Received: by 10.78.90.18 with HTTP; Sun, 3 Jun 2007 14:20:43 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.99.0706031703140.12885@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49037>

On 6/3/07, Nicolas Pitre <nico@cam.org> wrote:
> On Sat, 2 Jun 2007, Junio C Hamano wrote:
> > * dh/repack (Fri May 25 14:40:24 2007 -0700) 1 commit
> >  - Enhance unpack-objects for live repo and large objects
> >
> > I saw nobody other than Dana jump up and down and say we must
> > have this, so I still parked this in 'pu' without merging it to
> > 'next'.  Maybe a time for a quick poll?
>
> I did provide a followup comment to this patch.  If the concerns I
> raised are addressed then I won't be against such a patch.

Hmm, I thought only your comments about incoherency were
still unaddressed and they applied only to the degunking patch,
but in any case I was planning to improve both patches in similar ways.
I won't be able to do this for a week or two (crunch time here).
I will first review the discussion for each patch in case my memory is wrong.

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
