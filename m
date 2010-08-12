From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 9/9] commit: suppress status summary when no changes
 staged
Date: Wed, 11 Aug 2010 19:10:13 -0500
Message-ID: <20100812001013.GB18499@burratino>
References: <20100725005443.GA18370@burratino>
 <20100725010230.GI18420@burratino>
 <201008110911.40133.trast@student.ethz.ch>
 <20100811073028.GA5450@burratino>
 <AANLkTi=DPu+roNsuWZARkK=cmKhcqMx=CDyiv6cf7tof@mail.gmail.com>
 <20100811235742.GA18499@burratino>
 <AANLkTikVyWjTmRssQyBfRVY=PLguTgHHA+_YdsmsMwP3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 12 02:12:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjLOy-0000kp-9y
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 02:12:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933229Ab0HLALt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 20:11:49 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:48193 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932871Ab0HLALr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Aug 2010 20:11:47 -0400
Received: by qwh6 with SMTP id 6so719373qwh.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 17:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=00fhTm7K+ZiXvqzVM7RwKVVf+rhI6KrRPUXuiXsdE+w=;
        b=dUEtLFE1t6yaYWgi1QHbR153kkLyRG3yAvYB62cOxRMW/iOWScwLsbeMN3AT02amzF
         80zGDddIKyil+kd90XvzEggATkh5YLDPoHd8wfUAHoNdlj/oWC/4cHp+F+1BAfGPQ8Cj
         G4npT9zvJhLrGiwWce+tdgTnty2ypySNwuipw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=uXQ0ZfYFnRj6RCTMD5LaZ8WiVfL2gXll8QHlJOrFkDP4PPGsEvE2r+87AP4IRkZ6c4
         gMZE/MR4UEWdhqbqkNZij9fSoCdh3Xvum7svHUUP96sfmdPggVCoecVUfrFvbpfRpB0Y
         u+gz5gtcCoUmSWwNZ+xWP23JAIYtkD+D4ho4w=
Received: by 10.220.99.21 with SMTP id s21mr11994446vcn.82.1281571905959;
        Wed, 11 Aug 2010 17:11:45 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id i40sm404407vcr.32.2010.08.11.17.11.44
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 11 Aug 2010 17:11:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikVyWjTmRssQyBfRVY=PLguTgHHA+_YdsmsMwP3@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153317>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Wed, Aug 11, 2010 at 23:57, Jonathan Nieder <jrnieder@gmail.com> w=
rote:

>> Did you see the follow-up patch?
>
> No, I'm probably missing something. Move along now, nothing to see
> here :)

I figured it out.  Gmail=E2=80=99s implementation of threading is (deli=
berately)
broken.

The follow-up has subject

  [PATCH v2] t6040 (branch tracking): check =E2=80=9Cstatus=E2=80=9D in=
stead of =E2=80=9Ccommit=E2=80=9D

> Sounds like you got this covered

Thanks again for a quick report and patch --- they were helpful
indeed.
