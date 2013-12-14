From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v5 02/14] add a hashtable implementation that supports
 O(1) removal
Date: Fri, 13 Dec 2013 18:04:13 -0800
Message-ID: <20131214020413.GB2311@google.com>
References: <52851FB5.4050406@gmail.com>
 <528521E2.7090305@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <tr@thomasrast.ch>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 14 03:04:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vreaf-0000zL-MO
	for gcvg-git-2@plane.gmane.org; Sat, 14 Dec 2013 03:04:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753155Ab3LNCEU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Dec 2013 21:04:20 -0500
Received: from mail-yh0-f50.google.com ([209.85.213.50]:52591 "EHLO
	mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753079Ab3LNCET (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Dec 2013 21:04:19 -0500
Received: by mail-yh0-f50.google.com with SMTP id b6so2178564yha.37
        for <git@vger.kernel.org>; Fri, 13 Dec 2013 18:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=98eJaG3ypnjqVcbygbHW+ubIcKXsRj7mjd9cWswLuRg=;
        b=x9GcZWBPbm6VLDsjlcMMHutxcf23buQXpZz62a6WrmaV2Bmrwbg+vu3O/bClrwdfy8
         rbgtAoT1EmZg/1nX1cTFzIEMq1Jp/YqdV477XFk/52eyjknp0CTlHohls84ZlIlvJJr5
         1/ru9Qb6r2TpH+r74LG+gJF41xf2KVGLHUanNQNWHc+IdsCHYupa5ofsekBjNfTkaa/p
         XYTWSvOEuZ0IBOPFKQEdDA1fWCUkpEJ/c89KwH65+ePCDJWiC3yn3WsDikk02u/VKbcY
         8h+6qY3tPCgZmlOA5JHzCMDBTEgMChBcCBLZC4Vni0FUOL9mvU2is5ioedURHHW/TZr5
         M5ww==
X-Received: by 10.236.144.194 with SMTP id n42mr4851290yhj.114.1386986657058;
        Fri, 13 Dec 2013 18:04:17 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id r64sm6179907yhc.23.2013.12.13.18.04.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 13 Dec 2013 18:04:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <528521E2.7090305@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239273>

Hi,

Karsten Blees wrote:

>  test-hashmap.c                          | 340 ++++++++++++++++++++++++++++++++

Here come two small tweaks on top (meant for squashing in or applying
to the series, whichever is more convenient).

Thanks,
Jonathan Nieder (2):
  Add test-hashmap to .gitignore
  Drop unnecessary #includes from test-hashmap

 .gitignore     | 1 +
 test-hashmap.c | 3 +--
 2 files changed, 2 insertions(+), 2 deletions(-)
