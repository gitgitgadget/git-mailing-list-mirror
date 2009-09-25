From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 1/2] Make generated MSVC solution file open from Windows 
	Explorer
Date: Sat, 26 Sep 2009 00:11:13 +0200
Message-ID: <81b0412b0909251511m24e5c6bcg3f8c4e3576ad3bd3@mail.gmail.com>
References: <4ABB84F4.7080403@gmail.com> <20090925220510.GY14660@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org,
	mstormo@gmail.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Sep 26 00:11:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrJ0a-00082f-S2
	for gcvg-git-2@lo.gmane.org; Sat, 26 Sep 2009 00:11:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752428AbZIYWLL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Sep 2009 18:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751803AbZIYWLK
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Sep 2009 18:11:10 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:33446 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751718AbZIYWLK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Sep 2009 18:11:10 -0400
Received: by fxm18 with SMTP id 18so2546123fxm.17
        for <git@vger.kernel.org>; Fri, 25 Sep 2009 15:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=D97I+eyf2Hz0dMtygM//UC9TnxsjVu0Eqs1MEuk52pc=;
        b=bORv9V4dDuRRDVrO4h64AEgdE4Of9ZdAMQ6h3tcJ9IQF8XvBt1N/V9Q9jE4BOXrRwC
         tSUPuHALOlikZWyt17Cq4Im1i5hUycDSQoZ7qNA5+hCRtpX95MWtY7sOCxyVy8+6ue0U
         NqSYWICL1u1cDHfMFb/f/KEpul/mVCe9iKyss=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=gjWdD3hOIRcPrIUAgqBQ3LlevWaCF7a4bRB+Kg3ZEk5LXpGUEl4jXocvISSYI3hggX
         KLysa9C+hofBV7br1az9wbC2aYDSbGUPE4YJAXIbu6a7iOKxAzh7Qk4DG2niCYQy10aV
         ugX2ZFSVPZBPMZez2d5iDs7cMreTkKitkwtmg=
Received: by 10.204.8.155 with SMTP id h27mr583831bkh.55.1253916673267; Fri, 
	25 Sep 2009 15:11:13 -0700 (PDT)
In-Reply-To: <20090925220510.GY14660@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129126>

On Sat, Sep 26, 2009 at 00:05, Shawn O. Pearce <spearce@spearce.org> wr=
ote:
> Sebastian Schuberth <sschuberth@gmail.com> wrote:
>> In order to be able to open the generated solution file by double-cl=
icking it
>> in Windows Explorer, all project files need to use DOS line-endings =
and a
>> comment about the Visual Studio version needs to be added to the hea=
der of the
>> solution file. This also fixes the icon that is displayed for the so=
lution file
>> in Windows Explorer.
>> Note that opening the solution file from a running instance of Visua=
l Studio
>> already worked before.
>
> Something is wrong with both patches; neither applies. =C2=A0It looks
> to be an issue with whitespace, like context lines are gaining an
> extra space at the start of the line.

Besides, there is PERLIO environment variable. Try setting it to
PERLIO=3D':perlio'
