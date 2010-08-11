From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git notes primer?
Date: Wed, 11 Aug 2010 00:10:36 -0500
Message-ID: <20100811051036.GA639@burratino>
References: <201008101040.07172.thomas@koch.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Thomas Koch <thomas@koch.ro>
X-From: git-owner@vger.kernel.org Wed Aug 11 07:12:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oj3c1-0003ze-Jl
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 07:12:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751807Ab0HKFMJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 01:12:09 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:52981 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751040Ab0HKFMH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Aug 2010 01:12:07 -0400
Received: by ywh1 with SMTP id 1so3963037ywh.19
        for <git@vger.kernel.org>; Tue, 10 Aug 2010 22:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=asANlsyNyFY1lDBZfbQEkBbz4wVCFOhk5atw4tjjjsk=;
        b=hBGGmcUOzXVaclmSV9Qrw9gECCrUuQzPx1j/1QpFY/b70fIycrgmRBsM8BglNjO4rU
         mYcEWD0Q7rxp59Jva8E/HIxnE1WqX9gZ5MCTCsPPN/UYncATbiGnMLpg/6jVRHwWn46P
         g48Re08mwfkxj2njpokotD2pFFCKsp69v20UY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=qeLYHSnb3NIwpBotKlHE8lADpGJzSLjvc1R5T37c5uL7y+450cXFprEMMXkOUIw1+t
         R2plaVC12mUDo4eeGW2Jpj08V3eZEcr/mf8v1a1qO//09+1EY1trEdIQtCAqEtLz2kR+
         rTahAeWmxoeUtohHuGPrUS/W5gnpN8uf6qdd0=
Received: by 10.100.128.15 with SMTP id a15mr21087541and.67.1281503526320;
        Tue, 10 Aug 2010 22:12:06 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id x33sm11852453ana.13.2010.08.10.22.12.04
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 10 Aug 2010 22:12:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201008101040.07172.thomas@koch.ro>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153187>

Hi Thomas,

Thomas Koch wrote:

> Before I continue with my current design, I wanted to have a look at =
git=20
> notes, whether it would provide better mechanisms then tracking my me=
ta=20
> informations in a hidden background branch. (Much like pristine-tar d=
oes.)

=E2=80=9Cgit notes=E2=80=9D associates arbitrary data to specific objec=
ts (blobs, trees,
commits, annotated tags).  If your metainformation is per-branch rather
than per-commit, then notes will probably not help you.

=46eel free to be inspired by their design, though. :)

Regards,
Jonathan
