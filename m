From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 06/19] git_remote_helpers: push all refs during a
 non-local export
Date: Thu, 9 Jun 2011 10:29:57 +0200
Message-ID: <BANLkTincedbjH+ta6g7+uA3=3k_30RQaCg@mail.gmail.com>
References: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
 <1307558930-16074-7-git-send-email-srabbelier@gmail.com> <20110608194205.GI27715@elie>
 <20110608221908.GB15530@sigill.intra.peff.net> <20110609080912.GB4885@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 10:30:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUadZ-0003kk-4l
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 10:30:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756992Ab1FIIal convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Jun 2011 04:30:41 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:60845 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756052Ab1FIIai convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jun 2011 04:30:38 -0400
Received: by qyg14 with SMTP id 14so696699qyg.19
        for <git@vger.kernel.org>; Thu, 09 Jun 2011 01:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=Nt+OwBHxubWDdBVVs6AsihjEXP19VqqfAXWw2JS0chA=;
        b=uAR83l5chj6EcVz6fsw7T0b8kSLtt+lS85Bt1BSKmhaBqh1Fl5NGUMYd5yXz0PleBu
         dbV1y9mrZOYtp3PL4basFANS/kbMJnN4g8EIjWHuLOkiVrOX4j2KQ+pruNfnx3yE4C8w
         m6KNJGfMQYFvpInTO2nUhuF0tIIWp3smpByaA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=CKEU6MJmcbIIZzlXEQoEMpK5P8gk4HTKKrDGgOMLSHN1gVnhKaVFOcntT5vNn0mVvQ
         2zHWi+TlXpMX/MJy2bIYlm2GCOtko53RJkubm3wLb925y/6WqnrZW77+javWYmlUmoKd
         Ti87SfiD2j9iBE3wiBHIlomSl5hs9xLTnckg4=
Received: by 10.229.127.105 with SMTP id f41mr341232qcs.15.1307608237121; Thu,
 09 Jun 2011 01:30:37 -0700 (PDT)
Received: by 10.229.83.203 with HTTP; Thu, 9 Jun 2011 01:29:57 -0700 (PDT)
In-Reply-To: <20110609080912.GB4885@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175505>

Heya,

On Thu, Jun 9, 2011 at 10:09, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0export :1 refs/heads/foo
> =C2=A0 =C2=A0 =C2=A0 =C2=A0export :2 refs/heads/bar
> =C2=A0 =C2=A0 =C2=A0 =C2=A0export :3 +refs/heads/force
>
> with :1, :2, and :3 being marks in the fast-import stream.

The only problem there is that we don't know the relevant marks beforeh=
and.

--=20
Cheers,

Sverre Rabbelier
