From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH/RFC v3 6/8] Add case insensitivity support when using git ls-files
Date: Mon, 4 Oct 2010 16:41:40 +0000
Message-ID: <AANLkTin04o5GtYXWgo_Cpw+YNd23kwk7KjvrixjMk8KS@mail.gmail.com>
References: <4CA847D5.4000903@workspacewhiz.com>
	<1286099806-25774-7-git-send-email-avarab@gmail.com>
	<201010041802.57398.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Johannes Sixt <j6t@kdbg.org>, Brandon Casey <drafnel@gmail.com>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 18:41:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2o6m-00016i-00
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 18:41:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755993Ab0JDQlm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 12:41:42 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45451 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754622Ab0JDQll (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 12:41:41 -0400
Received: by iwn5 with SMTP id 5so7115320iwn.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 09:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=OVS/BsNhLiFCmbqCLPW6dyLmwcCGCv3q7ho1/GpjYxU=;
        b=AGGqYkM9dUeCB18/kATMZL3iJ8BbRIIUyIT/f/GT2lA9vkgwEG/wuKWFt8fnMkFZmb
         WKF+mfbaEZIZvc/1bAavzNCNi0XBz25d+GhhrvkzmzF3t17QKlwallnSGBK1aBzKsKdT
         oPTozQu9DyY7KA0D+Q3c/VPFou0FilnTB2fs8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=keI5pCKQV7c7GCRgThExuVs4I8a+zKKimns8gx9Hfy+v950skqGq7nxsNyEast5zaN
         eUeG+8ErEZQbjyoqIEEIKpxHqyh/5+35F57JqvjFSBvGlKhv9aEtf6H2U9C4BzGAHHWq
         8DliHp/qJaL8UP7GrHayDGbjsTz9ZOoc63AGQ=
Received: by 10.231.39.205 with SMTP id h13mr10422544ibe.148.1286210500685;
 Mon, 04 Oct 2010 09:41:40 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Mon, 4 Oct 2010 09:41:40 -0700 (PDT)
In-Reply-To: <201010041802.57398.robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158063>

On Mon, Oct 4, 2010 at 16:02, Robin Rosenberg
<robin.rosenberg@dewire.com> wrote:

> Is anyone thinking "unicode" around here?

Thinking yeah, doing the massive work to implement it: no.

It's much harder when you don't know what encoding the data is in,
encoding is only by repository convention in Git.
