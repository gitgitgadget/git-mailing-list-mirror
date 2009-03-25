From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCH 1/2] init: support --import to add all files and commit 
	right after init
Date: Wed, 25 Mar 2009 12:56:02 +0100
Message-ID: <adf1fd3d0903250456l3c14a863pd6ee00c0025100c4@mail.gmail.com>
References: <1237978720-2500-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 12:58:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmRkB-0003KU-Lu
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 12:58:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760977AbZCYL4J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Mar 2009 07:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759671AbZCYL4H
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 07:56:07 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:51871 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757678AbZCYL4F convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Mar 2009 07:56:05 -0400
Received: by bwz17 with SMTP id 17so2640419bwz.37
        for <git@vger.kernel.org>; Wed, 25 Mar 2009 04:56:02 -0700 (PDT)
Received: by 10.103.24.11 with SMTP id b11mr4145786muj.76.1237982162646; Wed, 
	25 Mar 2009 04:56:02 -0700 (PDT)
In-Reply-To: <1237978720-2500-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114593>

2009/3/25 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>=
:
> +-m <message>::
> +--import <message>::
> +
> +Commit everything to the newly initialized repository. This is equiv=
alent to:
> +
> +----------------
> +$ git init
> +$ git add .
> +$ git commit -q -m <message>
> +----------------
> +
> +If no message is given, "Initial commit" will be used.

Why a default message and not running the editor?

Santi
