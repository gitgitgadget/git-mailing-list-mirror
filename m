From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: git ignore regression in 1.8.3
Date: Wed, 29 May 2013 08:43:55 -0500
Message-ID: <CAMP44s2mstQOzrtR2tWxNTKE2b+_0xE0a2UtFCtpX-2H6m3JoQ@mail.gmail.com>
References: <CAPqtr1KjmqRZZuVwput6=rKJrivb7siYePqT5QEOLJApg+phEg@mail.gmail.com>
	<CACsJy8BT_3aUAO+eMT6F3SWwLOWeFwJ2rxxru-+NtBRD3RTSFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Nicolas_Despr=C3=A8s?= <nicolas.despres@gmail.com>,
	git <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 15:44:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uhgfd-00017L-05
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 15:44:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966184Ab3E2Nn6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 May 2013 09:43:58 -0400
Received: from mail-lb0-f171.google.com ([209.85.217.171]:59574 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935149Ab3E2Nn4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 May 2013 09:43:56 -0400
Received: by mail-lb0-f171.google.com with SMTP id v20so9069424lbc.30
        for <git@vger.kernel.org>; Wed, 29 May 2013 06:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=pqSvZf+OV7KeUYwyvfMPKe1knwHOa7cRVkaFbU6hwys=;
        b=dK1fwv9BUhXzUyunIG7FMADvuQBJPJ32orA6Ir61RFhRxmlAcIvxZi+ssDvNPBSwnL
         i/cK5HR1uyHzdcoAuC9wMmWtv4mJwBLesNC3mJmUyxwQD32zpZm+vW+wiJscvDm0StU+
         NEXHAA7fcSLvYZTksHisSqtYcvAus7kzfjgxwn8YNlZx8kuROdLPQ3/xfqkfSdu/Ve2x
         xx4H3JaVavS9RPmk1KIEcPOq0EOg1grVJqiMGOv8BST4uJYhqXfo3fOxTKiVD1yZKl7i
         EX/UyTjaZ7K70KJx4h8vv7BPGeP4WR9xL1IztrVW4jLZlvqyekvSs6z+vW4Sc+hU6/eh
         HUEA==
X-Received: by 10.152.2.233 with SMTP id 9mr1402674lax.34.1369835035471; Wed,
 29 May 2013 06:43:55 -0700 (PDT)
Received: by 10.114.177.164 with HTTP; Wed, 29 May 2013 06:43:55 -0700 (PDT)
In-Reply-To: <CACsJy8BT_3aUAO+eMT6F3SWwLOWeFwJ2rxxru-+NtBRD3RTSFw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225823>

On Wed, May 29, 2013 at 8:31 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Wed, May 29, 2013 at 7:31 PM, Nicolas Despr=C3=A8s
> <nicolas.despres@gmail.com> wrote:
>> I have noticed a regression in the behavior of ignore rules in 1.8.3=
=2E
>
> Yeah, it looks like everybody suddenly realizes this regression soon
> after the release, not before :(

That's because the vast majority of users only use the releases (maybe
more than 90%?). It's not a big deal, that's what 1.8.3.1 is for :)
(also, that's why we shouldn't worry to death about imaginary users,
our real users will gladly point out when we have screwed up).

--=20
=46elipe Contreras
