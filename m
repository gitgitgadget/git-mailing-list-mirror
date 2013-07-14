From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 5/6] templates: Fix ASCII art in pre-rebase hook
Date: Sun, 14 Jul 2013 11:52:31 -0700
Message-ID: <20130714185231.GC4381@google.com>
References: <CAD77+gSX1ggBWHhGwxRUBPGQ6ONJd76SO-3tU05QT47iKCv9hg@mail.gmail.com>
 <1373818879-1698-1-git-send-email-richih.mailinglist@gmail.com>
 <1373818879-1698-6-git-send-email-richih.mailinglist@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Richard Hartmann <richih.mailinglist@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 14 20:52:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyRPU-0003op-HI
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 20:52:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752916Ab3GNSwh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jul 2013 14:52:37 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:41306 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752891Ab3GNSwg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 14:52:36 -0400
Received: by mail-pa0-f45.google.com with SMTP id bi5so10486315pad.4
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 11:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Q9b/2idBlsDzC2V0qbzecp19zdU3DqPiZNIfheRfC3k=;
        b=j3X3UhHszidy4WPaeZ0UDJvIQ9Qkxxh/ue97IYzdisoHLUlki795hwC29SoYchFUn0
         gLGiShftUd5NUSjEGCvtrJIFCuZH3LMprv9MB/GJrt2fisOKkl5E/Xh41y+pTnR7timl
         JN1XbyOwlPJZrVRK1/w3hzJ9PcQyw2lDpeqfEOWsEiLNR4Tg8JKVTbCi5YX8xeC2rsAh
         G7/tBokxGuMY59EwIBkeauD/DBqgGkIFch2VQMGQ+2sqgNFZtbnuN4kJVyuVuh07crhM
         +clNItZC+nnUhfxPW9FtA1f8GvsdOziONTkcK8Cl14HNIWCYOe9IEkdYSkAohz6tfs0W
         OUgg==
X-Received: by 10.66.233.73 with SMTP id tu9mr1898448pac.124.1373827955048;
        Sun, 14 Jul 2013 11:52:35 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id td4sm60049111pac.20.2013.07.14.11.52.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 11:52:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1373818879-1698-6-git-send-email-richih.mailinglist@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230381>

Richard Hartmann wrote:

> The example assumes 8-char wide tabs and breaks for people with
> 4-char wide tabs. Convert all of those tabs to whitespace, instead.

Makes sense --- we cannot assume much about the end-user's editor
setup used to look at sample hooks.

Thanks.
