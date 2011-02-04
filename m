From: Tor Arntsen <tor@spacetec.no>
Subject: Re: [1.8.0] reorganize the mess that the source tree has become
Date: Fri, 4 Feb 2011 09:30:10 +0100
Message-ID: <AANLkTinQ13b9c1=SmMSC5ThjXcsSuMO2irwW04E+K=xY@mail.gmail.com>
References: <20110202022909.30644.qmail@science.horizon.com>
	<alpine.LFD.2.00.1102030036420.12104@xanadu.home>
	<AANLkTimnMDuAX-Ctc5K3mt=b2bz2FTsb_P7Fs8RzVwpd@mail.gmail.com>
	<AANLkTikhPRGZ9DxCWbWvBiac_DYiXYsnEdHVOnbHUdU4@mail.gmail.com>
	<87bp2sy2mf.fsf@catnip.gol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Hilco Wijbenga <hilco.wijbenga@gmail.com>, git@vger.kernel.org,
	Nicolas Pitre <nico@fluxnic.net>,
	George Spelvin <linux@horizon.com>,
	Eugene Sajine <euguess@gmail.com>
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Fri Feb 04 09:30:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlH3Z-0001yH-7f
	for gcvg-git-2@lo.gmane.org; Fri, 04 Feb 2011 09:30:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752750Ab1BDIaM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Feb 2011 03:30:12 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:56830 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752429Ab1BDIaL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Feb 2011 03:30:11 -0500
Received: by qyk12 with SMTP id 12so1756802qyk.19
        for <git@vger.kernel.org>; Fri, 04 Feb 2011 00:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Z9DRO3R527oUW3uqYDwGuV1sxZUA6kpo7ikK744+w44=;
        b=nH6XunnMrXYGwapnarlQZte18XfQUi+VhZ7bBJayWMcm/EwORgeRduSKxDnLglM2Xe
         quLaP4FGjipZelbiazkRmsxw/2eDzKtwFx49AxI8uy0mlzNZ9eoL8zg8l9dUhFprFwVL
         3ZNcQYoD2m9lEP/BkMDSJDvHpX70nITsXhjBs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=QtISY32H6O9GXJVITSKhGhdRO/Tw5CoLGAPtonz66UKIBmHCBWF5JCspqyElNv0VqO
         r9lZVRkRub0x/o6JGtOgGJL3Rhi933Ohjyd/7HLUfy8xySsmC2fvYdltn8cBmvCXLHHT
         m7/YQg2xQQ0FaCfsvX5f2bm0x/RplsO5hRUH4=
Received: by 10.229.185.210 with SMTP id cp18mr9399901qcb.187.1296808210210;
 Fri, 04 Feb 2011 00:30:10 -0800 (PST)
Received: by 10.229.100.66 with HTTP; Fri, 4 Feb 2011 00:30:10 -0800 (PST)
In-Reply-To: <87bp2sy2mf.fsf@catnip.gol.com>
X-Google-Sender-Auth: g_tibvi-OtQMyTmkoyF5n9s9wCk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166025>

On Fri, Feb 4, 2011 at 03:06, Miles Bader <miles@gnu.org> wrote:
> Hilco Wijbenga <hilco.wijbenga@gmail.com> writes:
>> Quite frankly, I'm surprised there are (presumably experienced)
>> developers who do not immediately see the value of a little
>> organization. Surely, given the use of code conventions, formatting
>> rules, etcetera, the obvious one step further is to also organize
>> where the files go?
>
> I think one of the problems is that what's been suggested seems like
> window-dressing. =A0Moving everything into src/ and calling it "organ=
ized"
> doesn't actually accomplish much other than perhaps making the README
> file more visible to newbs; things are _still_ a mess, just a mess wi=
th
> four more letters...

What Miles says is my feeling as well. And having a 'bin/' as was sugge=
sted
in one post doesn't make much sense to me either - if you want your com=
piled
output to go elsewhere than the source directory then the normal way of=
 doing
that is to do and out-of-tree build (so if that's not working - I have
not checked -
then that's something which would be worth looking into.)

-Tor
