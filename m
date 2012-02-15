From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 3/3 v5] diff --stat: use less columns for change counts
Date: Wed, 15 Feb 2012 19:12:20 +0700
Message-ID: <CACsJy8D4sWm8iprprbjU7X5RyPE4fbqiU2f70idByRmpkh70wA@mail.gmail.com>
References: <7vpqdg3n7z.fsf@alter.siamese.dyndns.org> <1329303808-16989-1-git-send-email-zbyszek@in.waw.pl>
 <1329303808-16989-3-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com,
	Michael J Gruber <git@drmicha.warpmail.net>
To: =?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Wed Feb 15 13:13:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxdjF-0004IV-UG
	for gcvg-git-2@plane.gmane.org; Wed, 15 Feb 2012 13:12:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755945Ab2BOMMx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Feb 2012 07:12:53 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:35056 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752250Ab2BOMMw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Feb 2012 07:12:52 -0500
Received: by wics10 with SMTP id s10so465283wic.19
        for <git@vger.kernel.org>; Wed, 15 Feb 2012 04:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=t2IQtUIxXHUd0W/iMquA624K+Qif4Kw4xGKFlQHLNFs=;
        b=ggzcv3eyH9s5XlX/+VvSFgUPfhYoDz4lEvP0prG0VH21QcMdYLsGGL+fKtp5S7o01w
         Nh7qQTn81mTzrfjt/405sQd2YVsKWlgQNMkirISUgk+ZU9gdgcHWiLNg/qApxlrGARRr
         0UOoxbcVts9qmMFkkPCHIM+VVycmirt5v23l0=
Received: by 10.180.86.9 with SMTP id l9mr35201802wiz.15.1329307971288; Wed,
 15 Feb 2012 04:12:51 -0800 (PST)
Received: by 10.223.2.139 with HTTP; Wed, 15 Feb 2012 04:12:20 -0800 (PST)
In-Reply-To: <1329303808-16989-3-git-send-email-zbyszek@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190827>

2012/2/15 Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>:
> Number of columns required for change counts is computed based on the
> maximum number of changed lines. This means that usually a few more
> columns will be available for the filenames and the graph.

If the required number of columns is less than 80 (or even lower), can
we maintain current spacing strategy? I just want to avoid mass
updates in the test suite. More or less space does not make much
different for narrow diffstats anyway.
--=20
Duy
