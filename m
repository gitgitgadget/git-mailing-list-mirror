From: "Mark Ryden" <markryde@gmail.com>
Subject: Re: white spaces in a patch
Date: Wed, 17 Dec 2008 14:22:30 +0200
Message-ID: <dac45060812170422yc259d39vd1b198c1530a40a5@mail.gmail.com>
References: <dac45060812162331k19272488r4e95e0555e7a6db9@mail.gmail.com>
	 <bd6139dc0812170413j5ed2d9eak89df8517bc91c5fd@mail.gmail.com>
	 <dac45060812170413w7c8cffaifa1a0f3b649474e4@mail.gmail.com>
	 <200812171316.21531.thomas.jarosch@intra2net.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Sverre Rabbelier" <srabbelier@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Thomas Jarosch" <thomas.jarosch@intra2net.com>
X-From: git-owner@vger.kernel.org Wed Dec 17 13:33:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCvZz-0003uU-9G
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 13:32:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759194AbYLQMat (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 07:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759195AbYLQMas
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 07:30:48 -0500
Received: from yx-out-2324.google.com ([74.125.44.30]:52226 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759088AbYLQMar (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 07:30:47 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1534579yxm.1
        for <git@vger.kernel.org>; Wed, 17 Dec 2008 04:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=zdlrzMDSMUGnmfNR73KyYv3PxtyczP+In/2croonRTw=;
        b=dhWDRhjv8U5S9cHVi4MESOP2WekpV704qlHQGr9f9FwlOangQsLyqCIZhUlueJVuce
         bV+GLTaQGVBAgFVj/auQEOctNq5Go0SiP20IUhyVpSnKXtsxID6fd0gNWX3tIkiR0j+8
         vgvFWhWicBPUjcxNHFP5BS2Y+44Ei7X4ai+rI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=UO+Ft9X6hVRiIfc7otjff3LHQsRTVZlTDo+vMqySuSZKp4c2n/cSuurpUarv9nOWBV
         sbPvw+LPJUV4RXsTy4rxaTjgGlmM6jxPSw7tDc96ZDd7TrUpAVbPYrohqJvipt/GlEUN
         CyKn1+Vk42SGFx3tQxJnDtymR9wqbEtUy2vsY=
Received: by 10.90.67.10 with SMTP id p10mr192615aga.106.1229516550105;
        Wed, 17 Dec 2008 04:22:30 -0800 (PST)
Received: by 10.90.26.11 with HTTP; Wed, 17 Dec 2008 04:22:30 -0800 (PST)
In-Reply-To: <200812171316.21531.thomas.jarosch@intra2net.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103346>

Thnks!
In fact, the first line was enough!
git config --global color.diff auto
Mark



On Wed, Dec 17, 2008 at 2:15 PM, Thomas Jarosch
<thomas.jarosch@intra2net.com> wrote:
> On Wednesday, 17. December 2008 13:13:34 Mark Ryden wrote:
> [colors in diff]
>> What do you mean ?
>> where ? how ?
>
> This should do the trick:
>
> git config --global color.diff auto
> git config --global color.status auto
> git config --global color.branch auto
>
> Thomas
>
>
