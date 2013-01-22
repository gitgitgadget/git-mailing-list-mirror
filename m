From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 05/10] sequencer.c: always separate "(cherry picked
 from" from commit body
Date: Tue, 22 Jan 2013 00:32:16 -0800
Message-ID: <20130122083216.GF6085@elie.Belkin>
References: <1358757627-16682-1-git-send-email-drafnel@gmail.com>
 <1358757627-16682-6-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, pclouds@gmail.com, git@vger.kernel.org,
	Brandon Casey <bcasey@nvidia.com>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 09:32:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxZHg-0006Uo-PZ
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 09:32:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753957Ab3AVIcW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 03:32:22 -0500
Received: from mail-da0-f44.google.com ([209.85.210.44]:44775 "EHLO
	mail-da0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754064Ab3AVIcV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 03:32:21 -0500
Received: by mail-da0-f44.google.com with SMTP id z20so3134333dae.17
        for <git@vger.kernel.org>; Tue, 22 Jan 2013 00:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=O/Z+17J1ZoQRC0edB3J3xWirYANkRSX9KgbFnqNwygo=;
        b=PuUDiiEc8ZUh5M+ALiM5aIaMGDIqrdHmJ63H0TpT2ROiBr3cucBQ27b1QOjQNCOpdB
         JAlXK/Iop/+6e2CxE9lOiKRiTslveTVos360581kU1ZMfqjNIzXrdFmnWk9FbKecdcYU
         LPpZ3qkZqgpCOZdZ0xnTsE02NLVqhdIDJD6rDTywPaeMhBVsCgGpCELvwq9rqBJqaPqG
         GZG17kq90kPOrxTm1CSMmvmOUr0ZrewqXZtj/tLvobgtP0hhpScQr5lJkOidrh6hW6uT
         VbXE2I4moSTwvr9hOqE6rSRr0DzgvY0AkfMrjLGr8NOREpeNY9tMBemf1/+tLRi0/RNC
         XRpQ==
X-Received: by 10.68.236.2 with SMTP id uq2mr36842015pbc.55.1358843541459;
        Tue, 22 Jan 2013 00:32:21 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id bi8sm10990408pab.15.2013.01.22.00.32.19
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 22 Jan 2013 00:32:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1358757627-16682-6-git-send-email-drafnel@gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214218>

Brandon Casey wrote:

> Start treating the "(cherry picked from" line added by cherry-pick -x
> the same way that the s-o-b lines are treated.  Namely, separate them
> from the main commit message body with an empty line.

Heh, you read my mind.
