From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH 3/3] completion: add dirstat and friends to diff options
Date: Wed, 07 Oct 2009 17:11:44 -0700
Message-ID: <4ACD2E40.8010502@gmail.com>
References: <1254905331-29516-1-git-send-email-bebarino@gmail.com>	<1254905331-29516-2-git-send-email-bebarino@gmail.com>	<1254905331-29516-3-git-send-email-bebarino@gmail.com>	<20091007205059.GA16235@neumann>	<7vmy42pzvc.fsf@alter.siamese.dyndns.org> <20091007233442.GJ6055@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: =?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Oct 08 02:11:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mvgbv-0007Bw-0M
	for gcvg-git-2@lo.gmane.org; Thu, 08 Oct 2009 02:11:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754271AbZJHAKQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Oct 2009 20:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753936AbZJHAKP
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Oct 2009 20:10:15 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:39309 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753501AbZJHAKO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Oct 2009 20:10:14 -0400
Received: by ewy4 with SMTP id 4so2427155ewy.37
        for <git@vger.kernel.org>; Wed, 07 Oct 2009 17:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=/mw5/gDr4BmsPqdNtLSkKT6PziigeudirytqYGddxEs=;
        b=MvMOm/aeTGGlyI9dVFRVieWS6weW8GGL0/CLB40HIi0+IK4OQ5MkcPJu0Be4zIXoai
         NOl58k8fgnHsxhlZMfL7kzz7stDfGkqPiK5Kb1jXQ2jUhK/u5NUG2mPpPDuReqolVLBq
         Ch4tQoZ7IrREp4mrn2RKMn83vJg4OuzX511rs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=rdtTHDgvteGepXQUQAdXOBHjO+bM2dg3JbcTvBuR3yQJ5E4wq7+HEimEBRqQWbpHOy
         H1FPt2OnHH6vwNnjclHp9siSAjKr2WWfJGa9Kvgm19IYtoZY9syubC3nFuO1jkWP8FT6
         jrJkheEoyXlJ5cY2D/mDBAYSMYYkJOwvfBbZU=
Received: by 10.216.85.197 with SMTP id u47mr158587wee.133.1254960576082;
        Wed, 07 Oct 2009 17:09:36 -0700 (PDT)
Received: from ?192.168.1.2? (cpe-76-174-15-88.socal.res.rr.com [76.174.15.88])
        by mx.google.com with ESMTPS id p10sm413020gvf.14.2009.10.07.17.09.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 07 Oct 2009 17:09:35 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (X11/20090827)
In-Reply-To: <20091007233442.GJ6055@neumann>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129665>

SZEDER G=E1bor wrote:
> But there are no git log --stat=3D, --color-words=3D and --decorate=3D=
, but
> only --stat, --color-words and --decorate, and there are git log
> --pretty=3D and --format=3D, but no --pretty and --format.  I have no=
t
> looked at other commands yet.
>  =20

I guess this is because nobody has added these. Feel free to send a
follow up patch.
