From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/2] [RFD] Using gitrevisions :/search style with other
 operators
Date: Wed, 8 Dec 2010 12:06:05 -0600
Message-ID: <20101208180605.GD5687@burratino>
References: <1291820319-12455-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Kevin Ballard <kevin@sb.org>, Yann Dirson <dirson@bertin.fr>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 08 19:06:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQOPI-0006g4-Dp
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 19:06:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755721Ab0LHSGT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Dec 2010 13:06:19 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:37138 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755635Ab0LHSGS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Dec 2010 13:06:18 -0500
Received: by gyb11 with SMTP id 11so838519gyb.19
        for <git@vger.kernel.org>; Wed, 08 Dec 2010 10:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=LKes2bgkWGPspMShyNUsBlvUKGWhg6ODN4/tW5dcCzY=;
        b=ikLA6Ffas2UVlJCJzVK20s9n5uiFCr701PGznJG7aO8/xO525SLun98VrnEXcI6IO+
         EWpiKa9QNse1yN5hr9IhBWB6y2yAc2GVCoihZPPYcXXxGXOlBcP1lcvFQSQKweT3ehge
         VWmjP623/WJP4hwPVdnw6x9T1oawaS4aKqnHM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=oOsXMnne4nWSxy4HbEiYCkuhZ2COr0zDKzRFKKVE7vmFKMUEaRdaKVre0OA3QMQo3u
         17ACxzL1MAD+egJvVt30UpX63n3BVGLQRkoDrFCJ0GW/AGbsgoEFtalihAPdhhV6rTv4
         B+yv5qWNo79rf1XaV4Z1gj3NL6Mkm2NpeR00I=
Received: by 10.150.12.11 with SMTP id 11mr1923197ybl.443.1291831577731;
        Wed, 08 Dec 2010 10:06:17 -0800 (PST)
Received: from burratino (adsl-69-209-58-175.dsl.chcgil.ameritech.net [69.209.58.175])
        by mx.google.com with ESMTPS id q4sm913486ybe.0.2010.12.08.10.06.15
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 08 Dec 2010 10:06:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1291820319-12455-1-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163210>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> Let's start off from where the previous discussion [1] stopped. Peopl=
e
> seem to agree ref^{/regex} is a good choice. But we have not come to
> conclusion how to specify the count yet. Possible suggestions are
>
>  - ref^{/foo}2
>  - ref^{2/foo}
>  - ref^{:2/foo}
>  - ref^{2nd/foo}

How about

	ref^{/foo}^^{/foo}

?
