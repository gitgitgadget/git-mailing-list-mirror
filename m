From: Valeo de Vries <valeo@valeo.co.cc>
Subject: Re: Silent maintenance
Date: Sat, 14 Aug 2010 17:33:44 +0100
Message-ID: <AANLkTimZ4df7wVXSGdNm+vWgAuPVDcUupxEvn9FByx=P@mail.gmail.com>
References: <20100814131156.GA24769@nibiru.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: weigelt <weigelt@metux.de>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 14 18:34:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkJgK-0000Uj-M0
	for gcvg-git-2@lo.gmane.org; Sat, 14 Aug 2010 18:34:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757077Ab0HNQds convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Aug 2010 12:33:48 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:60694 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756836Ab0HNQdr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Aug 2010 12:33:47 -0400
Received: by wyb32 with SMTP id 32so3894200wyb.19
        for <git@vger.kernel.org>; Sat, 14 Aug 2010 09:33:46 -0700 (PDT)
Received: by 10.216.165.16 with SMTP id d16mr2626016wel.0.1281803626279;
        Sat, 14 Aug 2010 09:33:46 -0700 (PDT)
Received: from mail-wy0-f174.google.com (mail-wy0-f174.google.com [74.125.82.174])
        by mx.google.com with ESMTPS id u11sm2250857weq.7.2010.08.14.09.33.45
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 14 Aug 2010 09:33:45 -0700 (PDT)
Received: by wyb32 with SMTP id 32so3894170wyb.19
        for <git@vger.kernel.org>; Sat, 14 Aug 2010 09:33:44 -0700 (PDT)
Received: by 10.227.138.5 with SMTP id y5mr2540654wbt.204.1281803624179; Sat,
 14 Aug 2010 09:33:44 -0700 (PDT)
Received: by 10.227.137.196 with HTTP; Sat, 14 Aug 2010 09:33:44 -0700 (PDT)
In-Reply-To: <20100814131156.GA24769@nibiru.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153565>

On 14 August 2010 14:11, Enrico Weigelt <weigelt@metux.de> wrote:
> Hi,
>
> are there some flags to make the maintenance commands like
> git-repack and git-gc silent, so they only output errors ?

Just redirect stdout to /dev/null and check git's return status, as =C6=
var said.

Valeo
